import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../data/services/auth_service.dart';
import 'package:intl/intl.dart';

class AuthProvider extends ChangeNotifier {
  // ignore: unused_field
  final _authService = AuthService();
  // ignore: unused_field
  final _storage = const FlutterSecureStorage();

  bool _isLoading = false;

  // --- THÔNG TIN USER ---
  String _name = "Trần Văn Phong";
  String _phone = "0987654321";
  String _studentId = "1771020536";
  bool _isAdmin = false;
  double _balance = 5475000;

  // Getter
  bool get isLoading => _isLoading;
  String get name => _name;
  String get phone => _phone;
  String get studentId => _studentId;
  bool get isAdmin => _isAdmin;
  double get balance => _balance;

  // --- DỮ LIỆU ---
  final List<Map<String, dynamic>> _members = [
    {
      "id": "7",
      "name": "Nguyễn Văn An",
      "phone": "0987654321",
      "rank": "Bạc",
      "balance": 5475000.0,
      "spent": 0.0,
    },
    {
      "id": "18",
      "name": "Phan Văn Phúc",
      "phone": "0912345678",
      "rank": "Kim cương",
      "balance": 5600000.0,
      "spent": 0.0,
    },
    {
      "id": "23",
      "name": "Mai Thị Vân",
      "phone": "0909090909",
      "rank": "Kim cương",
      "balance": 2300000.0,
      "spent": 0.0,
    },
    {
      "id": "1",
      "name": "Quản Trị Viên",
      "phone": "0000000000",
      "rank": "Kim cương",
      "balance": 12990000.0,
      "spent": 0.0,
    },
  ];
  List<Map<String, dynamic>> get members => _members;

  final List<Map<String, dynamic>> _courts = [
    {
      "id": "1",
      "name": "Sân 1 - VIP",
      "price": 150000,
      "status": "Active",
      "description": "Sân có mái che, đèn LED",
    },
    {
      "id": "2",
      "name": "Sân 2",
      "price": 100000,
      "status": "Active",
      "description": "Sân ngoài trời",
    },
  ];
  List<Map<String, dynamic>> get courts => _courts;

  final List<Map<String, dynamic>> _tournaments = [
    {
      "name": "Giải Mùa Xuân 2026",
      "date": "01/02/2026",
      "endDate": "05/02/2026",
      "format": "Loại trực tiếp",
      "participants": 16,
      "fee": 200000.0,
      "prize": 5000000.0,
      "winner": "Chưa có",
      "registeredUsers": [],
    },
  ];
  List<Map<String, dynamic>> get tournaments => _tournaments;

  final List<Map<String, dynamic>> _depositRequests = [];
  List<Map<String, dynamic>> get depositRequests => _depositRequests;

  final List<Map<String, dynamic>> _transactions = [];
  List<Map<String, dynamic>> get transactions => _transactions;

  final List<Map<String, dynamic>> _myBookings = [];
  List<Map<String, dynamic>> get myBookings => _myBookings;

  // --- USER: ĐĂNG KÝ GIẢI ĐẤU (ĐÃ SỬA: TRỪ TIỀN) ---
  Future<bool> registerTournament(int index) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    final tournament = _tournaments[index];
    double fee = double.tryParse(tournament['fee'].toString()) ?? 0.0;

    // 1. Kiểm tra số dư (nếu giải có phí)
    if (fee > 0 && _balance < fee) {
      _isLoading = false;
      notifyListeners();
      return false; // Trả về false nếu không đủ tiền
    }

    // 2. Xử lý đăng ký
    List<dynamic> currentRegistered = tournament['registeredUsers'] ?? [];
    if (!currentRegistered.contains(_name)) {
      // Trừ tiền
      if (fee > 0) {
        _balance -= fee;

        // Cập nhật số dư vào danh sách thành viên ảo
        final userIndex = _members.indexWhere((m) => m['name'] == _name);
        if (userIndex != -1) {
          _members[userIndex]['balance'] = _balance;
          // Cộng vào tổng chi tiêu để tính hạng
          double spent = double.parse(_members[userIndex]['spent'].toString());
          _members[userIndex]['spent'] = spent + fee;
        }

        // Lưu lịch sử giao dịch trừ tiền
        _transactions.insert(0, {
          "type": "Phí tham gia giải: ${tournament['name']}",
          "amount": fee,
          "status": "Thành công", // Trừ tiền thành công ngay
          "date": DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
        });
      }

      // Thêm tên vào danh sách
      currentRegistered.add(_name);
      _tournaments[index]['registeredUsers'] = currentRegistered;
    }

    _isLoading = false;
    notifyListeners();
    return true; // Đăng ký thành công
  }

  // --- USER: NẠP TIỀN ---
  Future<bool> deposit(double amount) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    _depositRequests.insert(0, {
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "user": _name,
      "amount": amount,
      "status": "Pending",
      "time": DateFormat('dd/MM HH:mm').format(DateTime.now()),
    });

    _transactions.insert(0, {
      "type": "Nạp tiền",
      "amount": amount,
      "status": "Chờ duyệt",
      "date": DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
    });

    _isLoading = false;
    notifyListeners();
    return true;
  }

  // --- USER: ĐẶT SÂN ---
  Future<bool> bookCourt(String courtId, String date, String time) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    final court = _courts.firstWhere((c) => c['id'] == courtId);
    double price = double.parse(court['price'].toString());

    if (_balance < price) {
      _isLoading = false;
      notifyListeners();
      return false;
    }

    _balance -= price;

    _myBookings.insert(0, {
      "courtName": court['name'],
      "date": date,
      "time": time,
      "price": price,
      "status": "Thành công",
    });

    final userIndex = _members.indexWhere((m) => m['name'] == _name);
    if (userIndex != -1) {
      _members[userIndex]['balance'] = _balance;
      double spent = double.parse(_members[userIndex]['spent'].toString());
      _members[userIndex]['spent'] = spent + price;
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  // --- ADMIN: DUYỆT TIỀN ---
  void approveDeposit(int index) {
    final request = _depositRequests[index];
    final amount = request['amount'];
    final userName = request['user'];

    for (var member in _members) {
      if (member['name'] == userName) {
        double current = double.parse(member['balance'].toString());
        member['balance'] = current + amount;
        if (userName == _name) _balance = member['balance'];
        break;
      }
    }

    if (userName == _name) {
      for (var trans in _transactions) {
        if (trans['type'] == 'Nạp tiền' &&
            trans['amount'] == amount &&
            trans['status'] == 'Chờ duyệt') {
          trans['status'] = 'Thành công';
          break;
        }
      }
    }

    _depositRequests.removeAt(index);
    notifyListeners();
  }

  void rejectDeposit(int index) {
    _depositRequests.removeAt(index);
    notifyListeners();
  }

  // --- ADMIN: QUẢN LÝ ---
  void addTournamentFull(Map<String, dynamic> item) {
    item.putIfAbsent('endDate', () => item['date']);
    item.putIfAbsent('format', () => 'Tự do');
    item.putIfAbsent('participants', () => 0);
    item.putIfAbsent('fee', () => 0.0);
    item.putIfAbsent('prize', () => 0.0);
    item.putIfAbsent('registeredUsers', () => []);

    _tournaments.insert(0, item);
    notifyListeners();
  }

  void updateUserInfo(String newName, String newPhone) {
    _name = newName;
    _phone = newPhone;
    notifyListeners();
  }

  void addCourt(String name, double price) {
    _courts.add({
      "id": DateTime.now().toString(),
      "name": name,
      "price": price,
      "status": "Active",
      "description": "Sân tiêu chuẩn",
    });
    notifyListeners();
  }

  void deleteCourt(int index) {
    _courts.removeAt(index);
    notifyListeners();
  }

  void editCourt(int index, String name, double price) {
    _courts[index]['name'] = name;
    _courts[index]['price'] = price;
    notifyListeners();
  }

  void addMember(String name, String phone, String rank) {
    _members.add({
      "name": name,
      "phone": phone,
      "rank": rank,
      "balance": 0.0,
      "spent": 0.0,
    });
    notifyListeners();
  }

  void editMember(int index, String name, String phone, String rank) {
    _members[index]['name'] = name;
    _members[index]['phone'] = phone;
    _members[index]['rank'] = rank;
    notifyListeners();
  }

  void deleteMember(int index) {
    _members.removeAt(index);
    notifyListeners();
  }

  // --- LOGIN ---
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));

    if (email == "admin@pcm.vn" && password == "Admin@123") {
      _isAdmin = true;
      _name = "Quản Trị Viên";
      _syncBalance();
      _isLoading = false;
      notifyListeners();
      return true;
    }
    if (email == "member01@pcm.vn" && password == "Member@123") {
      _isAdmin = false;
      _name = "Nguyễn Văn An";
      _syncBalance();
      _isLoading = false;
      notifyListeners();
      return true;
    }
    if (email == "admin@gmail.com") {
      _isAdmin = true;
      _isLoading = false;
      notifyListeners();
      return true;
    }
    if (email == "test@gmail.com") {
      _isAdmin = false;
      _balance = 5475000;
      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  void _syncBalance() {
    try {
      final user = _members.firstWhere(
        (m) => m['name'] == _name,
        orElse: () => {"balance": 0.0},
      );
      _balance = double.parse(user['balance'].toString());
    } catch (e) {
      _balance = 0;
    }
  }

  void logout() {
    _isAdmin = false;
    notifyListeners();
  }
}
