import 'package:flutter/material.dart';
import 'artikel_detail.dart';
import 'video_detail.dart';
import 'tambah_artikel.dart';

class EdukasiBeranda extends StatefulWidget {
  const EdukasiBeranda({super.key});

  @override
  State<EdukasiBeranda> createState() => _EdukasiberandaState();
}

class _EdukasiberandaState extends State<EdukasiBeranda> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: const Text('Edukasi'),
          bottom: TabBar(
            controller: _tabController,
            isScrollable: true,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            indicator: const BoxDecoration(),
            unselectedLabelColor: Colors.blue[400],
            labelColor: Colors.white,
            tabs: [
              _buildTab('ALL EVENTS', 0),
              _buildTab('CONCERTS', 1),
              _buildTab('TECHNOLOGY', 2),
              _buildTab('SPORTS', 3),
            ],
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Artikel',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.blue),
                      tooltip: 'Tambah Artikel',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TambahArtikelPage(),
                          ),
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('See more'),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildArtikelCard(
                    'Mendaur ulang sampah secara mandiri',
                    'by ITrachy - 1 months ago',
                    'assets/images/daur ulang kerajinan.png',
                  ),
                  const SizedBox(width: 10),
                  _buildArtikelCard(
                    'Membuat pupuk organik untuk tanaman',
                    'by ITrachy - 1 months ago',
                    'assets/images/gambar2.png',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Events Kami',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildEventItem('Alicia Keys', 'Olinda, Brazil'),
            _buildEventItem('Michael Jackson', 'Recife, Brazil'),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Video',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('See more'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildVideoCard(
                    'Mendaur ulang sampah secara mandiri',
                    'assets/images/daur ulang kerajinan.png',
                  ),
                  const SizedBox(width: 10),
                  _buildVideoCard(
                    'Membuat pupuk organik untuk tanaman',
                    'assets/images/gambar2.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, int index) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: _tabController.index == index ? Colors.blue[800] : Colors.blue[50],
        ),
        child: Text(
          text,
          style: TextStyle(
            color: _tabController.index == index ? Colors.white : Colors.blue[400],
          ),
        ),
      ),
    );
  }

  Widget _buildArtikelCard(String title, String subtitle, String imagePath) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArtikelDetail(
                title: title,
                author: subtitle.split(' - ')[0],
                publishDate: subtitle.split(' - ')[1],
                imagePath: imagePath,
                content: 'Mendaur ulang sampah secara mandiri adalah langkah penting dalam mengurangi dampak negatif sampah terhadap lingkungan.',
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEventItem(String title, String location) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F9FC),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFFE3F0FF),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: const Icon(Icons.image, color: Color(0xFF90CAF9), size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 4),
                Text(location, style: TextStyle(color: Colors.grey, fontSize: 14)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 28),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _buildVideoCard(String title, String imagePath) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VideoDetail(
                title: title,
                author: 'by ITrashy',
                publishDate: '1 months ago',
                imagePath: imagePath,
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 120,
                    ),
                  ),
                  const Positioned.fill(
                    child: Center(
                      child: Icon(
                        Icons.play_circle_outline,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
