import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:trycode/controller/booking_controller.dart';
import 'package:trycode/model/court.dart';
import 'package:intl/intl.dart';
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
    '9:00 AM - 10:00 AM',
    '10:00 AM- 11:00 AM',
    '11:00 AM- 12:00 PM',
    '12:00 PM- 1:00 PM',
    '1:00 PM - 2:00 PM',
    '2:00 PM - 3:00 PM',
    '3:00 PM - 4:00 PM',
    '4:00 PM - 5:00 PM',
    '5:00 PM - 6:00 PM',
    '6:00 PM - 7:00 PM',
    '7:00 PM - 8:00 PM',
    '8:00 PM - 9:00 PM',
    '9:00 PM - 10:00 PM',
    '10:00 PM - 11:00 PM',
  ];

  Map<DateTime, Map<String, bool>> bookingDetails = {};
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // Initialize bookingDetails for the current date
    bookingDetails[_selectedDate] = {};
    for (var timeSlot in timeSlots) {
      bookingDetails[_selectedDate]![timeSlot] = false;
    }
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
                  final isSelected = bookingDetails[_selectedDate]?[timeSlot] ?? false;
                  final isTimePassed = _isTimePassed(timeSlot);
                  final isCurrentDate = _selectedDate.isAtSameMomentAs(DateTime.now());

                  // Enable or disable onChanged based on whether it's the current date
                  final canChangeTimeSlot = isCurrentDate || !isTimePassed;

                  return CheckboxListTile(
                    title: Text(timeSlot),
                    value: isSelected,
                    onChanged: canChangeTimeSlot
                        ? (bool? value) {
                            setState(() {
                              bookingDetails[_selectedDate]![timeSlot] = value!;
                            });
                          }
                        : null,
                  );
                },
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final Map<DateTime, List<String>> selectedBookingDetails = {};

                  bookingDetails.forEach(
                    (date, slots) {
                      final selectedSlots = slots.entries.where((entry) => entry.value).map((entry) => entry.key).toList();
                      if (selectedSlots.isNotEmpty) {
                        selectedBookingDetails[date] = selectedSlots;
                      }
                    },
                  );

                  if (selectedBookingDetails.isEmpty) {
                    Get.snackbar('Error', 'Please select at least one time slot', backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }

                  Get.to(() => DetailPage(
                        court: widget.court,
                        bookingDetails: selectedBookingDetails,
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
          if (!bookingDetails.containsKey(date)) {
            bookingDetails[date] = {};
            for (var timeSlot in timeSlots) {
              bookingDetails[date]![timeSlot] = false;
            }
          }
        });
      },
    );
  }

  bool _isTimePassed(String timeSlot) {
    DateTime now = DateTime.now();
    DateTime parsedTime = DateFormat('hh:mm a').parse(timeSlot.split(' - ')[0]);

    // Adjust the parsedTime to compare against _selectedDate's date
    parsedTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, parsedTime.hour, parsedTime.minute);

    // Check if parsedTime is in the past relative to now
    return now.isAfter(parsedTime);
  }
}
