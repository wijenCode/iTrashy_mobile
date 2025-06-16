import 'package:flutter/material.dart';

class TransferDetailScreen extends StatelessWidget {
  const TransferDetailScreen({super.key});

  static const List<String> bankNames = ['BNI', 'Mandiri', 'BRI', 'BCA'];
  static const List<String> ewalletNames = ['GoPay', 'ShopeePay', 'DANA', 'OVO']; // Sesuaikan dengan urutan di transfer_screen.dart

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final type = args?['type'] ?? 'bank';
    final int nominalPoints = int.tryParse(args?['points'] ?? '0') ?? 0;
    final int adminFeePoints = args?['adminFee'] ?? 0;
    final String note = args?['note'] ?? '';

    String bankOrEwallet = '';
    String accountOrNumber = '';
    String noRekeningLabel = '';
    int totalPoints = nominalPoints + adminFeePoints;

    if (type == 'bank') {
      final int bankIdx = args?['bank'] ?? 0;
      bankOrEwallet = bankIdx >= 0 && bankIdx < bankNames.length ? bankNames[bankIdx] : '-';
      accountOrNumber = args?['account'] ?? '-';
      noRekeningLabel = 'No. Rekening';
    } else {
      final int ewalletIdx = args?['ewallet'] ?? 0;
      bankOrEwallet = ewalletIdx >= 0 && ewalletIdx < ewalletNames.length ? ewalletNames[ewalletIdx] : '-';
      accountOrNumber = args?['number'] ?? '-';
      noRekeningLabel = 'No. Ponsel';
    }

    // Konversi Poin ke Rupiah (1 Poin = Rp 0.50)
    final int nominalRupiah = (nominalPoints * 0.5).toInt();
    final int adminFeeRupiah = (adminFeePoints * 0.5).toInt(); // Biaya admin dalam poin dikonversi ke rupiah
    final int totalRupiah = (totalPoints * 0.5).toInt();

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Detail Transfer', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 32.0, bottom: 8),
                child: Text('Detail Transaksi', style: TextStyle(fontSize: 15)),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85, // Menyesuaikan lebar dengan mobile
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFD9D9D9), // Warna abu-abu yang lebih terang
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _row(type == 'bank' ? 'Bank' : 'E-Wallet', bankOrEwallet),
                  _row(noRekeningLabel, accountOrNumber),
                  _row('Jumlah Poin', '${_formatPoints(nominalPoints)} Poin'),
                  _row('Nominal', 'Rp ${_formatCurrency(nominalRupiah)}'),
                  _row('Biaya Admin', 'Rp ${_formatCurrency(adminFeeRupiah)}'),
                  const Divider(height: 32, thickness: 1),
                  _row('Total', 'Rp ${_formatCurrency(totalRupiah)}', isTotal: true),
                ],
              ),
            ),
            // Display notes if available
            if (note.isNotEmpty) ...[
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0, bottom: 8),
                  child: Text('Catatan:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(note, style: TextStyle(fontSize: 14)),
              ),
            ],
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.red, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                  ),
                  child: const Text('Batal', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 32),
                ElevatedButton(
                  onPressed: () {
                    // Logika untuk mengirim data transfer ke backend (mirip dengan form HTML POST)
                    // Anda perlu mengintegrasikan ini dengan API Anda.
                    // Contoh sederhana: Menavigasi kembali ke halaman utama setelah sukses
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home', // Ganti dengan rute halaman utama Anda
                      (route) => false,
                    );
                    // Tampilkan SnackBar sukses
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Transfer berhasil!'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        margin: const EdgeInsets.all(16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3366E2),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                    padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                  ),
                  child: const Text('Transfer', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: isTotal ? 16 : 15, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: isTotal ? 16 : 15, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }

  String _formatCurrency(int value) {
    final String str = value.toString();
    final RegExp reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return str.replaceAllMapped(reg, (Match match) => '.');
  }

  String _formatPoints(int value) {
    final String str = value.toString();
    final RegExp reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
    return str.replaceAllMapped(reg, (Match match) => '.');
  }
} 