import 'package:flutter/material.dart';

class InputFile extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final String? hintText;
  final String? Function(String?)? validator;

  const InputFile({
    super.key,
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.hintText,
    this.validator,
  });

  @override
  State<InputFile> createState() => _InputFileState();
}

class _InputFileState extends State<InputFile> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _isObscured,
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
                  onPressed: _toggleVisibility,
                )
              : null,
        ),
        validator: widget.validator,
      ),
    );
  }
}
