class Karwayan {
  final String nama;
  final int umur;
  final Alamat alamat;
  final List<String> hobi;

  Karwayan({
    required this.nama,
    required this.umur,
    required this.alamat,
    required this.hobi,
  });

  factory Karwayan.fromJson(Map<String, dynamic> json) {
    return Karwayan(
      nama: json['nama'],
      umur: json['umur'],
      alamat: json['alamat'],
      hobi: json['hobi'],
    );
  }
}

class Alamat {
  final String jalan;
  final String kota;
  final String provinsi;

  Alamat({required this.jalan, required this.kota, required this.provinsi});

  factory Alamat.formJson(Map<String, dynamic> json) {
    return Alamat(
      jalan: json['jalan'],
      kota: json['kota'],
      provinsi: json['provinsi'],
    );
  }
}