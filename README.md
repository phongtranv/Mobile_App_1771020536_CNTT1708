
Ứng Dụng Quản Lý CLB Pickleball (Pickleball Club Management)
Chào mừng bạn đến với dự án Pickleball Club Management Application - Giải pháp toàn diện cho việc quản lý và vận hành câu lạc bộ Pickleball hiện đại.

🚀 Giới Thiệu
Đây là ứng dụng di động được xây dựng bằng Flutter, kết nối với Backend ASP.NET Core Web API. Ứng dụng cung cấp nền tảng cho cả Hội viên (Members) và Quản trị viên (Admins) để tương tác, đặt sân, quản lý giải đấu và theo dõi tài chính.

✨ Tính Năng Chính
👤 Đối với Hội Viên (Member)
- Đặt sân, xem lịch sân
- Quản lý hồ sơ cá nhân
- Ví điện tử: nạp tiền, xem số dư, lịch sử giao dịch
- Tham gia & theo dõi giải đấu
🛠 Đối với Quản Trị Viên (Admin)
- Quản lý sân bãi
- Quản lý giải đấu
- Theo dõi hoạt động & tài chính CLB
🛠 Công Nghệ Sử Dụng
Frontend (Mobile):

Framework: Flutter (Dart)
State Management: Bloc / Cubit (Clean Architecture)
Real-time: SignalR (signalr_netcore)
Networking: Dio (với Interceptors & Token management)
UI Components: fl_chart, table_calendar, google_fonts
Backend (Server):

Platform: ASP.NET Core 8.0 Web API
Database: SQL Server + Entity Framework Core
Authentication: JWT (Identity Core)
Real-time Hub: SignalR
📦 Cài Đặt & Chạy Ứng Dụng
Yêu Cầu
Flutter SDK (Latest Stable)
Dart SDK
Android Studio / VS Code
Các Bước Thực Hiện
Clone Repository (Nếu chưa có):

git clone https://github.com/NguyenXuanGiang30/Mobile_17710200230_CNTT1708.git
cd Mobile_17710200230_CNTT1708 (hoặc thư mục chứa code)
Cài Đặt Dependencies:

=======
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



▶️ Chạy Ứng Dụng

flutter pub get
Cấu Hình API:

Mở file lib/core/constants/api_config.dart.
Cập nhật baseUrl trỏ về địa chỉ server của bạn (ví dụ: http://10.0.2.2:5006 cho Android Emulator hoặc IP LAN cho thiết bị thật).
Chạy Ứng Dụng:

flutter run
📱 Cấu Trúc Dự Án
lib/
├── blocs/          # Business Logic Components (State Management)
├── core/           # Constants, Services, Theme, Utils
├── models/         # Data Models (DTOs)
├── repositories/   # Data Layer (API calls)
├── screens/        # UI Screens (Home, Booking, Admin, Profile...)
├── widgets/        # Reusable Widgets
└── main.dart       # Entry Point
👥 Tác Giả
Nguyen Xuan Giang
=======




👤 Tác Giả

Tran Van Phong

