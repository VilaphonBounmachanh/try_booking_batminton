import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trycode/model/court.dart';
import 'package:trycode/controller/detail_controller.dart';

class DetailPage extends StatelessWidget {
  final Court court;
  final Map<DateTime, List<String>> bookingDetails;

  DetailPage({Key? key, required this.court, required this.bookingDetails}) : super(key: key);

  final DetailController detailController = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
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
              const Text(
                'Booking Details:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Form(
                key: detailController.formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: detailController.usernameController,
                      decoration: const InputDecoration(labelText: 'Username'),
                      validator: detailController.validateUsername,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: detailController.phoneNumberController,
                      decoration: const InputDecoration(labelText: 'Phone Number'),
                      keyboardType: TextInputType.phone,
                      validator: detailController.validatePhoneNumber,
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          detailController.confirmBooking(court, bookingDetails);
                        },
                        child: const Text('Confirm Booking'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(), // Disable ListView's own scrolling
                shrinkWrap: true, // Take up only the necessary space
                itemCount: bookingDetails.keys.length,
                itemBuilder: (context, index) {
                  final date = bookingDetails.keys.elementAt(index);
                  final timeSlots = bookingDetails[date]!;
                  final formattedDate = DateFormat('yyyy-MM-dd').format(date);
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text('Date: $formattedDate'),
                      subtitle: Text('Time Slots: ${timeSlots.join(', ')}'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
