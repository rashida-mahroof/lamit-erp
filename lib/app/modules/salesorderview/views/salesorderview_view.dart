import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/salesorderview_controller.dart';

class SalesorderviewView extends GetView<SalesorderviewController> {
  const SalesorderviewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SalesorderviewView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SalesorderviewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
