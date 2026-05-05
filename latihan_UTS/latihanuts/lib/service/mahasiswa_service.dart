import 'package:firebase_database/firebase_database.dart';

class MahasiswaService {
  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('Mahasiswa_list');

  Stream<Map<String, dynamic>> getMahasiswaList() {
    return _database.onValue.map((event) {
      final Map<String, dynamic> items = {};
      DataSnapshot snapshot = event.snapshot;

      if (snapshot.value != null) {
        Map<dynamic, dynamic> values =
            snapshot.value as Map<dynamic, dynamic>;

        values.forEach((key, value) {
          items[key] = {
            'nama': value['nama'],
            'foto': value['foto'],
            'umur': value['umur'],
            'deskripsi': value['deskripsi'],
          };
        });
      }

      return items;
    });
  }

  void addMahasiswaItem(String itemName) {
    _database.push().set({'name': itemName});
  }

  Future<void> removeMahasiswaItem(String key) async {
    await _database.child(key).remove();
  }
}