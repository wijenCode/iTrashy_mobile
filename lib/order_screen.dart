import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Map<String, dynamic>> orders = [];
  bool isDataLoaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isDataLoaded) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        // Check if this is a new order or an update
        if (args.containsKey('isNewOrder') && args['isNewOrder'] == true) {
          // Add new order to the list
          setState(() {
            orders.add({
              'jenis': args['jenis'],
              'poin': args['poin'],
              'berat': args['berat'],
              'alamat': args['alamat'],
              'tanggal': args['tanggal'],
              'waktu': args['waktu'],
            });
          });
        } else {
          // Initialize with the passed order
          setState(() {
            orders = [args];
          });
        }
      }
      isDataLoaded = true;
    }
  }

  void _editOrder(int index) async {
    final result = await Navigator.pushNamed(
      context,
      '/edit_order',
      arguments: orders[index],
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        orders[index] = result;
      });
    }
  }

  void _deleteOrder(int index) {
    setState(() {
      orders.removeAt(index);
    });
  }

  void _addNewOrder() async {
    // Pass the current orders to PilihSampahScreen so it knows we're adding to existing orders
    final result = await Navigator.pushNamed(
      context,
      '/pilih_sampah',
      arguments: {'existingOrders': orders},
    );
    
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        orders.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Order',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFEAF2FF), Colors.white],
          ),
        ),
        child: orders.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.recycling, size: 80, color: Colors.green),
                    SizedBox(height: 16),
                    Text(
                      'Belum ada order.',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _addNewOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        'Setor Sampah Sekarang',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final data = orders[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${data['jenis']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: Colors.blue),
                                    onPressed: () => _editOrder(index),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _deleteOrder(index),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(color: Colors.grey[300]),
                          SizedBox(height: 8),
                          _buildDetailRow('Berat', '${data['berat']} kg'),
                          _buildDetailRow('Poin', '${data['poin']}'),
                          _buildDetailRow('Alamat', '${data['alamat']}'),
                          _buildDetailRow('Tanggal', '${data['tanggal'].toLocal().toString().split(" ")[0]}'),
                          _buildDetailRow('Waktu', '${data['waktu']}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addNewOrder,
        backgroundColor: Colors.green,
        icon: Icon(Icons.add),
        label: Text('Tambah Order'),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}