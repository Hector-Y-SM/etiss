import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

//clase para manejar el servicio de autenticacion de firebase
class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  User? get currentUser => firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => firebaseAuth.authStateChanges();

  Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  Future<UserCredential> createAccount({
    required String email,
    required String password,
    required String name,
    required String lastName,
  }) async {
    // guardar los datos en la coleccion y en el servicio
    UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email, 
      password: password,
    );

    User? user = userCredential.user;

    if (user != null) {
      await user.updateDisplayName("$name $lastName");

      await firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': name,
        'lastName': lastName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    return userCredential;
  }

  Future<Map<String, dynamic>?> getUserProfile() async {
    User? user = firebaseAuth.currentUser;

    if (user != null) {
      DocumentSnapshot docSnapshot = await firestore.collection('users').doc(user.uid).get();
 
      if (docSnapshot.exists) {
        return docSnapshot.data() as Map<String, dynamic>;
      }
    }

    return null;
  }

  Future<void> signOut() async {
    await firebaseAuth.signOut(); 
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUserProfile({
    required String name,
    required String lastName,
    required String email,
    String? username,
  }) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) return;

    try {
      // TODO: Reautenticación requerida antes de cambiar el email
      if (currentUser.email != email) {
        throw FirebaseAuthException(
          code: 'requires-recent-login',
          message: 'necesitas reautenticación para cambiar el correo.',
        );
      }

      username = '${name} ${lastName}';
      await currentUser.updateDisplayName(username);
      await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).update({
        'name': name,
        'lastName': lastName
      });

      print("Usuario actualizado correctamente");

    } on FirebaseAuthException catch (e) {
      print("Error de autenticación: ${e.message}");
      throw Exception("Error: ${e.message}");
    } catch (e) {
      print("Error general: $e");
      throw Exception("Error desconocido: $e");
    }
  }

  Future<void> deleteAccount({
    required String email,
    required String password,
  }) async {
    AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

    await currentUser!.reauthenticateWithCredential(credential);
    await currentUser!.delete();
    await firebaseAuth.signOut();
  }
}