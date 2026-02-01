
# 🏓 Ứng Dụng Quản Lý CLB Pickleball (Pickleball Club Management)

Chào mừng bạn đến với dự án **Pickleball Club Management Application** – giải pháp toàn diện cho việc quản lý và vận hành câu lạc bộ Pickleball hiện đại.

---

## 🚀 Giới Thiệu
Đây là ứng dụng di động được xây dựng bằng **Flutter**, kết nối với **Backend Web API**.  
Ứng dụng cung cấp nền tảng cho **Hội viên (Members)** và **Quản trị viên (Admins)** để đặt sân, quản lý giải đấu và theo dõi tài chính.

---

## ✨ Tính Năng Chính

### 👤 Đối với Hội Viên (Member)
- Đặt sân, xem lịch sân trực quan  
- Quản lý hồ sơ cá nhân, lịch sử thi đấu  
- Ví điện tử: nạp tiền, xem số dư, lịch sử giao dịch  
- Tham gia và theo dõi giải đấu  

### 🛠 Đối với Quản Trị Viên (Admin)
- Dashboard thống kê hoạt động CLB  
- Quản lý sân bãi  
- Quản lý giải đấu  
- Theo dõi tài chính  

---

## 🛠 Công Nghệ Sử Dụng
- Flutter (Dart)  
- Provider – State Management  
- RESTful API  
- Hỗ trợ Android, iOS, Web  

---

## 📂 Cấu Trúc Dự Án (Flutter)

```text
lib/
├── config/
│   └── app_constants.dart
├── data/
│   └── services/
│       ├── api_client.dart
│       ├── auth_service.dart
│       ├── booking_service.dart
│       └── wallet_service.dart
├── providers/
│   ├── auth_provider.dart
│   ├── booking_provider.dart
│   ├── tournament_provider.dart
│   └── wallet_provider.dart
├── screens/
│   ├── admin/
│   ├── auth/
│   ├── booking/
│   ├── history/
│   ├── home/
│   ├── profile/
│   ├── tournament/
│   └── wallet/
└── main.dart



```md
## ▶️ Chạy Ứng Dụng

```bash
flutter pub get
flutter run




```md
## 👤 Tác Giả

**Tran Van Phong**  
Dự án phục vụ bài tập / đồ án môn học.

