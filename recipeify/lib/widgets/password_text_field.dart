import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;
  final void Function(String)? onFieldSubmitted;

  const PasswordTextField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.textInputAction,
    this.validator,
    this.onFieldSubmitted,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<PasswordTextField> {
  bool isHide = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: Icon(CupertinoIcons.lock_fill),
        suffixIcon: IconButton(
          focusNode: FocusNode(skipTraversal: true),
          onPressed: () {
            setState(() {
              isHide = !isHide;
            });
          },
          icon: Icon(
            isHide
                ? CupertinoIcons.eye_fill
                : CupertinoIcons.eye_slash_fill,
          ),
        ),
        helperText: ' ',
      ),
      obscureText: isHide,
      textInputAction: widget.textInputAction,
      validator: widget.validator ?? (value) {
        if (value == null || value.isEmpty) {
          return 'Mật khẩu không được để trống!';
        }
        if (value.length < 6) {
          return 'Mật khẩu phải có tối thiểu 6 ký tự!';
        }
        return null;
      },

      onFieldSubmitted: widget.onFieldSubmitted,
    );
  }
}
