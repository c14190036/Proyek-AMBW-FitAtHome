class dcProfile {
  String? email;
  String? nama;
  String? berat;
  String? tinggi;
  String? bmi;
  String? bmiskor;

  dcProfile({
    this.email,
    this.nama,
    this.berat,
    this.tinggi,
    this.bmi,
    this.bmiskor
  });

  factory dcProfile.fromJson(json) {
    return dcProfile(
      email: json['email'],
      nama: json['nama'],
      berat: json['berat'],
      tinggi: json['tinggi'],
      bmi: json['bmi'],
      bmiskor: json['bmiskor']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "nama": nama,
      "berat": berat,
      "tinggi": tinggi,
      "bmi": bmi,
      "bmiskor": bmiskor
    };
  }

  
}