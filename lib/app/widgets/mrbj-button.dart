import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class MrbjButton extends StatefulWidget {
  final bool loading;
  final Function() onPressed;
  final String label;
  const MrbjButton({required this.label, required this.onPressed, required this.loading, Key? key})
      : super(key: key);

  @override
  _MrbjButtonState createState() => _MrbjButtonState();
}

class _MrbjButtonState extends State<MrbjButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 40,
        width: MediaQuery.of(context).size.width - 32,
        decoration: BoxDecoration(
            color: appThemeData.primaryColor, borderRadius: BorderRadius.circular(20)),
        child: TextButton(
          onPressed: widget.onPressed,
          child: widget.loading == true
              ? Container(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Text(
                  widget.label,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
        ));
  }
}
