import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trycode/model/court.dart';
import 'package:trycode/controller/detail_controller.dart';
import 'package:trycode/screen/bill_screen.dart';

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
      body: SingleChildScrollView(
        // Added SingleChildScrollView
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
                          if (detailController.formKey.currentState!.validate()) {
                            Get.to(
                              () => BillPage(
                                court: court,
                                bookingDetails: bookingDetails,
                                username: detailController.usernameController.text,
                                phoneNumber: detailController.phoneNumberController.text,
                              ),
                            );
                          }
                        },
                        child: const Text('Confirm Booking'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Selected Time Slots:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ListView.builder(
                shrinkWrap: true, // Added shrinkWrap to ListView.builder
                physics: const NeverScrollableScrollPhysics(), // Disabled internal scrolling
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
