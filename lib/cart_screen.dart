import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;

  // Constructor dengan parameter selectedItems
  CartScreen({required this.selectedItems});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _addressController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedTime;
  final List<String> _timeSlots = ['08:00 - 10:00', '10:00 - 12:00', '13:00 - 15:00', '15:00 - 17:00'];

  @override
  Widget build(BuildContext context) {
    int totalWeight = widget.selectedItems.fold(0, (sum, item) => sum + (item['weight'] as int));
    int totalPoints = widget.selectedItems.fold(0, (sum, item) => sum + (item['price'] * item['weight'] as int));
    int serviceFee = (totalPoints * 0.2).round();
    int finalTotal = totalPoints - serviceFee;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection('Pickup Location', _buildLocationInput()),
              _buildSection('Pickup Time', Column(
                children: [
                  _buildTimeDropdown(),
                  SizedBox(height: 8),
                  _buildDatePicker(),
                ],
              )),
              _buildSection('Waste Type', Column(
                children: widget.selectedItems.map((item) => _buildWasteItem(item)).toList(),
              )),
              _buildSection('Estimasi Poin', _buildEstimationCard(totalWeight, totalPoints, serviceFee, finalTotal)),
              SizedBox(height: 16),
              ElevatedButton(
                child: Text('Continue', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  // Handle continue action
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF006FFD),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        content,
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildLocationInput() {
    return TextField(
      controller: _addressController,
      decoration: InputDecoration(
        hintText: 'Masukkan Alamat',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildTimeDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: 'Pilih Waktu Pickup',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      value: _selectedTime,
      onChanged: (String? newValue) {
        setState(() {
          _selectedTime = newValue;
        });
      },
      items: _timeSlots.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _buildDatePicker() {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _selectedDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(Duration(days: 30)),
        );
        if (picked != null && picked != _selectedDate) {
          setState(() {
            _selectedDate = picked;
          });
        }
      },
      child: InputDecorator(
        decoration: InputDecoration(
          hintText: 'Pilih Tanggal Pickup',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_selectedDate == null ? 'Pilih Tanggal Pickup' : DateFormat('dd/MM/yyyy').format(_selectedDate!)),
            Icon(Icons.calendar_today),
          ],
        ),
      ),
    );
  }

  Widget _buildWasteItem(Map<String, dynamic> item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(item['image'], width: 60, height: 60),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('${item['price']}/kg', style: TextStyle(color: Colors.blue)),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (item['weight'] > 1) {
                        item['weight']--;
                      } else {
                        widget.selectedItems.remove(item);
                      }
                    });
                  },
                ),
                Text('${item['weight']} kg'),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      item['weight']++;
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      widget.selectedItems.remove(item);
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstimationCard(int totalWeight, int totalPoints, int serviceFee, int finalTotal) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildEstimationRow('Berat Awal', '$totalWeight kg'),
            _buildEstimationRow('Jumlah Poin', totalPoints.toString()),
            _buildEstimationRow('Biaya Layanan (20%)', serviceFee.toString()),
            Divider(),
            _buildEstimationRow('Total', finalTotal.toString(), isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildEstimationRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, color: isTotal ? Colors.blue : null)),
        ],
      ),
    );
  }
}