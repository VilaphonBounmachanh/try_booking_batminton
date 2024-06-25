// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:trycode/controller/booking_controller.dart';
import 'package:trycode/model/court.dart';
import 'package:trycode/screen/detail_screen.dart';

class BookingScreen extends StatefulWidget {
  final Court court;

  const BookingScreen({super.key, required this.court});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final BookingController bookingController = Get.find();

  final List<String> timeSlots = [
    '9:00 - 10:00 AM',
    '10:00 - 11:00 AM',
    '11:00 - 12:00 PM',
    '1:00 - 2:00 PM',
    '2:00 - 3:00 PM',
    '3:00 - 4:00 PM',
    '4:00 - 5:00 PM',
    '5:00 - 6:00 PM',
    '6:00 - 7:00 PM',
    '7:00 - 8:00 PM',
    '8:00 - 9:00 PM',
    '9:00 - 10:00 PM',
    '10:00 - 11:00 PM',
  ];

  Map<DateTime, List<String>> selectedTimeSlotsMap = {};

  DateTime _selectedDate = DateTime.now(); // Initialize with current date

  @override
  void initState() {
    super.initState();
    // Initialize all time slots as empty for the current date
    selectedTimeSlotsMap[_selectedDate] = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.court.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Image.asset(
              widget.court.imageUrl,
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            const SizedBox(height: 10),
            Text(
              widget.court.isAvailable ? 'Status: Available' : 'Status: Booked',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Select Date:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.all(10),
              child: _buildDatePicker(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Time Slots:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: timeSlots.length,
                itemBuilder: (context, index) {
                  final timeSlot = timeSlots[index];
                  return CheckboxListTile(
                    title: Text(timeSlot),
                    value: selectedTimeSlotsMap[_selectedDate]?.contains(timeSlot) ?? false,
                    onChanged: (bool? value) {
                      setState(() {
                        if (value!) {
                          selectedTimeSlotsMap.update(_selectedDate, (slots) => [...slots, timeSlot], ifAbsent: () => [timeSlot]);
                        } else {
                          selectedTimeSlotsMap[_selectedDate]?.remove(timeSlot);
                        }
                      });
                    },
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Process the selected dates and time slots
                  selectedTimeSlotsMap.forEach((date, timeSlots) {
                    if (timeSlots.isNotEmpty) {
                      print('Date: $date');
                      print('Time Slots: ${timeSlots.join(', ')}');
                    }
                  });
                  // Navigate to DetailPage with the booking details and court details
                  Get.to(() => DetailPage(
                        court: widget.court,
                        bookingDetails: selectedTimeSlotsMap,
                      ));
                },
                child: const Text('Confirm Booking'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return DatePicker(
      DateTime.now(),
      height: 100,
      width: 80,
      initialSelectedDate: DateTime.now(),
      selectionColor: Colors.green,
      selectedTextColor: Colors.white,
      daysCount: 7,
      dateTextStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      onDateChange: (date) {
        setState(() {
          _selectedDate = date;
          // Clear time slots for the new selected date
          if (!selectedTimeSlotsMap.containsKey(date)) {
            selectedTimeSlotsMap[date] = [];
          }
        });
      },
    );
  }
}
