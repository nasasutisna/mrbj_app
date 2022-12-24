import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/coming_soon_controller.dart';

class ComingSoonView extends GetView<ComingSoonController> {
  const ComingSoonView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'COMING SOON...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
