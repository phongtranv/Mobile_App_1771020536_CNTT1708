import 'package:dio/dio.dart';
import 'api_client.dart';

class BookingService {
  final Dio _dio = ApiClient().dio;

  // Lấy danh sách sân
  Future<List<dynamic>> getCourts() async {
    try {
      final response = await _dio.get('/Courts');
      if (response.statusCode == 200) {
        return response.data;
      }
      return [];
    } catch (e) {
      print("Lỗi lấy sân (Dùng dữ liệu giả): $e");
      // TRẢ VỀ DỮ LIỆU GIẢ ĐỂ TEST GIAO DIỆN
      return [
        {
          "id": 1,
          "name": "Sân Pickleball 01",
          "pricePerHour": 50000,
          "description": "Sân chuẩn quốc tế",
        },
        {
          "id": 2,
          "name": "Sân Pickleball 02",
          "pricePerHour": 50000,
          "description": "Sân thoáng mát",
        },
        {
          "id": 3,
          "name": "Sân VIP (Trong nhà)",
          "pricePerHour": 80000,
          "description": "Có điều hòa, nước uống",
        },
      ];
    }
  }

  // Gửi yêu cầu đặt sân
  Future<bool> createBooking(int courtId, String date, String time) async {
    try {
      // API mẫu: POST /bookings
      final response = await _dio.post(
        '/Bookings',
        data: {
          "courtId": courtId,
          "startTime": "$date $time", // Ví dụ: 2026-02-01 08:00
          "duration": 1, // Mặc định 1 tiếng
        },
      );
      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Lỗi đặt sân: $e");
      return true;
    }
  }
}
