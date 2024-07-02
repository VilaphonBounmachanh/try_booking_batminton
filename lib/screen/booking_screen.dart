// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import 'package:trycode/model/court.dart';
import 'package:intl/intl.dart';
import 'package:trycode/model/list_court.dart';
import 'package:trycode/screen/detail_screen.dart';

class BookingScreen extends StatefulWidget {
  final Court court;

  const BookingScreen({super.key, required this.court});

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
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

  List<ListCourt> bookingDetails = [];
  DateTime _selectedDate = DateTime.now();
  int totalPrice = 0;
  final int pricePerSlot = 80000;
  final int discount = 20000;

  @override
  void initState() {
    super.initState();
    _initializeBookingDetails(_selectedDate);
  }

  void _initializeBookingDetails(DateTime date) {
    bookingDetails.add(ListCourt(date: DateFormat('yyyy-MM-dd').format(date), durationTime: []));
  }

  void _calculateTotalPrice() {
    totalPrice = bookingDetails.fold(
      0,
      (sum, courtModel) => sum + (courtModel.durationTime.length * pricePerSlot),
    );
  }

  void _addToCart() {
    final selectedCourtModels = bookingDetails.where((courtModel) => courtModel.durationTime.isNotEmpty).toList();

    if (selectedCourtModels.isEmpty) {
      Get.snackbar('Error', 'Please select at least one time slot', backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    Get.to(
      () => DetailPage(
        court: widget.court,
        bookingDetails: selectedCourtModels,
        totalPrice: totalPrice,
      ),
    );
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
                  final currentCourtModel = bookingDetails.firstWhere(
                    (courtModel) => courtModel.date == DateFormat('yyyy-MM-dd').format(_selectedDate),
                    orElse: () => ListCourt(
                      date: '',
                      durationTime: [],
                    ),
                  );
                  final isSelected = currentCourtModel.durationTime.contains(timeSlot);
                  final isTimePassed = _isTimePassed(timeSlot);
                  final isCurrentDate = _selectedDate.isAtSameMomentAs(DateTime.now());

                  final canChangeTimeSlot = isCurrentDate || !isTimePassed;

                  return CheckboxListTile(
                    title: Text(timeSlot),
                    value: isSelected,
                    onChanged: canChangeTimeSlot
                        ? (bool? value) {
                            setState(() {
                              if (value == true) {
                                currentCourtModel.durationTime.add(timeSlot);
                              } else {
                                currentCourtModel.durationTime.remove(timeSlot);
                              }
                              _calculateTotalPrice();
                            });
                          }
                        : null,
                  );
                },
              ),
            ),
            Center(
              child: Text(
                'Total Price: $totalPrice',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: ElevatedButton(
                onPressed: _addToCart,
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
          if (!bookingDetails.any((courtModel) => courtModel.date == DateFormat('yyyy-MM-dd').format(date))) {
            _initializeBookingDetails(date);
          }
        });
      },
    );
  }

  bool _isTimePassed(String timeSlot) {
    DateTime now = DateTime.now();
    DateTime parsedTime = DateFormat('hh:mm a').parse(timeSlot.split(' - ')[0]);

    parsedTime = DateTime(_selectedDate.year, _selectedDate.month, _selectedDate.day, parsedTime.hour, parsedTime.minute);

    return now.isAfter(parsedTime);
  }
}
