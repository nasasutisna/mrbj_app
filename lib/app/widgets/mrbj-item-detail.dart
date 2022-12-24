import 'package:flutter/material.dart';

class MRBJItemDetail extends StatelessWidget {
  final String title;
  final String text;
  const MRBJItemDetail({Key? key, required this.text, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(this.title),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Text(
              this.text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
