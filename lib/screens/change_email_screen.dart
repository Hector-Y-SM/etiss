import 'package:app/screens/change_password.dart';
import 'package:app/screens/profile_data.dart';
import 'package:app/widgets/navigation_buttons.dart';
import 'package:flutter/material.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final List<Widget> pages = [
    const ProfileData(),
    const ChangePasswordScreen(),
    const ChangeEmailScreen()
  ];

  final List<IconData> sectionIcons = [
    Icons.person,
    Icons.lock,
    Icons.mail
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("email change screen"),),
      body: NavigationButtons(
                pages: pages,
                icons: sectionIcons,
                currentIndex: 2,
      ),
    );
  }
}