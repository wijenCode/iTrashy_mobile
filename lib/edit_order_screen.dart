import 'package:flutter/material.dart';

class EditOrderScreen extends StatefulWidget {
  @override
  _EditOrderScreenState createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  final List<Map<String, dynamic>> jenisSampah = [
    {'nama': 'Plastik', 'poin': 10},
    {'nama': 'Kertas', 'poin': 8},
    {'nama': 'Logam', 'poin': 15},
    {'nama': 'Kaca', 'poin': 12},
  ];

  final List<String> waktuOptions = [
    '07:00 - 09:00',
    '09:00 - 11:00',
    '13:00 - 15:00',
    '15:00 - 17:00',
  ];

  String? selectedSampah;
  double berat = 0.0;
  String alamat = '';
  DateTime? tanggal;
  String? selectedWaktu;
  Map<String, dynamic>? originalOrder;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load the order data from arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && originalOrder == null) {
      originalOrder = args;
      selectedSampah = args['jenis'];
      berat = args['berat'];
      alamat = args['alamat'];
      tanggal = args['tanggal'];
      selectedWaktu = args['waktu'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Order'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Jenis Sampah',
                border: OutlineInputBorder(),
              ),
              value: selectedSampah,
              onChanged: (value) => setState(() => selectedSampah = value),
              items: jenisSampah
                  .map((item) => DropdownMenuItem<String>(
                        value: item['nama'],
                        child: Text('${item['nama']} - ${item['poin']} poin'),
                      ))
                  .toList(),
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: berat.toString(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Berat (kg)',
                border: OutlineInputBorder(),
              ),
              onChanged: (val) => berat = double.tryParse(val) ?? 0.0,
            ),
            SizedBox(height: 16),
            TextFormField(
              initialValue: alamat,
              decoration: InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              onChanged: (val) => alamat = val,
            ),
            SizedBox(height: 16),
            InkWell(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: tanggal ?? DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (picked != null) setState(() => tanggal = picked);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(tanggal == null
                        ? 'Pilih Tanggal'
                        : 'Tanggal: ${tanggal!.toLocal().toString().split(' ')[0]}'),
                    Icon(Icons.calendar_today),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Waktu Pengambilan',
                border: OutlineInputBorder(),
              ),
              value: selectedWaktu,
              onChanged: (value) => setState(() => selectedWaktu = value),
              items: waktuOptions
                  .map((w) => DropdownMenuItem(
                        value: w,
                        child: Text(w),
                      ))
                  .toList(),
            ),
            SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Batal',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF006FFD),
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () {
                      if (_validateInputs()) {
                        final updatedOrder = {
                          'jenis': selectedSampah,
                          'poin': jenisSampah
                              .firstWhere((el) => el['nama'] == selectedSampah)['poin'],
                          'berat': berat,
                          'alamat': alamat,
                          'tanggal': tanggal,
                          'waktu': selectedWaktu,
                        };
                        Navigator.pop(context, updatedOrder);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _validateInputs() {
    if (selectedSampah == null) {
      _showErrorSnackBar('Pilih jenis sampah');
      return false;
    }
    
    if (berat <= 0) {
      _showErrorSnackBar('Masukkan berat sampah yang valid');
      return false;
    }
    
    if (alamat.isEmpty) {
      _showErrorSnackBar('Masukkan alamat pengambilan');
      return false;
    }
    
    if (tanggal == null) {
      _showErrorSnackBar('Pilih tanggal pengambilan');
      return false;
    }
    
    if (selectedWaktu == null) {
      _showErrorSnackBar('Pilih waktu pengambilan');
      return false;
    }
    
    return true;
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }
}