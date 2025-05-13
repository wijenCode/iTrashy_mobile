import 'package:flutter/material.dart';

class TukarPoinScreen extends StatefulWidget {
  const TukarPoinScreen({super.key});

  @override
  State<TukarPoinScreen> createState() => _TukarPoinScreenState();
}

class _TukarPoinScreenState extends State<TukarPoinScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Tukar Poin', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFF7F8FA),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF4AD394),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Saldo
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/poin.png',
                            width: 28,
                            height: 28,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '7.500',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Tombol Transfer & Donasi
                    Row(
                      children: [
                        _buildHeaderAction(
                          icon: Icons.account_balance_wallet_outlined,
                          label: 'Transfer',
                          color: const Color(0xFF4AD394),
                          iconBg: Colors.white,
                        ),
                        const SizedBox(width: 16),
                        _buildHeaderAction(
                          icon: Icons.favorite,
                          label: 'Donasi',
                          color: const Color(0xFF4AD394),
                          iconBg: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // TabBar
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            height: 48,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F6),
              borderRadius: BorderRadius.circular(16),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(14),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.blue,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              indicatorSize: TabBarIndicatorSize.tab,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              tabs: [
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text('Voucher'),
                ),
                Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: const Text('Sembako'),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildVoucherList(),
                _buildSembakoList(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderAction({required IconData icon, required String label, required Color color, required Color iconBg}) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: color, size: 32),
        ),
        const SizedBox(height: 6),
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildVoucherList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
        children: [
          _buildVoucherCard('assets/images/indomaret.png', 'Voucher Belanja di Indomaret senilai Rp 5.000', '5.000'),
          _buildVoucherCard('assets/images/alfamart.png', 'Voucher Belanja di Alfamart senilai Rp 5.000', '5.000'),
          _buildVoucherCard('assets/images/ayam.png', 'Voucher senilai Rp. 15.000 di Ayam Bakar', '15.000'),
          _buildVoucherCard('assets/images/nasipadang.png', 'Seporsi Nasi Padang dari RM Sari Bundo', '10.000'),
        ],
      ),
    );
  }

  Widget _buildVoucherCard(String image, String title, String point, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap ?? () {
        Navigator.pushNamed(context, '/voucher_detail');
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              child: Image.asset(
                image,
                height: 80,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
              child: Row(
                children: [
                  Icon(Icons.monetization_on, color: Colors.blue, size: 18),
                  const SizedBox(width: 4),
                  Text(point, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSembakoList() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
        children: [
          _buildVoucherCard('assets/images/beras.png', 'Beras 1Kg', '15.000', onTap: () {
            Navigator.pushNamed(context, '/sembako_detail');
          }),
          _buildVoucherCard('assets/images/gula.png', 'Gula Pasir 500G', '16.000', onTap: () {
            Navigator.pushNamed(context, '/sembako_detail');
          }),
          _buildVoucherCard('assets/images/minyak.png', 'Minyak Goreng 1L', '15.000', onTap: () {
            Navigator.pushNamed(context, '/sembako_detail');
          }),
          _buildVoucherCard('assets/images/telor.png', '1 Lusin Telor', '10.000', onTap: () {
            Navigator.pushNamed(context, '/sembako_detail');
          }),
        ],
      ),
    );
  }
}
