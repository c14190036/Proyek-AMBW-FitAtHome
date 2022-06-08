class dcProfile {
  final String nama;
  final String tinggi;
  final String berat;

  dcProfile({
    required this.nama,
    required this.tinggi,
    required this.berat
  });

  Map<String, dynamic> toJson() {
    return {
      "nama" : nama,
      "tinggi" : tinggi,
      "berat" : berat
    };
  }

  factory dcProfile.fromJson(Map<String, dynamic> json) {
    return dcProfile(
      nama : json['judul'],
      tinggi : json['isi'],
      berat : json['berat']
    );
  }
}