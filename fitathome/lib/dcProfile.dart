class dcProfile {
  String? uid;
  String? email;
  String? nama;
  String? berat;
  String? tinggi;
  String? password;

  dcProfile({
    this.uid,
    this.email,
    this.nama,
    this.berat,
    this.tinggi,
    this.password
  });

  factory dcProfile.fromJson(json) {
    return dcProfile(
      uid: json['uid'],
      email: json['email'],
      nama: json['nama'],
      berat: json['berat'],
      tinggi: json['tinggi'],
      password: json['password']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "email": email,
      "nama": nama,
      "berat": berat,
      "tinggi": tinggi,
      "password": password
    };
  }

  
}