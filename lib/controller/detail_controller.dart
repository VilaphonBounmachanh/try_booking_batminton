// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trycode/model/court.dart';
import 'package:trycode/screen/bill_screen.dart';

class DetailController extends GetxController {
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void onClose() {
    usernameController.dispose();
    phoneNumberController.dispose();
    super.onClose();
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!RegExp(r'^\d+$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // void confirmBooking(Court court, Map<DateTime, List<String>> bookingDetails) {
  //   if (formKey.currentState!.validate()) {
  //     final username = usernameController.text;
  //     final phoneNumber = phoneNumberController.text;

  //     print('Username: $username');
  //     print('Phone Number: $phoneNumber');

  //     Get.to(() => BillPage(
  //           court: court,
  //           bookingDetails: bookingDetails,
  //           username: username,
  //           phoneNumber: phoneNumber,
  //         ));
  //   }
  // }
}
