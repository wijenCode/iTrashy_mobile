// import 'package:flutter/material.dart';

// class EdukasiScreen extends StatefulWidget {
//   const EdukasiScreen({Key? key}) : super(key: key);

//   @override
//   State<EdukasiScreen> createState() => _EdukasiscreenState();
// }

// class _EdukasiscreenState extends State<EdukasiScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         centerTitle: true,
//         title: const Text('Edukasi'),
//         bottom: TabBar(
//           controller: _tabController,
//           isScrollable: true,
//           labelStyle: const TextStyle(fontWeight: FontWeight.bold),
//           indicator: const BoxDecoration(),
//           unselectedLabelColor: Colors.blue[400],
//           labelColor: Colors.white,
//           tabs: [
//             _buildTab('ALL EVENTS', 0),
//             _buildTab('CONCERTS', 1),
//             _buildTab('TECHNOLOGY', 2),
//             _buildTab('SPORTS', 3),
//           ],
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           // Artikel Section
//           _buildSectionHeader('Artikel'),
//           const SizedBox(height: 10),
//           _buildArtikelList(),

//           // Events Kami Section
//           const SizedBox(height: 20),
//           const Text(
//             'Events Kami',
//             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 10),
//           _buildEventItem('Alicia Keys', 'Olinda, Brazil'),
//           _buildEventItem('Michael Jackson', 'Recife, Brazil'),

//           // Video Section
//           const SizedBox(height: 20),
//           _buildSectionHeader('Video'),
//           const SizedBox(height: 10),
//           _buildVideoList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildTab(String text, int index) {
//     return Tab(
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20),
//           color: _tabController.index == index ? Colors.blue[800] : Colors.blue[50],
//         ),
//         child: Text(
//           text,
//           style: TextStyle(
//             color: _tabController.index == index ? Colors.white : Colors.blue[400],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSectionHeader(String title) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         TextButton(
//           onPressed: () {},
//           child: const Text('See more'),
//         ),
//       ],
//     );
//   }

//   Widget _buildArtikelList() {
//     return SizedBox(
//       height: 200,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           _buildArtikelCard(
//             'Mendaur ulang sampah secara mandiri',
//             'by ITrachy - 1 months ago',
//             'assets/images/recycle.jpg',
//           ),
//           const SizedBox(width: 10),
//           _buildArtikelCard(
//             'Membuat pupuk organik untuk tanaman',
//             'by ITrachy - 1 months ago',
//             'assets/images/organic.jpg',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildArtikelCard(String title, String subtitle, String imagePath) {
//     return Container(
//       width: 280,
//       margin: const EdgeInsets.only(right: 16),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => ArtikelDetail(
//                 title: title,
//                 author: subtitle.split(' - ')[0],
//                 publishDate: subtitle.split(' - ')[1],
//                 imagePath: imagePath,
//                 content: 'Mendaur ulang sampah secara mandiri adalah langkah penting dalam mengurangi dampak negatif sampah terhadap lingkungan.',
//               ),
//             ),
//           );
//         },
//         child: Card(
//           clipBehavior: Clip.antiAlias,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Image.asset(
//                   imagePath,
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       subtitle,
//                       style: TextStyle(color: Colors.grey[600], fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildEventItem(String title, String location) {
//     return ListTile(
//       leading: Container(
//         width: 40,
//         height: 40,
//         color: Colors.grey[300],
//         child: const Icon(Icons.image),
//       ),
//       title: Text(title),
//       subtitle: Text(location),
//       trailing: const Icon(Icons.chevron_right),
//     );
//   }

//   Widget _buildVideoList() {
//     return SizedBox(
//       height: 200,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: [
//           _buildVideoCard(
//             'Mendaur ulang sampah secara mandiri',
//             'assets/images/recycle.jpg',
//           ),
//           const SizedBox(width: 10),
//           _buildVideoCard(
//             'Membuat pupuk organik untuk tanaman',
//             'assets/images/organic.jpg',
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildVideoCard(String title, String imagePath) {
//     return Container(
//       width: 280,
//       margin: const EdgeInsets.only(right: 16),
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => VideoDetail(
//                 title: title,
//                 author: 'by ITrachy',
//                 publishDate: '1 months ago',
//                 imagePath: imagePath,
//               ),
//             ),
//           );
//         },
//         child: Card(
//           clipBehavior: Clip.antiAlias,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 child: Stack(
//                   fit: StackFit.expand,
//                   children: [
//                     Image.asset(
//                       imagePath,
//                       fit: BoxFit.cover,
//                     ),
//                     const Center(
//                       child: Icon(
//                         Icons.play_circle_outline,
//                         size: 50,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   title,
//                   style: const TextStyle(fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }