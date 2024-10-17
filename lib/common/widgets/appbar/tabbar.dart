import 'package:flutter/material.dart';
import 'package:shopingly/utils/constants/colors.dart';
import 'package:shopingly/utils/device/device_utility.dart';
import 'package:shopingly/utils/helpers/helper_functions.dart';

class ShopinglyTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// This widget is to add a background color to the tabs. It needs a material
  /// widget. The [PreferredSize] widget will help us implement that.

  const ShopinglyTabBar({super.key, required this.tabs});

  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    final dark = ShopinglyHelperFunctions.isDarkMode(context);
    return Material(
      color: dark ? ShopinglyColors.black : ShopinglyColors.white,
      child: TabBar(
        tabs: tabs,
        isScrollable: true,
        indicatorColor: ShopinglyColors.primaryColor,
        labelColor: dark ? ShopinglyColors.white : ShopinglyColors.primaryColor,
        unselectedLabelColor: ShopinglyColors.darkGrey,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(ShopinglyDeviceUtils.getAppBarHeight());
}
