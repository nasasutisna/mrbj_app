import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mrbj_app/app/core/theme/app_theme.dart';
import 'package:mrbj_app/app/modules/attendance/views/attendance_view.dart';
import 'package:mrbj_app/app/modules/home/views/home_view.dart';
import 'package:mrbj_app/app/modules/login/views/login_view.dart';
import 'package:mrbj_app/app/modules/profile/views/profile_view.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return PersistentTabView(
        context,
        controller: controller.tabs,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        backgroundColor: appThemeData.primaryColor, // Default is Colors.white.
        handleAndroidBackButtonPress: true, // Default is true.
        resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true, // Default is true.
        hideNavigationBarWhenKeyboardShows:
            true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        decoration: NavBarDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: ItemAnimationProperties(
          // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle:
            NavBarStyle.style15, // Choose the nav bar style with this property.
      );
    });
  }

  List<Widget> _buildScreens() {
    Widget profile =
        controller.isLoggin.value == true ? ProfileView() : LoginView();

    return [
      HomeView(),
      AttendanceView(),
      profile,
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.home),
          title: ("Home"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white60,
          contentPadding: 4),
      PersistentBottomNavBarItem(
          icon: Icon(
            CupertinoIcons.qrcode_viewfinder,
            color: Colors.black,
          ),
          title: ("Scan"),
          activeColorSecondary: CupertinoColors.white,
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.white,
          contentPadding: 12),
      PersistentBottomNavBarItem(
        icon: Icon(CupertinoIcons.profile_circled),
        title: controller.isLoggin.value == true
            ? controller.userInfo!.name
            : ("Login"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.white70,
      ),
    ];
  }
}
