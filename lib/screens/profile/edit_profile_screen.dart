import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart'; // Import Provider

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    // Lấy dữ liệu hiện tại từ Provider điền vào ô nhập
    final authProvider = context.read<AuthProvider>();
    _nameController = TextEditingController(text: authProvider.name);
    _phoneController = TextEditingController(text: authProvider.phone);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chỉnh Sửa Thông Tin"),
        backgroundColor: const Color(0xFF1A202C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
              ),
            ),
            const SizedBox(height: 30),

            // Ô nhập Tên
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Họ và Tên",
                prefixIcon: Icon(Icons.person, color: Colors.grey),
                filled: true,
                fillColor: Color(0xFF2D3748),
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),

            // Ô nhập SĐT
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                labelText: "Số điện thoại",
                prefixIcon: Icon(Icons.phone, color: Colors.grey),
                filled: true,
                fillColor: Color(0xFF2D3748),
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 40),

            // Nút Lưu
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Gọi hàm update trong Provider
                  context.read<AuthProvider>().updateUserInfo(
                    _nameController.text,
                    _phoneController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Cập nhật thành công!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context); // Quay về màn hình trước
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E676),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "LƯU THAY ĐỔI",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
