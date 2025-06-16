import 'package:flutter/material.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isBankSelected = true;
  String? _selectedBank;
  String? _selectedEwallet;
  final _bankAccountController = TextEditingController();
  final _bankPointsController = TextEditingController();
  final _bankNoteController = TextEditingController();
  final _ewalletNumberController = TextEditingController();
  final _ewalletPointsController = TextEditingController();
  final _ewalletNoteController = TextEditingController();

  // Daftar bank dan e-wallet
  static const List<String> _bankNames = ['BNI', 'Mandiri', 'BRI', 'BCA'];
  // Pastikan urutan e-wallet sama dengan di transfer_detail_screen.dart
  static const List<String> _ewalletNames = ['GoPay', 'ShopeePay', 'DANA', 'OVO'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _bankPointsController.addListener(_updateCalculation);
    _ewalletPointsController.addListener(_updateCalculation);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _bankPointsController.dispose();
    _bankNoteController.dispose();
    _ewalletNumberController.dispose();
    _ewalletPointsController.dispose();
    _ewalletNoteController.dispose();
    super.dispose();
  }

  void _updateCalculation() {
    setState(() {});
  }

  void _navigateToDetail() {
    if (_isBankSelected) {
      if (_selectedBank == null) {
        _showError('Pilih bank tujuan');
        return;
      }
      if (_bankAccountController.text.isEmpty) {
        _showError('Masukkan nomor rekening');
        return;
      }
      if (_bankPointsController.text.isEmpty || int.tryParse(_bankPointsController.text) == null || int.parse(_bankPointsController.text) < 25000) {
        _showError('Minimal transfer 25.000 Poin');
        return;
      }
      
      final int selectedBankIndex = _bankNames.indexOf(_selectedBank!);
      Navigator.pushNamed(
        context,
        '/transfer_detail',
        arguments: {
          'type': 'bank',
          'bank': selectedBankIndex, // Mengirim indeks
          'account': _bankAccountController.text,
          'points': _bankPointsController.text,
          'note': _bankNoteController.text,
          'adminFee': 2500,
        },
      );
    } else {
      if (_selectedEwallet == null) {
        _showError('Pilih e-wallet tujuan');
        return;
      }
      if (_ewalletNumberController.text.isEmpty) {
        _showError('Masukkan nomor ponsel');
        return;
      }
      if (_ewalletPointsController.text.isEmpty || int.tryParse(_ewalletPointsController.text) == null || int.parse(_ewalletPointsController.text) < 25000) {
        _showError('Minimal transfer 25.000 Poin');
        return;
      }

      final int selectedEwalletIndex = _ewalletNames.indexOf(_selectedEwallet!);
      Navigator.pushNamed(
        context,
        '/transfer_detail',
        arguments: {
          'type': 'ewallet',
          'ewallet': selectedEwalletIndex, // Mengirim indeks
          'number': _ewalletNumberController.text,
          'points': _ewalletPointsController.text,
          'note': _ewalletNoteController.text,
          'adminFee': 1000,
        },
      );
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Transfer',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Kartu Saldo
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFFED4B4), Color(0xFF54B68B)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/poin_logo.png',
                    height: 40,
                    width: 40,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Poin Terkumpul:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        '25.000',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Tab Bank/E-Wallet
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTabButton('Bank', 0),
                  ),
                  Expanded(
                    child: _buildTabButton('E-Wallet', 1),
                  ),
                ],
              ),
            ),

            // Form Transfer
            Padding(
              padding: const EdgeInsets.all(16),
              child: _isBankSelected ? _buildBankForm() : _buildEwalletForm(),
            ),

            // Riwayat Transfer
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Transfer Terakhir',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildTransferHistoryItem(
                    'BNI',
                    '1234567890',
                    '25.000',
                    'bank',
                  ),
                  _buildTransferHistoryItem(
                    'GoPay',
                    '081234567890',
                    '30.000',
                    'ewallet',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int index) {
    final bool isActive = _tabController.index == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _tabController.index = index;
          _isBankSelected = index == 0;
        });
      },
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF54B68B) : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  String _calculateTotal(String points, int adminFee) {
    if (points.isEmpty) return '0';
    try {
      final total = int.parse(points) + adminFee;
      return total.toString();
    } catch (e) {
      return '0';
    }
  }

  String _calculateRupiah(String points) {
    if (points.isEmpty) return '0';
    try {
      final rupiah = (int.parse(points) * 0.50).toStringAsFixed(0);
      return rupiah;
    } catch (e) {
      return '0';
    }
  }

  Widget _buildBankForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bank Tujuan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _bankNames.map((bank) => _buildBankOption(bank)).toList(),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: const Text(
            'Minimal transfer: 25.000 Poin',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _bankAccountController,
          decoration: const InputDecoration(
            labelText: 'Nomor Rekening',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _bankPointsController,
          decoration: const InputDecoration(
            labelText: 'Jumlah Poin',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildCalculationRow('Poin yang ditukar:', _bankPointsController.text.isEmpty ? '0' : _bankPointsController.text),
              _buildCalculationRow('Nilai Rupiah:', 'Rp ${_calculateRupiah(_bankPointsController.text)}'),
              _buildCalculationRow('Biaya Admin:', '2.500 Poin'),
              const Divider(),
              _buildCalculationRow(
                'Total:',
                '${_calculateTotal(_bankPointsController.text, 2500)} Poin',
                isBold: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _bankNoteController,
          decoration: const InputDecoration(
            labelText: 'Catatan (Opsional)',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _navigateToDetail,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF54B68B),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Lanjut',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEwalletForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'E-Wallet Tujuan',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _ewalletNames.map((ewallet) => _buildEwalletOption(ewallet)).toList(),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.yellow[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.yellow[200]!),
          ),
          child: const Text(
            'Minimal transfer: 25.000 Poin',
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _ewalletNumberController,
          decoration: const InputDecoration(
            labelText: 'Nomor Ponsel',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _ewalletPointsController,
          decoration: const InputDecoration(
            labelText: 'Jumlah Poin',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              _buildCalculationRow('Poin yang ditukar:', _ewalletPointsController.text.isEmpty ? '0' : _ewalletPointsController.text),
              _buildCalculationRow('Nilai Rupiah:', 'Rp ${_calculateRupiah(_ewalletPointsController.text)}'),
              _buildCalculationRow('Biaya Admin:', '1.000 Poin'),
              const Divider(),
              _buildCalculationRow(
                'Total:',
                '${_calculateTotal(_ewalletPointsController.text, 1000)} Poin',
                isBold: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _ewalletNoteController,
          decoration: const InputDecoration(
            labelText: 'Catatan (Opsional)',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _navigateToDetail,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF54B68B),
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Lanjut',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBankOption(String bank) {
    final bool isSelected = _selectedBank == bank;
    return GestureDetector(
      onTap: () => setState(() => _selectedBank = bank),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Image.asset(
          'assets/images/bank-${bank.toLowerCase()}.png',
          height: 40,
        ),
      ),
    );
  }

  Widget _buildEwalletOption(String ewallet) {
    final bool isSelected = _selectedEwallet == ewallet;
    return GestureDetector(
      onTap: () => setState(() => _selectedEwallet = ewallet),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[100] : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.transparent,
            width: 2,
          ),
        ),
        child: Image.asset(
          'assets/images/e-wallet-${ewallet.toLowerCase()}.png',
          height: 40,
        ),
      ),
    );
  }

  Widget _buildCalculationRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransferHistoryItem(String name, String number, String points, String type) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/${type == 'bank' ? 'bank' : 'e-wallet'}-${name.toLowerCase()}.png',
            height: 32,
            width: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  number,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                Text(
                  'Rp ${_calculateRupiah(points)}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '-$points Poin',
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
} 