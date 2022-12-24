import 'package:flutter/material.dart';

class MrbjTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? hintText;
  final bool? alignLabelWithHint;
  final bool? required;
  final int? maxLines;
  final bool? readOnly;
  final bool? obscureText;
  final String? confirmPassword;
  final Function()? onTap;

  const MrbjTextField(
      {required this.controller,
      required this.labelText,
      this.hintText,
      this.alignLabelWithHint,
      this.required,
      this.maxLines,
      this.onTap,
      this.readOnly,
      this.confirmPassword,
      this.obscureText,
      Key? key})
      : super(key: key);

  @override
  _MrbjTextFieldState createState() => _MrbjTextFieldState();
}

class _MrbjTextFieldState extends State<MrbjTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 12.0, left: 16, right: 16),
      child: TextFormField(
        onTap: widget.onTap,
        obscureText: widget.obscureText == null || widget.readOnly == false ? false : true,
        controller: widget.controller,
        readOnly: widget.readOnly == null || widget.readOnly == false ? false : true,
        validator: (value) {
          if (widget.required == true) {
            if (value == null || value.isEmpty == true) {
              return 'Tidak boleh kosong';
            }
          }

          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        maxLength: widget.maxLines,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            labelText: widget.labelText,
            alignLabelWithHint: true,
            hintText: widget.hintText),
      ),
    );
  }
}
