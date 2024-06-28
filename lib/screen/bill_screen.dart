import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:trycode/model/court.dart';

class BillPage extends StatelessWidget {
  final Court court;
  final Map<DateTime, List<String>> bookingDetails;
  final String username;
  final String phoneNumber;

  const BillPage({
    Key? key,
    required this.court,
    required this.bookingDetails,
    required this.username,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> allTimeSlots = bookingDetails.values.expand((slots) => slots).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Details'),
      ),
      body: Padding(
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
                  image: AssetImage(court.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Username: $username',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Phone Number: $phoneNumber',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            const Text(
              'Booking Details:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: allTimeSlots.length,
                itemBuilder: (context, index) {
                  final timeSlot = allTimeSlots[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(timeSlot),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
