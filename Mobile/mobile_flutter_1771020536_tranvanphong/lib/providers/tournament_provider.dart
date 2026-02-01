import 'package:flutter/material.dart';

class TournamentProvider extends ChangeNotifier {
  // Dữ liệu giải đấu giả lập (Mock Data)
  final List<Map<String, dynamic>> _tournaments = [
    {
      "id": 1,
      "name": "Winter Cup 2026",
      "time": "15/02/2026",
      "fee": 200000, // Lệ phí 200k
      "prize": "5.000.000 đ",
      "status": "Đang mở đăng ký",
      "image":
          "https://img.freepik.com/free-vector/gradient-pickleball-logo-template_23-2150820921.jpg", // Ảnh minh họa
      "isJoined": false,
    },
    {
      "id": 2,
      "name": "Summer Open 2025",
      "time": "10/06/2025",
      "fee": 150000,
      "prize": "3.000.000 đ",
      "status": "Đã kết thúc",
      "image":
          "https://t4.ftcdn.net/jpg/05/08/83/82/360_F_508838262_X0x9qXfqX9qX9qX9.jpg",
      "isJoined": false,
    },
  ];

  List<Map<String, dynamic>> get tournaments => _tournaments;

  // Hàm tham gia giải đấu
  Future<bool> joinTournament(int id) async {
    // Tìm giải đấu
    final index = _tournaments.indexWhere((t) => t['id'] == id);
    if (index == -1) return false;

    // Giả lập xử lý mạng (Delay 1 giây)
    await Future.delayed(const Duration(seconds: 1));

    // Cập nhật trạng thái đã tham gia
    _tournaments[index]['isJoined'] = true;
    notifyListeners();
    return true;
  }
}
