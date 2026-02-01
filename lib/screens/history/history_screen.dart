import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart'; // CHỈ DÙNG AUTH PROVIDER

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Lịch Sử Hoạt Động"),
          backgroundColor: const Color(0xFF1A202C),
          foregroundColor: Colors.white,
          bottom: const TabBar(
            indicatorColor: Color(0xFF00E676),
            labelColor: Color(0xFF00E676),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(icon: Icon(Icons.sports_tennis), text: "Đặt Sân"),
              Tab(icon: Icon(Icons.account_balance_wallet), text: "Giao Dịch"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [BookingHistoryTab(), WalletHistoryTab()],
        ),
      ),
    );
  }
}

class BookingHistoryTab extends StatelessWidget {
  const BookingHistoryTab({super.key});
  @override
  Widget build(BuildContext context) {
    final bookings = context
        .watch<AuthProvider>()
        .myBookings; // Lấy từ AuthProvider
    if (bookings.isEmpty)
      return const Center(
        child: Text(
          "Chưa có lịch đặt sân nào",
          style: TextStyle(color: Colors.grey),
        ),
      );
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final item = bookings[index];
        return Card(
          color: const Color(0xFF2D3748),
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(
              Icons.event_available,
              color: Color(0xFF00E676),
              size: 30,
            ),
            title: Text(
              item['courtName'],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              "${item['date']} | ${item['time']}",
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: Text(
              "-${item['price']}đ",
              style: const TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

class WalletHistoryTab extends StatelessWidget {
  const WalletHistoryTab({super.key});
  @override
  Widget build(BuildContext context) {
    final transactions = context
        .watch<AuthProvider>()
        .transactions; // Lấy từ AuthProvider
    if (transactions.isEmpty)
      return const Center(
        child: Text(
          "Chưa có giao dịch nào",
          style: TextStyle(color: Colors.grey),
        ),
      );
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final item = transactions[index];
        final isDeposit = item['type'] == "Nạp tiền";
        return Card(
          color: const Color(0xFF2D3748),
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Icon(
              isDeposit ? Icons.arrow_circle_up : Icons.arrow_circle_down,
              color: isDeposit ? Colors.green : Colors.red,
              size: 30,
            ),
            title: Text(
              item['type'],
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              item['date'].toString(),
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${isDeposit ? '+' : '-'}${item['amount']}đ",
                  style: TextStyle(
                    color: isDeposit ? const Color(0xFF00E676) : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  item['status'],
                  style: TextStyle(
                    color: item['status'] == "Chờ duyệt"
                        ? Colors.orange
                        : Colors.green,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
