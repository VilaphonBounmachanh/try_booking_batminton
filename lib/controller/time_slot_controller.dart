import 'package:get/get.dart';

class TimeSlotController extends GetxController {
  var selectedTimeSlots = <String, bool>{}.obs;

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

  @override
  void onInit() {
    super.onInit();
    for (var timeSlot in timeSlots) {
      selectedTimeSlots[timeSlot] = false;
    }
  }

  void toggleTimeSlot(String timeSlot) {
    selectedTimeSlots[timeSlot] = !selectedTimeSlots[timeSlot]!;
  }

  List<String> getSelectedTimeSlots() {
    return selectedTimeSlots.entries.where((entry) => entry.value).map((entry) => entry.key).toList();
  }
}
