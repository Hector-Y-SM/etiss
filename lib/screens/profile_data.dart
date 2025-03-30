import 'package:app/models/auth_service.dart';
import 'package:app/screens/change_email_screen.dart';
import 'package:app/screens/change_name.dart';
import 'package:app/screens/change_password.dart';
import 'package:app/screens/login.dart';
import 'package:app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({super.key});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  final _emailController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    var profile = await authService.value.getUserProfile();
    if (profile != null) {
      setState(() {
        _emailController.text = profile['email'];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(62, 75, 81, 1),
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: const Color.fromRGBO(62, 75, 81, 1),
      ),
      drawer: const CustomDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildProfileView(),
                ),
              ),
            ),
    );
  }

Widget _buildProfileView() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [

      CircleAvatar(
        radius: 50,
        backgroundColor: Colors.grey.shade300,
        child: Icon(Icons.person, size: 60, color: Colors.grey.shade600),
      ),
      const SizedBox(height: 20),

      Text(
        "${authService.value.currentUser!.displayName}",
        style: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 5),

      Text(
        _emailController.text,
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: Colors.grey.shade600,
        ),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 30),

      _buildProfileButton(
        icon: Icons.person_outline,
        label: "Editar Nombre",
        onTap: () {
          _showChangeUserNamedBottomSheet(context);
        },
      ),

      _buildProfileButton(
        icon: Icons.email_outlined,
        label: "Editar Correo",
        onTap: () {
          _showChangeEmailUserBottomSheet(context);
        },
      ),

      _buildProfileButton(
        icon: Icons.lock_outline,
        label: "Cambiar Contraseña",
        onTap: () {
          _showChangePasswordBottomSheet(context);
        },
      ),

      _buildProfileButton(
        icon: Icons.login_outlined, 
        label: 'cerrar sesion', 
        onTap: (){
          _navigateTo(context, LoginScreen(), authService.value.signOut()); 
        })
    ],
  );
}

Widget _buildProfileButton({required IconData icon, required String label, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black87, size: 24),
          const SizedBox(width: 15),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}

void _showChangePasswordBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, 
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)), 
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, 
        ),
        child: const ChangePasswordScreen(),
      );
    },
  );
}

void _showChangeUserNamedBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, 
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)), 
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, 
        ),
        child: const ChangeName(),
      );
    },
  );
}

void _showChangeEmailUserBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, 
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)), 
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, 
        ),
        child: const ChangeEmailScreen(),
      );
    },
  );
}

  void _navigateTo(BuildContext context, Widget screen, [Future<void>? action]) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
