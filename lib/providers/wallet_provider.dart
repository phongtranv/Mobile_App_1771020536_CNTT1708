import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../data/services/wallet_service.dart';

class WalletProvider extends ChangeNotifier {
  final _service = WalletService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<bool> deposit(double amount, XFile? image) async {
    if (image == null) return false;

    _isLoading = true;
    notifyListeners();

    final success = await _service.deposit(amount, image);

    _isLoading = false;
    notifyListeners();
    return success;
  }
}
