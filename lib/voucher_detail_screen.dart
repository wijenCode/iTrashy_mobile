import 'package:flutter/material.dart';

class VoucherDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text('Voucher', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF7F8FA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.asset(
                'assets/images/indomaret.png',
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0, -32, 0),
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/images/indomaret.png',
                        width: 120,
                        height: 48,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Voucher Belanja di Indomaret senilai Rp 5.000',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Nikmati kemudahan berbelanja di Indomaret dengan voucher belanja senilai Rp 5.000. Jangan lewatkan kesempatan untuk mendapatkan potongan belanja yang menyenangkan dengan menukarkan poin Anda sekarang!',
                    style: TextStyle(fontSize: 15, color: Colors.black87),
                  ),
                  SizedBox(height: 16),
                  Text('Syarat dan Ketentuan:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 6),
                  Text('• Voucher hanya berlaku di aplikasi Indomaret.\n• Voucher tidak dapat diuangkan atau digabungkan dengan promo lain.\n• Cek masa berlaku voucher sebelum digunakan.\n• Voucher hanya berlaku untuk transaksi dengan nominal lebih dari Rp 10.000.', style: TextStyle(fontSize: 14, color: Colors.black87)),
                  SizedBox(height: 24),
                  _PoinHargaCard(poin: '32.500', harga: '5.000'),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PoinHargaCard extends StatelessWidget {
  final String poin;
  final String harga;
  const _PoinHargaCard({required this.poin, required this.harga});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 24),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      decoration: BoxDecoration(
        color: Color(0xFFF1F6FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Poin kamu:', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/poin.png', width: 18, height: 18),
                      const SizedBox(width: 4),
                      Text(poin, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            height: 48,
            color: Colors.grey[300],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Harga:', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/poin.png', width: 18, height: 18),
                      const SizedBox(width: 4),
                      Text(harga, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
} 