import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;

  const EmailTextField({
    required this.controller,
    required this.textInputAction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'example@gmail.com',
        prefixIcon: Icon(CupertinoIcons.mail_solid),
        suffixIcon: IconButton(
          focusNode: FocusNode(skipTraversal: true),
          onPressed: () => controller.clear(),
          icon: Icon(CupertinoIcons.clear),
        ),
        helperText: ' '
      ),
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Email không được để trống!';
        }
        final emailRegex = RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        );
        if (!emailRegex.hasMatch(value)) {
          return 'Email không đúng định dạng!';
        }
        return null;
      },
    );
  }
}