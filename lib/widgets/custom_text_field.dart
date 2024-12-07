import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // For SVG icons

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String iconPath;
  final bool isPasswordField;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.iconPath,
    this.isPasswordField = false,
    this.controller,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.green,
      controller: widget.controller,
      obscureText: widget.isPasswordField && !_isPasswordVisible,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.7),
          fontSize: 14,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgPicture.asset(
            widget.iconPath,
            color: Colors.white,
          ),
        ),
        suffixIcon: widget.isPasswordField
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.green,
            width: 2,
          ),
        ),
      ),
    );
  }
}
