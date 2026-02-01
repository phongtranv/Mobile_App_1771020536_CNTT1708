import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/auth_provider.dart';
import '../auth/login_screen.dart';

// ... (Giữ nguyên class AdminHomeScreen và _buildStatCard, _buildMenuCard như cũ) ...
// ... (Nếu bạn lười tìm thì cứ để nguyên phần đầu, chỉ cần thay thế các class con bên dưới) ...

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    final requestCount = provider.depositRequests.length;

    return Scaffold(
      backgroundColor: const Color(0xFF1A202C),
      appBar: AppBar(
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF2D3748),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.redAccent),
            onPressed: () {
              context.read<AuthProvider>().logout();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Doanh thu",
                    "1.6M",
                    Colors.green,
                    Icons.attach_money,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    "Tiền nạp",
                    "111M",
                    Colors.purpleAccent,
                    Icons.account_balance_wallet,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    "Thành viên",
                    "${provider.members.length}",
                    Colors.blue,
                    Icons.people,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildStatCard(
                    "Yêu cầu nạp",
                    "$requestCount",
                    Colors.orange,
                    Icons.notifications_active,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 1.3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                _buildMenuCard(
                  context,
                  "Thành Viên",
                  Icons.group,
                  Colors.blue,
                  const AdminMemberScreen(),
                ),
                _buildMenuCard(
                  context,
                  "Sân Bãi",
                  Icons.stadium,
                  Colors.green,
                  const AdminCourtScreen(),
                ),
                _buildMenuCard(
                  context,
                  "Giải Đấu",
                  Icons.emoji_events,
                  Colors.amber,
                  const AdminTournamentScreen(),
                ),
                _buildMenuCard(
                  context,
                  "Duyệt Nạp Tiền",
                  Icons.attach_money,
                  Colors.purple,
                  const AdminDepositScreen(),
                  badge: requestCount,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    Color color,
    IconData icon,
  ) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withOpacity(0.5)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    ),
  );
  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget screen, {
    int badge = 0,
  }) => Material(
    color: const Color(0xFF2D3748),
    borderRadius: BorderRadius.circular(16),
    child: InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => screen),
      ),
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: color),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          if (badge > 0)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "$badge",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
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

// ---------------------------------------------------------
// CÁC MÀN HÌNH CON CỦA ADMIN (Cập nhật AdminTournamentScreen)
// ---------------------------------------------------------

class AdminMemberScreen extends StatefulWidget {
  const AdminMemberScreen({super.key});
  @override
  State<AdminMemberScreen> createState() => _AdminMemberScreenState();
}

class _AdminMemberScreenState extends State<AdminMemberScreen> {
  String _searchQuery = "";
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    final filteredList = provider.members
        .where(
          (m) => m['name'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ),
        )
        .toList();
    void showMemberDialog({int? index}) {
      final nameCtrl = TextEditingController(
        text: index != null ? filteredList[index]['name'] : "",
      );
      final phoneCtrl = TextEditingController(
        text: index != null ? filteredList[index]['phone'] : "",
      );
      String rank = index != null ? filteredList[index]['rank'] : "Đồng";
      showDialog(
        context: context,
        builder: (ctx) => StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: const Color(0xFF2D3748),
            title: Text(
              index == null ? "Thêm Thành Viên" : "Sửa Thông Tin",
              style: const TextStyle(color: Colors.white),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "Họ tên",
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                TextField(
                  controller: phoneCtrl,
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: "SĐT",
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: rank,
                  dropdownColor: const Color(0xFF2D3748),
                  style: const TextStyle(color: Colors.white),
                  isExpanded: true,
                  items: ["Đồng", "Bạc", "Vàng", "Kim cương"]
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (v) => setState(() => rank = v!),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("Hủy"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (index == null) {
                    context.read<AuthProvider>().addMember(
                      nameCtrl.text,
                      phoneCtrl.text,
                      rank,
                    );
                  } else {
                    final realIndex = provider.members.indexOf(
                      filteredList[index],
                    );
                    context.read<AuthProvider>().editMember(
                      realIndex,
                      nameCtrl.text,
                      phoneCtrl.text,
                      rank,
                    );
                  }
                  Navigator.pop(ctx);
                },
                child: const Text("Lưu"),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A202C),
      appBar: AppBar(
        title: const Text("Quản Lý Thành Viên"),
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showMemberDialog(),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Tìm kiếm...",
                hintStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: const Color(0xFF2D3748),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (val) => setState(() => _searchQuery = val),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final item = filteredList[index];
                return Card(
                  color: const Color(0xFF2D3748),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(item['name'][0])),
                    title: Text(
                      item['name'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      "${item['phone']} - ${item['rank']}",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => showMemberDialog(index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            final realIndex = provider.members.indexOf(item);
                            context.read<AuthProvider>().deleteMember(
                              realIndex,
                            );
                          },
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

class AdminCourtScreen extends StatelessWidget {
  const AdminCourtScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    void showCourtDialog({int? index}) {
      final nameCtrl = TextEditingController(
        text: index != null ? provider.courts[index]['name'] : "",
      );
      final priceCtrl = TextEditingController(
        text: index != null ? provider.courts[index]['price'].toString() : "",
      );
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF2D3748),
          title: Text(
            index == null ? "Thêm Sân" : "Sửa Sân",
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameCtrl,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Tên sân",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
              TextField(
                controller: priceCtrl,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Giá/giờ",
                  labelStyle: TextStyle(color: Colors.grey),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Hủy"),
            ),
            ElevatedButton(
              onPressed: () {
                if (index == null)
                  context.read<AuthProvider>().addCourt(
                    nameCtrl.text,
                    double.parse(priceCtrl.text),
                  );
                else
                  context.read<AuthProvider>().editCourt(
                    index,
                    nameCtrl.text,
                    double.parse(priceCtrl.text),
                  );
                Navigator.pop(ctx);
              },
              child: const Text("Lưu"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A202C),
      appBar: AppBar(
        title: const Text("Quản Lý Sân Bãi"),
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showCourtDialog(),
        backgroundColor: const Color(0xFF00E676),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.courts.length,
        itemBuilder: (context, index) {
          final item = provider.courts[index];
          return Card(
            color: const Color(0xFF2D3748),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.stadium, color: Colors.green),
              title: Text(
                item['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "${NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(item['price'])} / giờ",
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => showCourtDialog(index: index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () =>
                        context.read<AuthProvider>().deleteCourt(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// 3. MÀN HÌNH GIẢI ĐẤU (ĐÃ SỬA: THÊM CHI TIẾT KHI CHẠM)
class AdminTournamentScreen extends StatelessWidget {
  const AdminTournamentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    // Hàm hiển thị chi tiết giải đấu
    void showDetail(Map<String, dynamic> item) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          backgroundColor: const Color(0xFF2D3748),
          title: Text(
            item['name'],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailRow("Thời gian:", "${item['date']} - ${item['endDate']}"),
              _detailRow("Thể thức:", "${item['format']}"),
              _detailRow("Số VĐV:", "${item['participants']} người"),
              _detailRow(
                "Phí tham dự:",
                NumberFormat.currency(
                  locale: 'vi_VN',
                  symbol: 'đ',
                ).format(item['fee'] ?? 0),
              ),
              _detailRow(
                "Giải thưởng:",
                NumberFormat.currency(
                  locale: 'vi_VN',
                  symbol: 'đ',
                ).format(item['prize'] ?? 0),
              ),
              const Divider(color: Colors.grey),
              Text(
                "Đã đăng ký: ${(item['registeredUsers'] as List?)?.length ?? 0} người",
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Đóng"),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A202C),
      appBar: AppBar(
        title: const Text("Giải Đấu"),
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateTournamentScreen(),
          ),
        ),
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: provider.tournaments.length,
        itemBuilder: (context, index) {
          final item = provider.tournaments[index];
          return Card(
            color: const Color(0xFF2D3748),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              onTap: () => showDetail(item), // <--- THÊM SỰ KIỆN CHẠM VÀO ĐÂY
              leading: const Icon(
                Icons.emoji_events,
                color: Colors.amber,
                size: 30,
              ),
              title: Text(
                item['name'],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ngày: ${item['date']} - ${item['endDate']}",
                    style: const TextStyle(color: Colors.grey),
                  ),
                  // Hiển thị thêm phí ở đây để Admin dễ check
                  Text(
                    "Phí: ${NumberFormat.compact().format(item['fee'] ?? 0)}đ",
                    style: const TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(color: Colors.grey)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class CreateTournamentScreen extends StatefulWidget {
  const CreateTournamentScreen({super.key});
  @override
  State<CreateTournamentScreen> createState() => _CreateTournamentScreenState();
}

class _CreateTournamentScreenState extends State<CreateTournamentScreen> {
  final _nameCtrl = TextEditingController();
  final _feeCtrl = TextEditingController();
  final _prizeCtrl = TextEditingController();
  DateTime? _startDate, _endDate;
  String _format = "Loại trực tiếp";
  int _participants = 16;

  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null)
      setState(() => isStart ? _startDate = picked : _endDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Tạo giải đấu"),
        backgroundColor: const Color(0xFF2E7D32),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameCtrl,
              decoration: const InputDecoration(
                labelText: "Tên giải đấu",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _pickDate(true),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: "Ngày bắt đầu",
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        _startDate == null
                            ? "dd/mm/yyyy"
                            : DateFormat('dd/MM/yyyy').format(_startDate!),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () => _pickDate(false),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: "Ngày kết thúc",
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        _endDate == null
                            ? "dd/mm/yyyy"
                            : DateFormat('dd/MM/yyyy').format(_endDate!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: _format,
              decoration: const InputDecoration(
                labelText: "Thể thức",
                border: OutlineInputBorder(),
              ),
              items: [
                "Loại trực tiếp",
                "Vòng tròn",
              ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (v) => setState(() => _format = v!),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              value: _participants,
              decoration: const InputDecoration(
                labelText: "Số VĐV",
                border: OutlineInputBorder(),
              ),
              items: [8, 16, 32]
                  .map((e) => DropdownMenuItem(value: e, child: Text("$e")))
                  .toList(),
              onChanged: (v) => setState(() => _participants = v!),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _feeCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Phí tham dự (VNĐ)",
                border: OutlineInputBorder(),
              ),
            ), // Đã ghi rõ VNĐ
            const SizedBox(height: 10),
            TextField(
              controller: _prizeCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Giải thưởng (VNĐ)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthProvider>().addTournamentFull({
                    "name": _nameCtrl.text,
                    "date": _startDate != null
                        ? DateFormat('dd/MM').format(_startDate!)
                        : "TBA",
                    "endDate": _endDate != null
                        ? DateFormat('dd/MM').format(_endDate!)
                        : "TBA",
                    "format": _format,
                    "participants": _participants,
                    "fee":
                        double.tryParse(_feeCtrl.text) ??
                        0.0, // Chuyển đổi sang số để hiển thị đúng bên User
                    "prize": double.tryParse(_prizeCtrl.text) ?? 0.0,
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Tạo giải đấu thành công!"),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                ),
                child: const Text(
                  "Tạo Giải Đấu",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminDepositScreen extends StatelessWidget {
  const AdminDepositScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    return Scaffold(
      backgroundColor: const Color(0xFF1A202C),
      appBar: AppBar(
        title: const Text("Duyệt Nạp Tiền"),
        backgroundColor: const Color(0xFF2D3748),
        foregroundColor: Colors.white,
      ),
      body: provider.depositRequests.isEmpty
          ? const Center(
              child: Text(
                "Không có yêu cầu nào",
                style: TextStyle(color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.depositRequests.length,
              itemBuilder: (context, index) {
                final item = provider.depositRequests[index];
                return Card(
                  color: const Color(0xFF2D3748),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['user'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "+ ${NumberFormat.currency(locale: 'vi_VN', symbol: 'đ').format(item['amount'])}",
                              style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.red),
                              onPressed: () => context
                                  .read<AuthProvider>()
                                  .rejectDeposit(index),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 30,
                              ),
                              onPressed: () => context
                                  .read<AuthProvider>()
                                  .approveDeposit(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
