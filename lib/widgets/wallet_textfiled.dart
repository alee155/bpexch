import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAmountTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final String hintText; // Add hintText parameter

  const CustomAmountTextField({
    required this.focusNode,
    required this.controller,
    required this.hintText, // Add this to the constructor
    super.key,
    required Null Function(dynamic value) onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        cursorColor: Colors.green,
        focusNode: focusNode,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset(
              'assets/icons/rs.svg',
              height: 24,
              width: 24,
            ),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.green,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
        ),
        onTap: () {
          // Unfocus other field when tapped
          if (focusNode.hasFocus) {
            focusNode.unfocus();
          }
        },
      ),
    );
  }
}

class CustomAccountDetailsTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;

  const CustomAccountDetailsTextField({
    required this.focusNode,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        controller: controller,
        cursorColor: Colors.green,
        focusNode: focusNode,
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Enter account details",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20,
          ),
        ),
        onTap: () {
          // Unfocus other field when tapped
          if (focusNode.hasFocus) {
            focusNode.unfocus();
          }
        },
      ),
    );
  }
}
