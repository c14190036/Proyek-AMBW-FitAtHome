class dcOlahraga {
  String? email;
  String? kalori;
  String? tanggal;
  String? durasi;
  String? olahraga;
  String? jam;

  dcOlahraga({
    this.email,
    this.kalori,
    this.tanggal,
    this.durasi,
    this.olahraga,
    this.jam
  });

  factory dcOlahraga.fromJson(json) {
    return dcOlahraga(
      email: json['email'],
      kalori: json['kalori'],
      tanggal: json['tanggal'],
      durasi: json['durasi'],
      olahraga: json['olahraga'],
      jam: json['jam']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "kalori": kalori,
      "tanggal": tanggal,
      "durasi": durasi,
      "olahraga": olahraga,
      "jam": jam
    };
  }

  
}