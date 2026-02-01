import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart'; // Import AuthProvider

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final _amountController = TextEditingController();
  XFile? _selectedImage;
  String _qrUrl = "";

  final String bankId = "MB";
  final String accountNo = "99808092005";
  final String accountName = "TRAN VAN PHONG";

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() => _selectedImage = image);
  }

  void _updateQrCode(String value) {
    if (value.isEmpty) {
      setState(() => _qrUrl = "");
      return;
    }
    String url =
        "https://img.vietqr.io/image/$bankId-$accountNo-compact.png?amount=$value&addInfo=NAPTIEN&accountName=$accountName";
    setState(() => _qrUrl = url);
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Nạp Tiền"),
        backgroundColor: const Color(0xFF1A202C),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Bước 1: Nhập số tiền",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              onChanged: _updateQrCode,
              decoration: const InputDecoration(
                suffixText: "VNĐ",
                border: OutlineInputBorder(),
                labelText: "Nhập số tiền",
              ),
            ),
            const SizedBox(height: 20),
            if (_qrUrl.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Quét mã để chuyển khoản",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Image.network(_qrUrl, height: 200),
                  ],
                ),
              ),
            const SizedBox(height: 20),

            const Text(
              "Bước 2: Tải ảnh bằng chứng",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: _selectedImage == null
                    ? const Center(
                        child: Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.grey,
                        ),
                      )
                    : Image.file(File(_selectedImage!.path), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: authProvider.isLoading
                    ? null
                    : () async {
                        if (_amountController.text.isEmpty) return;
                        double amount =
                            double.tryParse(_amountController.text) ?? 0;

                        // GỌI HÀM DEPOSIT TỪ AUTH PROVIDER
                        final success = await context
                            .read<AuthProvider>()
                            .deposit(amount);

                        if (success && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Gửi yêu cầu thành công!"),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00E676),
                ),
                child: authProvider.isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "GỬI YÊU CẦU",
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
