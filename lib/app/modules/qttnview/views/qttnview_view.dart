import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/qttnview_controller.dart';

class QttnviewView extends GetView<QttnviewController> {
  const QttnviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QttnviewView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'QttnviewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
