import 'package:flutter/material.dart';
import 'package:trycode/model/court.dart';
import 'package:trycode/model/list_court.dart';

class BillScreen extends StatelessWidget {
  final Court court;
  final List<ListCourt> bookingDetails;
  final int finalTotal;
  final String name;
  final String phone;

  const BillScreen({
    Key? key,
    required this.court,
    required this.bookingDetails,
    required this.finalTotal,
    required this.name,
    required this.phone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: $name',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Phone: $phone',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Text(
              'Court: ${court.name}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...bookingDetails.map((courtModel) {
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
            }).toList(),
            const SizedBox(height: 20),
            Text(
              'Final Total: $finalTotal',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
