import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnu/presentation/whatson/view/whatson_page.dart';

import 'constant/strings.dart';

class textfield extends StatefulWidget {
  const textfield({Key? key}) : super(key: key);

  @override
  State<textfield> createState() => _textfieldState();
}

class _textfieldState extends State<textfield> {
  final controller1 = Get.put(Controllergetwhatson());
  TextEditingController nameController = TextEditingController();
  late String textvalue;

  @override
  void initState() {
    super.initState();
    String a = nameController.text;
    controller1.updategift(a);
    // controller1.updategift();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter TextField Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                  hintText: 'Enter Your Name',
                ),
              ),
            ),
            ElevatedButton(
              child: Text('Sign In'),
              onPressed: () {
                String a = nameController.text;

                controller1.updategift(a);
                // Navigator.of(context).pop();
               // Get.back();
                Get.to(() => WhatsonPage(a:a));
              },
            ),
          ],
        ),
      ),
    );
  }
}
