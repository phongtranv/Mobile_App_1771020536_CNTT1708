import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/auth_provider.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime _selectedDate = DateTime.now();

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  void _showTimePicker(BuildContext context, dynamic court) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2D3748),
      builder: (ctx) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Đặt ${court['name']}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Ngày: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Text(
                "Chọn khung giờ:",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2.0,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    int hour = 14 + index;
                    return InkWell(
                      onTap: () async {
                        // Đặt sân
                        bool success = await context
                            .read<AuthProvider>()
                            .bookCourt(
                              court['id'],
                              DateFormat('dd/MM/yyyy').format(_selectedDate),
                              "$hour:00",
                            );

                        if (context.mounted) {
                          Navigator.pop(ctx); // Đóng bảng chọn giờ trước

                          // HIỆN THÔNG BÁO THÀNH CÔNG TẠI ĐÂY
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? "Đặt sân thành công!"
                                    : "Số dư không đủ!",
                              ),
                              backgroundColor: success
                                  ? Colors.green
                                  : Colors.red,
                              behavior:
                                  SnackBarBehavior.floating, // Nổi lên cho đẹp
                            ),
                          );
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00E676),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "$hour:00",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Đặt Sân"),
        backgroundColor: const Color(0xFF1A202C),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month, color: Color(0xFF00E676)),
            onPressed: _pickDate,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF2D3748),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Ngày đặt:",
                  style: TextStyle(color: Colors.white70),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(_selectedDate),
                  style: const TextStyle(
                    color: Color(0xFF00E676),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.courts.length,
              itemBuilder: (context, index) {
                final court = provider.courts[index];
                return Card(
                  color: const Color(0xFF2D3748),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              court['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${NumberFormat("#,###").format(court['price'])}đ/h",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          court['description'] ?? "",
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.sports_tennis),
                            label: const Text("CHỌN GIỜ ĐẶT"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF00E676),
                              foregroundColor: Colors.black,
                            ),
                            onPressed: () => _showTimePicker(context, court),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
