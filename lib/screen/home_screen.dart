import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trycode/controller/booking_controller.dart';
import 'booking_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BookingController bookingController = Get.put(BookingController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Badminton Court Booking'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: bookingController.courts.length,
          itemBuilder: (context, index) {
            final court = bookingController.courts[index];
            return Card(
              margin: const EdgeInsets.all(10),
              child: ListTile(
                leading: SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    court.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(court.name),
                subtitle: Text(court.isAvailable ? 'Available' : 'Booked'),
                trailing: court.isAvailable
                    ? ElevatedButton(
                        onPressed: () {
                          Get.to(() => BookingScreen(court: court));
                        },
                        child: const Text('Book'),
                      )
                    : null,
              ),
            );
          },
        );
      }),
    );
  }
}
