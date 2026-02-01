import 'dart:io'; // Thêm thư viện này để check hệ điều hành

class AppConstants {
  static const String appName = "Vợt Thủ Phố Núi";

  // Tự động nhận diện: Nếu là Android thì dùng 10.0.2.2, còn lại (Windows/Web) dùng localhost
  static String get baseUrl {
    if (Platform.isAndroid) {
      return "https://10.0.2.2:7248/api";
    } else {
      return "https://localhost:7248/api";
    }
  }
}
