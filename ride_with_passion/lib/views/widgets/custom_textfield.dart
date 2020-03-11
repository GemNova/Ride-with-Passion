import 'package:flutter/material.dart';
import 'package:ride_with_passion/styles.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final String errorText;
  final bool obscure;
  final TextInputType keyboardType;
  final Function(String) validator;

  final TextEditingController controller;
  final Function(String) onSave;
  final int minLines;
  const CustomTextField({
    Key key,
    this.hint,
    this.label,
    this.controller,
    this.onSave,
    this.minLines,
    this.errorText,
    this.obscure = false,
    this.validator,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextFormField(
              keyboardType: keyboardType,
              obscureText: obscure,
              style: medium20sp,
              controller: controller,
              minLines: minLines,
              maxLines: minLines ?? 1,
              onSaved: onSave,
              validator: validator,
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                hintText: hint,
                hintStyle: medium18sp,
                errorMaxLines: 2,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(24.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
