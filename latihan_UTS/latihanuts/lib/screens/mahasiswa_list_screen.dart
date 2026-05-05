import 'package:flutter/material.dart';
import 'package:latihanuts/service/mahasiswa_service.dart';

class MahasiswaListScreen extends StatelessWidget {
  final MahasiswaService _service = MahasiswaService();

  MahasiswaListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Mahasiswa")),

      body: StreamBuilder<Map<String, dynamic>>(
        stream: _service.getMahasiswaList(),
        builder: (context, snapshot) {

          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final items = snapshot.data!;

          if (items.isEmpty) {
            return const Center(child: Text("Belum ada data"));
          }

          return ListView(
            children: items.entries.map((entry) {
              final key = entry.key;
              final data = entry.value;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: data['foto'] != ''
                      ? NetworkImage(data['foto'])
                      : null,
                  child: data['foto'] == ''
                      ? const Icon(Icons.person)
                      : null,
                ),

                title: Text(data['nama'] ?? ''),

                subtitle: Text(
                  "Umur: ${data['umur']}\n${data['deskripsi']}",
                ),

                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    _service.removeMahasiswaItem(key);
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}