🚀 Ứng Dụng Quản Lý CLB Pickleball (Pickleball Club Management)
Chào mừng bạn đến với dự án Pickleball Club Management Application - Giải pháp toàn diện cho việc quản lý và vận hành câu lạc bộ Pickleball hiện đại.

🚀 Giới Thiệu
Đây là ứng dụng di động được xây dựng bằng Flutter, kết nối với Backend ASP.NET Core Web API. Ứng dụng cung cấp nền tảng cho cả Hội viên (Members) và Quản trị viên (Admins) để tương tác, đặt sân, quản lý giải đấu và theo dõi tài chính.

✨ Tính Năng Chính
👤 Đối với Hội Viên (Member)
Đặt Sân (Booking System): Xem lịch sân trực quan (Time Grid), đặt sân nhanh chóng và nhận thông báo thành công ngay lập tức.

Hồ Sơ Cá Nhân: Quản lý thông tin, theo dõi cấp bậc (Ranking) và lịch sử hoạt động.

Ví Điện Tử: Nạp tiền, xem số dư thực (Live Balance) và lịch sử giao dịch.

Giải Đấu: Xem danh sách giải đấu, đăng ký tham gia (hệ thống tự động trừ phí và đổi trạng thái nút).

🛠 Đối với Quản Trị Viên (Admin)
Dashboard Quản Trị: Thống kê doanh thu, tiền nạp và hoạt động sân bãi.

Quản Lý Sân Bãi: Thêm/Sửa/Xóa sân, theo dõi tình trạng sân.

Phê Duyệt Nạp Tiền: Xử lý các yêu cầu nạp tiền thực tế từ hội viên.

Quản Lý Giải Đấu: Tạo giải đấu mới đầy đủ thông số, xem chi tiết danh sách đăng ký.

🛠 Công Nghệ Sử Dụng
Frontend (Mobile): Flutter (Dart) sử dụng Provider để quản lý trạng thái tập trung.

Backend (Server): ASP.NET Core 8.0 Web API.

Database: SQL Server + Entity Framework Core.

📦 Cài Đặt & Chạy Ứng Dụng
Yêu Cầu
Flutter SDK (Latest Stable).

Android Studio / VS Code.

Các Bước Thực Hiện
Clone Repository:

Bash

git clone https://github.com/phongtranv/Mobile_App_1771020536_CNTT1708.git
Cài Đặt Dependencies:

Bash

flutter pub get
Cấu Hình API:

Mở file cấu hình API trong dự án.

Cập nhật baseUrl trỏ về địa chỉ server đã deploy thực tế (không dùng localhost khi build app).

Chạy Ứng Dụng:

Bash

flutter run
📱 Cấu Trúc Dự Án (Project Structure)
Cấu trúc được tổ chức theo mã nguồn thực tế của dự án:

Plaintext

lib/
├── core/           # Constants (API URL), Theme, Utils
├── data/           # Services xử lý gọi API kết nối Server
├── providers/      # AuthProvider quản lý Logic ví, đặt sân, giải đấu
├── screens/        # UI Screens (Admin, Booking, Tournament, Profile...)
├── widgets/        # Các thành phần giao diện dùng chung
└── main.dart       # Điểm khởi chạy ứng dụng & cấu hình Provider
👥 Tác Giả
Họ và tên: Trần Văn Phong

MSSV: 1771020536

Link dự án: https://github.com/phongtranv/Mobile_App_1771020536_CNTT1708.git