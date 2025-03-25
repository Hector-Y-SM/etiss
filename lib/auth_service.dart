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

  Future<void> signOut() async {
    await firebaseAuth.signOut(); 
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> updateUsername({
    required String username,
  }) async {
    await currentUser!.updateDisplayName(username);
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