import 'package:flutter/material.dart';

class PilihSampahScreen extends StatefulWidget {
  @override
  _PilihSampahScreenState createState() => _PilihSampahScreenState();
}

class _PilihSampahScreenState extends State<PilihSampahScreen> {
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
  List<Map<String, dynamic>>? existingOrders;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Check if we have existing orders passed as arguments
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('existingOrders')) {
      existingOrders = List<Map<String, dynamic>>.from(args['existingOrders']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setor Sampah',
          style: TextStyle(
            color: Colors.black, // Ganti dengan warna yang kamu mau
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Color(0xFFEAF2FF),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Sampah',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      _buildDropdown(
                        'Jenis Sampah',
                        selectedSampah,
                        (value) => setState(() => selectedSampah = value),
                        jenisSampah.map((item) => DropdownMenuItem<String>(
                          value: item['nama'],
                          child: Text('${item['nama']} - ${item['poin']} poin'),
                        )).toList(),
                      ),
                      SizedBox(height: 16),
                      _buildTextField(
                        'Berat (kg)',
                        (val) => berat = double.tryParse(val) ?? 0.0,
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Informasi Pengambilan',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      _buildTextField(
                        'Alamat',
                        (val) => alamat = val,
                        maxLines: 3,
                      ),
                      SizedBox(height: 16),
                      _buildDatePicker(),
                      SizedBox(height: 16),
                      _buildDropdown(
                        'Waktu Pengambilan',
                        selectedWaktu,
                        (value) => setState(() => selectedWaktu = value),
                        waktuOptions.map((w) => DropdownMenuItem(
                          value: w,
                          child: Text(w),
                        )).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Kirim',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (_validateInputs()) {
                    final newOrder = {
                      'jenis': selectedSampah,
                      'poin': jenisSampah
                          .firstWhere((el) => el['nama'] == selectedSampah)['poin'],
                      'berat': berat,
                      'alamat': alamat,
                      'tanggal': tanggal,
                      'waktu': selectedWaktu,
                    };

                    if (existingOrders != null) {
                      // We're adding to existing orders, so return the new order to be added
                      Navigator.pop(context, newOrder);
                    } else {
                      // First order, navigate to order screen with isNewOrder flag
                      Navigator.pushNamed(
                        context, 
                        '/order', 
                        arguments: {
                          ...newOrder,
                          'isNewOrder': true,
                        }
                      );
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String? value, Function(String?) onChanged, List<DropdownMenuItem<String>> items) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      value: value,
      onChanged: onChanged,
      items: items,
    );
  }

  Widget _buildTextField(String label, Function(String) onChanged, {int? maxLines, TextInputType? keyboardType}) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      onChanged: onChanged,
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (picked != null) setState(() => tanggal = picked);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Tanggal Pengambilan',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              tanggal == null
                  ? 'Pilih Tanggal'
                  : 'Tanggal: ${tanggal!.toLocal().toString().split(' ')[0]}',
            ),
            Icon(Icons.calendar_today),
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