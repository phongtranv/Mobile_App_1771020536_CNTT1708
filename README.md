🏓 Ứng Dụng Quản Lý CLB Pickleball

Pickleball Club Management Application

Ứng dụng di động hỗ trợ quản lý và vận hành câu lạc bộ Pickleball, dành cho Hội viên và Quản trị viên.

🚀 Giới Thiệu

Ứng dụng được xây dựng bằng Flutter, kết nối với Backend (Web API), hỗ trợ đặt sân, quản lý giải đấu và ví điện tử cho câu lạc bộ Pickleball hiện đại.

✨ Tính Năng Chính
👤 Hội Viên (Member)

Đặt sân, xem lịch sân

Quản lý hồ sơ cá nhân

Ví điện tử: nạp tiền, xem số dư, lịch sử giao dịch

Tham gia & theo dõi giải đấu

🛠 Quản Trị Viên (Admin)

Quản lý sân bãi

Quản lý giải đấu

Theo dõi hoạt động & tài chính CLB

🛠 Công Nghệ Sử Dụng

Flutter (Dart)

Provider – State Management

REST API (Backend)

Hỗ trợ đa nền tảng: Android, iOS, Web

📂 Cấu Trúc Dự Án (Flutter)
lib/
├── config/                 # Cấu hình & hằng số
│   └── app_constants.dart
│
├── data/
│   └── services/           # Gọi API, xử lý dữ liệu
│       ├── api_client.dart
│       ├── auth_service.dart
│       ├── booking_service.dart
│       └── wallet_service.dart
│
├── providers/              # Quản lý state (Provider)
│   ├── auth_provider.dart
│   ├── booking_provider.dart
│   ├── tournament_provider.dart
│   └── wallet_provider.dart
│
├── screens/                # Giao diện người dùng
│   ├── admin/
│   ├── auth/
│   ├── booking/
│   ├── history/
│   ├── home/
│   ├── profile/
│   ├── tournament/
│   └── wallet/
│
└── main.dart               # Entry point

▶️ Chạy Ứng Dụng
flutter pub get
flutter run

👤 Tác Giả

Tran Van Phong
Dự án phục vụ bài tập / đồ án môn học.