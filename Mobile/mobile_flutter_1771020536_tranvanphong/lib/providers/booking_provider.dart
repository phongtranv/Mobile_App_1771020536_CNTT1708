import 'package:flutter/material.dart';
import '../data/services/booking_service.dart';

class BookingProvider extends ChangeNotifier {
  final _service = BookingService();

  List<dynamic> _courts = [];
  List<dynamic> get courts => _courts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Hàm tải danh sách sân
  Future<void> loadCourts() async {
    _isLoading = true;
    notifyListeners();

    _courts = await _service.getCourts();

    _isLoading = false;
    notifyListeners();
  }

  // Hàm đặt sân
  Future<bool> bookCourt(int courtId, String date, String time) async {
    _isLoading = true;
    notifyListeners();

    final success = await _service.createBooking(courtId, date, time);

    _isLoading = false;
    notifyListeners();
    return success;
  }
}
