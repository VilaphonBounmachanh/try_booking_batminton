import 'package:get/get.dart';
import 'package:trycode/model/court.dart';

class BookingController extends GetxController {
  var courts = <Court>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCourts();
  }

  void fetchCourts() {
    var courtResults = [
      Court(id: '1', name: 'Court 1', isAvailable: true, imageUrl: 'assets/image/2.jpg'),
      Court(id: '2', name: 'Court 2', isAvailable: false, imageUrl: 'assets/image/3.jpg'),
      Court(id: '3', name: 'Court 3', isAvailable: true, imageUrl: 'assets/image/4.jpg'),
    ];
    courts.assignAll(courtResults);
  }

  void bookCourt(String id) {
    var index = courts.indexWhere((court) => court.id == id);
    if (index != -1) {
      courts[index] = Court(
        id: courts[index].id,
        name: courts[index].name,
        isAvailable: false,
        imageUrl: courts[index].imageUrl,
      );
      courts.refresh();
    }
  }
}
