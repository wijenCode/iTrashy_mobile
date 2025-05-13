import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final PageController _bannerController = PageController();
  int _currentBannerIndex = 0;

                
  // Daftar gambar lokal
  List<String> imagePaths = [
    'assets/images/gambar1.png',
    'assets/images/gambar2.png',
    'assets/images/gambar3.png',
    'assets/images/gambar4.png',
    'assets/images/gambar5.png',
  ];

  // Kontroller untuk mengatur perpindahan halaman
  void navigateToPage(int index) {
    setState(() {
      _selectedIndex = index;
      // Di sini Anda bisa menambahkan logika untuk berpindah halaman
      switch (index) {
        case 0:
          // Sudah di halaman Home, tidak perlu navigasi
          break;
        case 1:
          Navigator.pushNamed(context, '/order');
          break;
        case 3:
          Navigator.pushNamed(context, '/notification');
          break;
        case 4:
          Navigator.pushNamed(context, '/profile');
          break;
      }
      // Misalnya menggunakan Navigator.push atau mengubah widget yang ditampilkan
    });
  }
  
  // Mengatur timer untuk slide banner
  void setupBannerTimer() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _bannerController.animateToPage(
          (_currentBannerIndex + 1) % 5,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        setupBannerTimer(); // Memanggil kembali untuk membuat loop
      }
    });
  }

  @override
  void initState() {
    super.initState();
    setupBannerTimer();
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with profile
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(
                              'https://i.pravatar.cc/300'),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hello!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Lucas Scott',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Icon(
                                  Icons.verified,
                                  color: Colors.amber[600],
                                  size: 16,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
              
              // Balance Card
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.green[400],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    // Balance part
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Color(0xFFE7F4E8),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.blue[700],
                            child: const Text(
                              'T',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              '7.500',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: Colors.blue[700],
                          ),
                        ],
                      ),
                    ),
                    
                    // Menu icons
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildMenuIcon(Icons.swap_horiz, 'Transfer'),
                          _buildMenuIcon(Icons.card_giftcard, 'Voucher'),
                          _buildMenuIcon(Icons.inventory_2, 'Sembako'),
                          _buildMenuIcon(Icons.favorite, 'Donasi'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              // Banner
              const SizedBox(height: 16),
              SizedBox(
                height: 160,
                child: PageView.builder(
                  controller: _bannerController,
                  itemCount: imagePaths.length, // Sesuaikan jumlah item dengan banyak gambar
                  onPageChanged: (index) {
                    setState(() {
                      _currentBannerIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    // Menampilkan gambar lokal berdasarkan index
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage(imagePaths[index]), // Menggunakan gambar berdasarkan index
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Banner indicator
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imagePaths.length, // Sesuaikan dengan jumlah gambar
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    height: 8,
                    width: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentBannerIndex == index
                          ? Colors.blue
                          : Colors.grey[300],
                    ),
                  ),
                ),
              ),

              
              // Education Section
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Edukasi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'See more',
                        style: TextStyle(
                          color: Colors.blue[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Education Cards
              SizedBox(
                height: 220,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    _buildEducationCard(
                      'https://images.unsplash.com/photo-1562077981-4d7eafd44932?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80',
                      'Mendaur ulang sampah secara mandiri',
                      'by iTrashy • 1 months ago',
                    ),
                    _buildEducationCard(
                      'https://images.unsplash.com/photo-1523348837708-15d4a09cfac2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2940&q=80',
                      'Membuat pupuk organik untuk tanaman',
                      'by iTrashy • 1 months ago',
                    ),
                  ],
                ),
              ),
              
              // Bottom padding for scroll space
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      
      // Floating Bottom Navigation Bar
      bottomNavigationBar: Container(
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
      ),
    );
  }

  Widget _buildMenuIcon(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.green[700],
            size: 24,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildEducationCard(String imageUrl, String title, String subtitle) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              imageUrl,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
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