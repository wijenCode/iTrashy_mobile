import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'artikel_detail.dart';

class TambahArtikelPage extends StatefulWidget {
  const TambahArtikelPage({super.key});

  @override
  State<TambahArtikelPage> createState() => _TambahArtikelPageState();
}

class _TambahArtikelPageState extends State<TambahArtikelPage> {
  final _formKey = GlobalKey<FormState>();
  final _judulController = TextEditingController();
  final _isiController = TextEditingController();

  File? _selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Artikel'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _judulController,
                  decoration: const InputDecoration(labelText: 'Judul Artikel'),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Judul wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _isiController,
                  decoration: const InputDecoration(labelText: 'Isi Artikel'),
                  maxLines: 5,
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Isi wajib diisi' : null,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.image),
                      label: const Text('Pilih Gambar'),
                    ),
                    const SizedBox(width: 12),
                    if (_selectedImage != null)
                      const Text('Gambar dipilih!', style: TextStyle(color: Colors.green)),
                  ],
                ),
                if (_selectedImage != null && !kIsWeb) ...[
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      _selectedImage!,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ] else if (_selectedImage != null && kIsWeb) ...[
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      _selectedImage!.path,
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArtikelDetail(
                            title: _judulController.text,
                            author: 'by Dummy',
                            publishDate: 'just now',
                            imagePath: _selectedImage != null ? _selectedImage!.path : '',
                            content: _isiController.text,
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
