import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mrbj_app/app/core/theme/app_theme.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appThemeData.primaryColor,
      ),
      body: Center(
        child: Text(
          'Coming Soon...',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
