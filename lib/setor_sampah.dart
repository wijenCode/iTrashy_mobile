import 'package:flutter/material.dart';

import 'cart_screen.dart';

class SetorSampahScreen extends StatefulWidget {
  @override
  _SetorSampahScreenState createState() => _SetorSampahScreenState();
}

class _SetorSampahScreenState extends State<SetorSampahScreen> {
  List<Map<String, dynamic>> sampahList = [
    {'name': 'Botol Plastik', 'price': 1000, 'image': 'assets/images/botol_plastik.png', 'selected': false, 'weight': 1},
    {'name': 'Kertas', 'price': 500, 'image': 'assets/images/kertas.png', 'selected': false, 'weight': 1},
    {'name': 'Kaleng', 'price': 1500, 'image': 'assets/images/kaleng.png', 'selected': false, 'weight': 1},
    {'name': 'Kain', 'price': 1500, 'image': 'assets/images/kain.png', 'selected': false, 'weight': 1},
    {'name': 'Kardus', 'price': 1000, 'image': 'assets/images/kardus.png', 'selected': false, 'weight': 1},
  ];

  @override
  Widget build(BuildContext context) {
    int selectedCount = sampahList.where((item) => item['selected']).length;
    int totalWeight = sampahList.where((item) => item['selected']).fold(0, (sum, item) => sum + item['weight'] as int);
    int totalPrice = sampahList.where((item) => item['selected']).fold(0, (sum, item) => sum + (item['price'] * item['weight']) as int);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Sampah'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: sampahList.length,
              itemBuilder: (context, index) {
                return _buildSampahCard(sampahList[index]);
              },
            ),
          ),
          _buildSummary(selectedCount, totalWeight, totalPrice),
        ],
      ),
    );
  }

  Widget _buildSampahCard(Map<String, dynamic> sampah) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(
              sampah['image'],
              width: 60, // Tentukan lebar gambar
              height: 60, // Tentukan tinggi gambar
              fit: BoxFit.cover, // Pastikan gambar diisi sesuai ukuran
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    sampah['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${sampah['price']}/kg',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
            ),
            if (sampah['selected'])
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      setState(() {
                        if (sampah['weight'] > 1) {
                          sampah['weight']--;
                        } else {
                          sampah['selected'] = false;
                        }
                      });
                    },
                  ),
                  Text('${sampah['weight']} kg'),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        sampah['weight']++;
                      });
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        sampah['selected'] = false;
                        sampah['weight'] = 1;
                      });
                    },
                  ),
                ],
              )
            else
              ElevatedButton(
                child: Text('Add', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  setState(() {
                    sampah['selected'] = true;
                  });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF006FFD)),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummary(int count, int weight, int total) {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Jenis Sampah'),
              Text('$count'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Berat Sampah'),
              Text('$weight kg'),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Poin', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Image.asset(
                    'assets/images/poin.png',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 4),
                  Text(
                    '$total',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16),
          ElevatedButton(
            child: Text('Continue', style: TextStyle(color: Colors.white)),
            onPressed: count > 0
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CartScreen(
                          selectedItems: sampahList.where((item) => item['selected']).toList(),
                        ),
                      ),
                    );
                  }
                : null, // Tombol akan dinonaktifkan jika tidak ada sampah yang dipilih
            style: ElevatedButton.styleFrom(
              backgroundColor: count > 0 ? Color(0xFF006FFD) : Colors.grey, // Warna berubah jika tidak ada sampah yang dipilih
              minimumSize: Size(double.infinity, 50),
            ),
          ),
          if (count == 0)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                'Pilih setidaknya satu jenis sampah untuk melanjutkan',
                style: TextStyle(color: Colors.red, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}