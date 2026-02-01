import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'api_client.dart';

class WalletService {
  final Dio _dio = ApiClient().dio;

  Future<bool> deposit(double amount, XFile imageFile) async {
    try {
      // Chuẩn bị dữ liệu gửi đi (Dạng Multipart để gửi kèm file)
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        "Amount": amount,
        "ProofImage": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      final response = await _dio.post('/Wallet/deposit', data: formData);
      return response.statusCode == 200;
    } catch (e) {
      print("Lỗi nạp tiền: $e");
      return false;
    }
  }
}
