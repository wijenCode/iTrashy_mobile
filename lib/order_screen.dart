import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Kelas untuk menyimpan data pesanan
class OrderItem {
  final String id;
  String address;
  DateTime date;
  TimeOfDay time;
  double totalWeight;
  int totalPoints;
  List<Map<String, dynamic>> selectedItems;
  String status;

  OrderItem({
    required this.id,
    required this.address,
    required this.date,
    required this.time,
    required this.totalWeight,
    required this.totalPoints,
    required this.selectedItems,
    this.status = 'Proses',
  });
}

// Singleton untuk mengelola daftar pesanan
class OrderList {
  static final OrderList _instance = OrderList._internal();
  factory OrderList() => _instance;
  OrderList._internal();

  List<OrderItem> orders = [];

  void addOrder(OrderItem order) {
    // Cek apakah order dengan ID yang sama sudah ada
    int existingIndex = orders.indexWhere((o) => o.id == order.id);
    if (existingIndex >= 0) {
      orders[existingIndex] = order;
    } else {
      orders.add(order);
    }
  }

  void removeOrder(String id) {
    orders.removeWhere((order) => order.id == id);
  }

  List<OrderItem> getOngoingOrders() {
    return orders.where((order) => order.status == 'Proses').toList();
  }

  List<OrderItem> getHistoryOrders() {
    return orders.where((order) => order.status != 'Proses').toList();
  }
}

class OrderScreen extends StatefulWidget {
  final String? address;
  final DateTime? date;
  final TimeOfDay? time;
  final double? totalWeight;
  final int? totalPoints;
  final List<Map<String, dynamic>>? selectedItems;

  OrderScreen({
    this.address,
    this.date,
    this.time,
    this.totalWeight,
    this.totalPoints,
    this.selectedItems,
  });

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 1; // Set to 1 for "Order" tab
  final OrderList _orderList = OrderList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Tambahkan pesanan baru jika ada data dari parameter
    _addNewOrderIfNeeded();
  }
  
  void _addNewOrderIfNeeded() {
    if (widget.address != null && 
        widget.date != null && 
        widget.time != null && 
        widget.selectedItems != null && 
        widget.selectedItems!.isNotEmpty) {
      
      // Buat ID unik berdasarkan waktu
      String orderId = DateTime.now().millisecondsSinceEpoch.toString();
      
      OrderItem newOrder = OrderItem(
        id: orderId,
        address: widget.address!,
        date: widget.date!,
        time: widget.time!,
        totalWeight: widget.totalWeight ?? 0,
        totalPoints: widget.totalPoints ?? 0,
        selectedItems: widget.selectedItems!,
      );
      
      _orderList.addOrder(newOrder);
      setState(() {}); // Refresh UI
    }
  }

  // Kontroller untuk navigasi halaman
  void navigateToPage(int index) {
    setState(() {
      _selectedIndex = index;
      // Logika untuk berpindah halaman
      switch (index) {
        case 0:
          Navigator.pushNamed(context, '/home');
          break;
        case 1:
          // Sudah di halaman Order, tidak perlu navigasi
          break;
        case 2:
          Navigator.pushNamed(context, '/setor_sampah');
          break;
        case 3:
          Navigator.pushNamed(context, '/notification');
          break;
        case 4:
          Navigator.pushNamed(context, '/profile');
          break;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setor Sampah'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Ongoing'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOngoingTab(),
          _buildHistoryTab(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildOngoingTab() {
    List<OrderItem> ongoingOrders = _orderList.getOngoingOrders();
    
    if (ongoingOrders.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.inbox_outlined,
                size: 80,
                color: Colors.grey[400],
              ),
              SizedBox(height: 16),
              Text(
                'Belum ada order setor sampah saat ini',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/pilih_sampah');
                },
                child: Text('Setor Sampah Sekarang'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );
    }
    
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: ongoingOrders.length,
      itemBuilder: (context, index) {
        return _buildOrderCard(ongoingOrders[index]);
      },
    );
  }

  Widget _buildHistoryTab() {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final transferHistory = args != null ? args['transferHistory'] : null;
    List<OrderItem> historyOrders = _orderList.getHistoryOrders();

    List<Widget> historyWidgets = [];
    if (transferHistory != null) {
      historyWidgets.add(_buildTransferHistoryCard(transferHistory));
    }

    if (historyOrders.isEmpty && transferHistory == null) {
      return Center(
        child: Text('Belum ada riwayat pesanan'),
      );
    }

    historyWidgets.addAll(List.generate(historyOrders.length, (index) => _buildOrderCard(historyOrders[index])));

    return ListView(
      padding: EdgeInsets.all(16),
      children: historyWidgets,
    );
  }

  Widget _buildTransferHistoryCard(Map<String, dynamic> data) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transfer',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Selesai',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            _buildInfoRow(Icons.account_balance, data['bankOrEwallet'] ?? '-'),
            SizedBox(height: 12),
            _buildInfoRow(Icons.numbers, data['accountOrNumber'] ?? '-'),
            SizedBox(height: 12),
            _buildInfoRow(Icons.attach_money, 'Nominal: ${data['nominal'] ?? '-'}'),
            SizedBox(height: 12),
            _buildInfoRow(Icons.money_off, 'Biaya Admin: ${data['adminFee'] ?? '-'}'),
            SizedBox(height: 12),
            _buildInfoRow(Icons.check_circle, 'Total: ${data['total'] ?? '-'}'),
            SizedBox(height: 12),
            _buildInfoRow(Icons.calendar_today, data['date'] != null ? DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(data['date'])) : '-'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(OrderItem order) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Setor Sampah',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: order.status == 'Proses' ? Colors.blue : Colors.green,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            _buildInfoRow(Icons.location_on, order.address),
            SizedBox(height: 12),
            _buildInfoRow(Icons.calendar_today, DateFormat('dd/MM/yyyy').format(order.date)),
            SizedBox(height: 12),
            _buildInfoRow(Icons.access_time, order.time.format(context)),
            SizedBox(height: 12),
            _buildInfoRow(Icons.delete_outline, 'Estimasi Berat: ${order.totalWeight} kg'),
            SizedBox(height: 12),
            _buildInfoRow(Icons.star_outline, 'Estimasi Poin: ${order.totalPoints}'),
            SizedBox(height: 16),
            Text('Jenis Sampah:', style: TextStyle(fontWeight: FontWeight.bold)),
            Column(
              children: order.selectedItems.map((item) => 
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item['name'] ?? ''),
                      Text('${item['weight'] ?? 0} kg'),
                    ],
                  ),
                )
              ).toList(),
            ),
            SizedBox(height: 16),
            if (order.status == 'Proses')
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _showEditOrderDialog(order);
                    },
                    child: Text('Edit'),
                  ),
                  SizedBox(width: 8),
                  TextButton(
                    onPressed: () {
                      _showCancelOrderDialog(order);
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: Text('Batalkan'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  void _showEditOrderDialog(OrderItem order) {
    // Implementasi dialog untuk mengedit pesanan
    // Ini hanya contoh sederhana, Anda bisa mengembangkannya sesuai kebutuhan
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Pesanan'),
        content: Text('Fitur edit pesanan akan segera tersedia.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Tutup'),
          ),
        ],
      ),
    );
  }

  void _showCancelOrderDialog(OrderItem order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Batalkan Pesanan'),
        content: Text('Apakah Anda yakin ingin membatalkan pesanan ini?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Tidak'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _orderList.removeOrder(order.id);
              });
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: Text('Ya, Batalkan'),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 80,
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _buildNavItem(Icons.home, 'Home', 0),
                ),
                Expanded(
                  child: _buildNavItem(Icons.receipt, 'Order', 1),
                ),
                const Expanded(child: SizedBox()), // Space for center button
                Expanded(
                  child: _buildNavItem(Icons.notifications_outlined, 'Notif', 3),
                ),
                Expanded(
                  child: _buildNavItem(Icons.person_outline, 'Profile', 4),
                ),
              ],
            ),
          ),
          // Center floating button
          Positioned(
            top: 0,
            child: InkWell(
              onTap: () {
                // Navigasi ke halaman Setor Sampah ketika tombol tengah ditekan
                Navigator.pushNamed(context, '/setor_sampah');
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[400],
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.delete_outline,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final bool isSelected = _selectedIndex == index;
    
    return InkWell(
      onTap: () {
        navigateToPage(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isSelected ? Colors.blue[600] : Colors.grey[500],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.blue[600] : Colors.grey[500],
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}