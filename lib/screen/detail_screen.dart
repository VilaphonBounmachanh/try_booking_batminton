// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:trycode/model/court.dart';
import 'package:trycode/controller/detail_controller.dart';
import 'package:trycode/model/list_court.dart';
import 'package:trycode/screen/bill_page.dart';

class DetailPage extends StatelessWidget {
  final Court court;
  List<ListCourt> bookingDetails;
  final int totalPrice;

  DetailPage({
    Key? key,
    required this.court,
    required this.bookingDetails,
    required this.totalPrice,
  }) : super(key: key);

  final DetailController detailController = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    int finalTotal = totalPrice - 20000; // Apply discount here

    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                court.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      court.imageUrl,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Booking Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Form(
                key: detailController.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: detailController.nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: detailController.phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Selected Time Slots:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    ...bookingDetails.map(
                      (courtModel) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Date: ${courtModel.date}',
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            ...courtModel.durationTime.map((timeSlot) {
                              return Text(
                                timeSlot,
                                style: const TextStyle(fontSize: 16),
                              );
                            }).toList(),
                            const SizedBox(height: 10),
                          ],
                        );
                      },
                    ).toList(),
                    const SizedBox(height: 10),
                    Text(
                      'Total Price: $totalPrice',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Discount: 20000',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    Text(
                      'Final Total: $finalTotal',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (detailController.formKey.currentState!.validate()) {
                            Get.to(
                              () => BillScreen(
                                court: court,
                                bookingDetails: bookingDetails,
                                finalTotal: finalTotal,
                                name: detailController.nameController.text,
                                phone: detailController.phoneController.text,
                              ),
                            );
                          }
                        },
                        child: const Text('Proceed to Payment'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
