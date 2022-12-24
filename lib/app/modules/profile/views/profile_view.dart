import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrbj_app/app/routes/app_pages.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Obx(() => Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        controller.isLoggin.value == true ? controller.userInfo!.name : '-',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Text(
                        controller.isLoggin.value == true ? controller.userInfo!.email : '-',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 50,
                ),
                // ListTile(
                //     title: Text("Ganti Password"),
                //     trailing: Wrap(
                //       spacing: 12, // space between two icons
                //       children: <Widget>[
                //         Icon(Icons.arrow_forward_ios), // icon-1
                //       ],
                //     )),
                // Divider(color: Colors.grey),
                controller.authProvider.isLoggedIn.value == true && controller.authProvider.userLogged.role == 1
                    ? ListTile(
                        onTap: () {
                          Get.toNamed(Routes.ATTENDANCE_LIST);
                        },
                        title: Text("Data Kehadiran"),
                        trailing: Wrap(
                          spacing: 12, // space between two icons
                          children: <Widget>[
                            Icon(Icons.arrow_forward_ios), // icon-1
                          ],
                        ))
                    : Container(),
                ListTile(
                    onTap: () {
                      controller.logout();
                    },
                    title: Text("Keluar"),
                    trailing: Wrap(
                      spacing: 12, // space between two icons
                      children: <Widget>[
                        Icon(Icons.arrow_forward_ios), // icon-1
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
