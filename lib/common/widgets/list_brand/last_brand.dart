// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ListOfBrands extends StatelessWidget {
  const ListOfBrands({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> brands = ['Italy', 'Turkey', 'American']; // List of brands
    return Column(
      children: [
        Text(
          'Select Brand(s):',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        // Obx(
        //   () => Column(
        //     children: brands.map((brand) {
        //       return CheckboxListTile(
        //         title: Text(brand),
        //         value: controller.selectBrands.contains(brand),
        //         onChanged: (value) => controller.slectedBrands(value, brand),
        //       );
        //     }).toList(),
        //   ),
        // )
      ],
    );
  }
}
