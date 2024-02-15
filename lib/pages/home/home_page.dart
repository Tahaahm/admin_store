// ignore_for_file: prefer_const_constructors, avoid_print, unused_local_variable

import 'package:admin_store_commerce_shop/common/widgets/container/user_list.dart';
import 'package:admin_store_commerce_shop/common/widgets/custom/thome_app_bar.dart';
import 'package:admin_store_commerce_shop/util/dimention/dimention.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(), // Ensure scrolling is enabled
      child: Column(
        children: [
          THomeAppBar(),
          SizedBox(height: Dimentions.height32),
          UserList(),
          // Add more widgets as needed
        ],
      ),
    );
  }
}
