import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/auth_provider.dart'; // Dùng AuthProvider
import '../auth/login_screen.dart';
import '../history/history_screen.dart';
import 'edit_profile_screen.dart';
import 'change_password_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. LẤY THÔNG TIN & SỐ DƯ TỪ AUTH PROVIDER
    final authProvider = context.watch<AuthProvider>();
    final balance = authProvider.balance;

    final totalSpent = 10000000 - balance;
    String rank = "Đồng";
    Color rankColor = const Color(0xFFCD7F32);
    if (totalSpent > 5000000) {
      rank = "Kim Cương";
      rankColor = Colors.cyanAccent;
    } else if (totalSpent > 2000000) {
      rank = "Vàng";
      rankColor = Colors.amber;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A202C),
      appBar: AppBar(
        title: const Text("Hồ Sơ Cá Nhân"),
        backgroundColor: const Color(0xFF1A202C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            ),
            const SizedBox(height: 15),
            Text(
              authProvider.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "MSSV: ${authProvider.studentId}",
              style: const TextStyle(color: Colors.grey, fontSize: 16),
            ),
            const SizedBox(height: 30),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2D3748),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: rankColor.withOpacity(0.5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hạng Thành Viên",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        rank,
                        style: TextStyle(
                          color: rankColor,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.military_tech, color: rankColor, size: 50),
                ],
              ),
            ),
            const SizedBox(height: 30),

            _buildProfileItem(
              context,
              Icons.person,
              "Chỉnh sửa thông tin",
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              ),
            ),
            _buildProfileItem(
              context,
              Icons.lock,
              "Đổi mật khẩu",
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
              ),
            ),
            _buildProfileItem(
              context,
              Icons.history,
              "Lịch sử hoạt động",
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoryScreen()),
              ),
            ),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthProvider>().logout();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (r) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.2),
                ),
                child: const Text(
                  "Đăng Xuất",
                  style: TextStyle(color: Colors.redAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap,
  ) {
    return Card(
      color: const Color(0xFF2D3748),
      child: ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 14,
          color: Colors.grey,
        ),
        onTap: onTap,
      ),
    );
  }
}
