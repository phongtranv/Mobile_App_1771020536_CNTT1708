import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPassController = TextEditingController();
  final _newPassController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đổi Mật Khẩu"),
        backgroundColor: const Color(0xFF1A202C),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.lock_reset, size: 80, color: Colors.orange),
            const SizedBox(height: 30),

            _buildPassField("Mật khẩu hiện tại", _oldPassController),
            const SizedBox(height: 20),
            _buildPassField("Mật khẩu mới", _newPassController),
            const SizedBox(height: 20),
            _buildPassField("Xác nhận mật khẩu mới", _confirmPassController),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (_newPassController.text != _confirmPassController.text) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Mật khẩu xác nhận không khớp!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Đổi mật khẩu thành công!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "CẬP NHẬT MẬT KHẨU",
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

  Widget _buildPassField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true, // Ẩn mật khẩu
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.lock, color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFF2D3748),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
