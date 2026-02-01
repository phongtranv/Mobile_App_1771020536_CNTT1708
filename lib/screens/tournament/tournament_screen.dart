import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/auth_provider.dart';

class TournamentScreen extends StatelessWidget {
  const TournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    final tournaments = provider.tournaments;
    final currentUser = provider.name;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Giải Đấu"),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: tournaments.isEmpty
          ? Center(
              child: Text(
                "Chưa có giải đấu nào",
                style: TextStyle(color: Colors.grey[600]),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tournaments.length,
              itemBuilder: (context, index) {
                final item = tournaments[index];
                List<dynamic> registered = item['registeredUsers'] ?? [];
                bool isRegistered = registered.contains(currentUser);
                double fee = double.tryParse(item['fee'].toString()) ?? 0.0;

                return Card(
                  elevation: 2,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: const BoxDecoration(
                          color: Color(0xFF2E7D32),
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.emoji_events, color: Colors.amber),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                item['name'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Text(
                              "Đang mở",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _infoRow(
                              Icons.calendar_today,
                              "Thời gian:",
                              "${item['date']} - ${item['endDate']}",
                            ),
                            _infoRow(
                              Icons.group,
                              "Số lượng:",
                              "${item['participants']} VĐV (${item['format']})",
                            ),
                            _infoRow(
                              Icons.confirmation_number,
                              "Phí tham dự:",
                              fee == 0
                                  ? "Miễn phí"
                                  : NumberFormat.currency(
                                      locale: 'vi_VN',
                                      symbol: 'đ',
                                    ).format(fee),
                            ),
                            _infoRow(
                              Icons.monetization_on,
                              "Giải thưởng:",
                              NumberFormat.currency(
                                locale: 'vi_VN',
                                symbol: 'đ',
                              ).format(item['prize'] ?? 0),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isRegistered
                                    ? null
                                    : () async {
                                        // Gọi hàm đăng ký và chờ kết quả
                                        bool success = await context
                                            .read<AuthProvider>()
                                            .registerTournament(index);

                                        if (context.mounted) {
                                          if (success) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Đăng ký thành công!",
                                                ),
                                                backgroundColor: Colors.green,
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Số dư không đủ để đăng ký!",
                                                ),
                                                backgroundColor: Colors.red,
                                              ),
                                            );
                                          }
                                        }
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isRegistered
                                      ? Colors.grey
                                      : const Color(0xFF2E7D32),
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(
                                  isRegistered ? "ĐÃ ĐĂNG KÝ" : "ĐĂNG KÝ NGAY",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.grey)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
