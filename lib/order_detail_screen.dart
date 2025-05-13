import 'package:flutter/material.dart';
import 'chat_screen.dart';

class OrderDetailScreen extends StatefulWidget {
  final String address;
  final DateTime pickupDate;
  final String pickupTime;
  final List<Map<String, dynamic>> selectedItems;
  final int totalWeight;
  final int totalPoints;
  final int serviceFee;
  final int finalTotal;

  OrderDetailScreen({
    required this.address,
    required this.pickupDate,
    required this.pickupTime,
    required this.selectedItems,
    required this.totalWeight,
    required this.totalPoints,
    required this.serviceFee,
    required this.finalTotal,
  });

  @override
  _OrderDetailScreenState createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  int _currentStep = 1; // 0: Confirmed, 1: In Progress, 2: Checking, 3: Completed

  @override
  Widget build(BuildContext context) {
    // Format date to display
    String formattedDate = "${widget.pickupDate.day} ${_getMonthName(widget.pickupDate.month)} ${widget.pickupDate.year}";
    
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        title: Text('Order'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusHeader(),
            _buildProgressStepper(),
            _buildPickerInfo(),
            SizedBox(height: 16),
            _buildDetailSection("Detail Penjemputan", [
              _buildDetailRow("Alamat", widget.address),
              _buildDetailRow("Waktu Penjemputan", 
                "$formattedDate, ${widget.pickupTime}")
            ]),
            SizedBox(height: 16),
            _buildWasteDetailCard(),
            SizedBox(height: 16),
            _buildPointEstimationCard(),
            SizedBox(height: 24),
            _buildCompleteButton(),
            SizedBox(height: 24),
            _buildHomeButton(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Picker Menuju Lokasi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Picker lagi ke lokasimu nih, pastikan kamu sedang berada di lokasi ya, biar picker gak ribet nyariin kamu',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressStepper() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      color: Colors.white,
      child: Row(
        children: [
          _buildStepCircle(0, "Order dikonfirmasi"),
          _buildStepConnector(0),
          _buildStepCircle(1, "Picker menuju lokasi"),
          _buildStepConnector(1),
          _buildStepCircle(2, "Cek dan Timbang"),
          _buildStepConnector(2),
          _buildStepCircle(3, "Setor Sampah Selesai"),
        ],
      ),
    );
  }

  Widget _buildStepCircle(int step, String label) {
    bool isActive = _currentStep >= step;
    bool isCurrent = _currentStep == step;

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: isActive ? Color(0xFF006FFD) : Colors.grey[300],
              shape: BoxShape.circle,
              border: isCurrent ? Border.all(color: Color(0xFF006FFD), width: 2) : null,
            ),
            child: Center(
              child: isActive 
                ? Icon(Icons.check, color: Colors.white, size: 20)
                : Text(
                    '${step + 1}',
                    style: TextStyle(color: Colors.grey[700], fontWeight: FontWeight.bold),
                  ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: isCurrent ? Color(0xFF006FFD) : Colors.grey[700],
              fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector(int step) {
    bool isActive = _currentStep > step;
    
    return Container(
      width: 20,
      height: 2,
      color: isActive ? Color(0xFF006FFD) : Colors.grey[300],
    );
  }

  Widget _buildPickerInfo() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/picker.png'),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Valentino (Picker)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Chat dengan picker',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF006FFD).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.chat_bubble_outline, color: Color(0xFF006FFD)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(pickerName: 'Valentino'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity, // Menjamin lebar Container mengikuti lebar layar
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, // Membuat konten mengikuti lebar container
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }


  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWasteDetailCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.recycling, color: Color(0xFF006FFD)),
              SizedBox(width: 8),
              Text(
                'Rincian Setor Sampah',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          ...widget.selectedItems.map((item) => _buildWasteItem(item)).toList(),
          Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Berat Awal',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${widget.totalWeight} Kg',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWasteItem(Map<String, dynamic> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              item['image'],
              width: 30,
              height: 30,
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Icon(Icons.circle, size: 12, color: Color(0xFF006FFD)),
                    SizedBox(width: 4),
                    Text(
                      '${item['price']}/kg',
                      style: TextStyle(
                        color: Color(0xFF006FFD),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            '${item['weight']}Kg',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPointEstimationCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.circle, size: 16, color: Color(0xFF006FFD)),
              SizedBox(width: 8),
              Text(
                'Estimasi Poin',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildPointRow('Total Berat Awal', '${widget.totalWeight}Kg'),
          SizedBox(height: 8),
          _buildPointRow('Jumlah Poin', '${widget.totalPoints}', showIcon: true),
          SizedBox(height: 8),
          _buildPointRow('Biaya Layanan', '${widget.serviceFee}', showIcon: true),
          Divider(height: 24),
          _buildPointRow('Total Estimasi Poin', '${widget.finalTotal}', showIcon: true, isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPointRow(String label, String value, {bool showIcon = false, bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label, 
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
        Row(
          children: [
            if (showIcon)
              Icon(Icons.circle, size: 12, color: Color(0xFF006FFD)),
            if (showIcon)
              SizedBox(width: 4),
            Text(
              value,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: isTotal ? Color(0xFF006FFD) : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompleteButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Handle completion
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF6FBAFF),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Setor Sampah Selesai',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildHomeButton() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/home');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF006FFD),
          padding: EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(
          'Kembali ke Beranda',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun',
      'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'
    ];
    return monthNames[month - 1];
  }
}