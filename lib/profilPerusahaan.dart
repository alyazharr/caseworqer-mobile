// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class profilPerusahaan extends StatefulWidget {
  @override
  _profilPerusahaan createState() => _profilPerusahaan();
}

class _profilPerusahaan extends State<profilPerusahaan> {
  List<IsiProfilPerusahaan> attrIsiProfilPerusahaan = List<IsiProfilPerusahaan>();
  List<IsiPelamar> attrPelamar = List<IsiPelamar>();
  List<IsiLowonganKerja> attrLowonganKerja = List<IsiLowonganKerja>();

  String currentCompany;


  Future<List<IsiProfilPerusahaan>> fetchIsiProfilPerusahaan() async {
    var url = 'http://caseworqer.herokuapp.com/profilperusahaan/companiesjson';
    var response = await http.get(url);
    print(response);
    // ignore: deprecated_member_use
    var isiProfilPerusahaan = List<IsiProfilPerusahaan>();
    if (response.statusCode == 200) {
      print("StatusCode: 200");
      var isiProfilPerusahaanJson = json.decode(response.body);
      print(isiProfilPerusahaanJson);
      for (var profil in isiProfilPerusahaanJson) {
        print(IsiProfilPerusahaan.fromJson(profil));
        isiProfilPerusahaan.add(IsiProfilPerusahaan.fromJson(profil));
      }
    }
    return isiProfilPerusahaan;
  }

  Future<List<IsiPelamar>> fetchIsiPelamar() async {
    var url = 'http://caseworqer.herokuapp.com/profilperusahaan/pelamarjson';
    var response = await http.get(url);
    print(response);
    // ignore: deprecated_member_use
    var isiPelamar = List<IsiPelamar>();
    if (response.statusCode == 200) {
      print("StatusCode: 200");
      var isiPelamarJson = json.decode(response.body);
      print(isiPelamarJson);
      for (var data in isiPelamarJson) {
        print(IsiPelamar.fromJson(data));
        isiPelamar.add(IsiPelamar.fromJson(data));
      }
    }
    return isiPelamar;
  }

  Future<List<IsiLowonganKerja>> fetchIsiLowonganKerja() async {
    var url = 'http://caseworqer.herokuapp.com/profilperusahaan/lowonganjson';
    var response = await http.get(url);
    print(response);
    // ignore: deprecated_member_use
    var isiLowonganKerja = List<IsiLowonganKerja>();
    if (response.statusCode == 200) {
      print("StatusCode: 200");
      var isiLowonganJson = json.decode(response.body);
      print(isiLowonganJson);
      for (var data in isiLowonganJson) {
        print(IsiLowonganKerja.fromJson(data));
        isiLowonganKerja.add(IsiLowonganKerja.fromJson(data));
      }
    }
    return isiLowonganKerja;
  }

  @override
  void initState() {
    fetchIsiProfilPerusahaan().then((value) {
      setState(() {
        attrIsiProfilPerusahaan.addAll(value);
      });
    });

    fetchIsiPelamar().then((value) {
      setState(() {
        attrPelamar.addAll(value);
      });
    });

    fetchIsiLowonganKerja().then((value) {
      setState(() {
        attrLowonganKerja.addAll(value);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Profil Perusahaan"),
          backgroundColor: Colors.black,
          foregroundColor: Color(0xFFDA5144)),
      body: ListView.builder(
        itemCount: attrIsiProfilPerusahaan.length,
        itemBuilder: (context, index) {
          return InkWell(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    currentCompany =
                    attrIsiProfilPerusahaan[index].fields["companyName"],
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Alamat: " +
                        attrIsiProfilPerusahaan[index].fields["companyAddress"],
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Email: " +
                        attrIsiProfilPerusahaan[index].fields["companyEmail"],
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Telepon: " +
                        attrIsiProfilPerusahaan[index]
                            .fields["companyPhoneNumber"],
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Deskripsi:\n" +
                        attrIsiProfilPerusahaan[index]
                            .fields["companyDescription"],
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Lowongan tersedia:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Text(
                          "Klik salah satu lowongan (bila ada) untuk melihat identitas para pelamar.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(),
                          itemCount: attrLowonganKerja.length,
                          itemBuilder: (context, int index) {
                            return attrLowonganKerja[index].fields["company"] ==
                                currentCompany
                                ? Container(
                              color: Colors.lightGreen,
                              child: ListTile(
                                title: Text(
                                  attrLowonganKerja[index].fields["jobs"],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailPelamar(attrPelamar, attrLowonganKerja, attrLowonganKerja[index].pk)),
                                  );
                                },
                              ),
                            )
                                : SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        foregroundColor: Color(0xFFDA5144),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilPerusahaanForm()),
          ).then((value) => setState(() {}));
        },
      ),
    );
  }
}

class IsiProfilPerusahaan {
  String model = "";
  int pk = 0;
  Map<String, dynamic> fields = {};

  IsiProfilPerusahaan(this.model, this.pk, this.fields);

  IsiProfilPerusahaan.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields = json['fields'];
  }
}

class IsiPelamar {
  String model = "";
  int pk = 0;
  Map<String, dynamic> fields = {};

  IsiPelamar(this.model, this.pk, this.fields);

  IsiPelamar.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields = json['fields'];
  }
}

class IsiLowonganKerja {
  String model = "";
  int pk = 0;
  Map<String, dynamic> fields = {};

  IsiLowonganKerja(this.model, this.pk, this.fields);

  IsiLowonganKerja.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields = json['fields'];
  }
}

class DetailPelamar extends StatelessWidget {
  List<IsiPelamar> attrPelamar;
  List<IsiLowonganKerja> attrLowonganKerjaJson;
  int id;

  DetailPelamar(this.attrPelamar, this.attrLowonganKerjaJson, this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(attrLowonganKerjaJson[id-1].fields["jobs"]),
          backgroundColor: Colors.black,
          foregroundColor: Color(0xFFDA5144)),
      body: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(),
          itemCount: attrPelamar.length,
        itemBuilder: (context, index) {
          return attrPelamar[index].fields["idLowongan"] == id
              ? Container(
            padding: EdgeInsets.only(
                top: 20.0, bottom: 20.0, left: 20.0, right: 20.0),
            color: Colors.white,
            child: Column(
              children: <Widget> [
                Text(
                  attrPelamar[index].fields["nama"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Usia: " +
                      attrPelamar[index].fields["usia"].toString() + " tahun",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Pendidikan: " +
                      attrPelamar[index].fields["pendidikan"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Alamat: " +
                      attrPelamar[index].fields["alamat"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Email: " +
                      attrPelamar[index].fields["email"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Jenis Kelamin: " +
                      attrPelamar[index].fields["jenisKelamin"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Sertifikat Vaksin: " +
                      attrPelamar[index].fields["sertifikatVaksin"],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black54,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ]
            ),
          )
              : SizedBox.shrink();
        }
      )
    );
  }
}

class ProfilPerusahaanForm extends StatefulWidget {
  ProfilPerusahaanForm();

  @override
  _ProfilPerusahaanFormState createState() => _ProfilPerusahaanFormState();
}

class _ProfilPerusahaanFormState extends State<ProfilPerusahaanForm> {
  final _formKey = GlobalKey<FormState>();

  String companyName;
  String companyAddress;
  String companyEmail;
  String companyPhoneNumber;
  String companyDescription;
  String companyOwner;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Profil Perusahaan"),
          backgroundColor: Colors.black,
          foregroundColor: Color(0xFFDA5144)),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "PT Maju Gas Jaya",
                      labelText: "Nama Perusahaan",
                      icon: Icon(Icons.account_balance_sharp),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      print(value);
                      if (value.isEmpty) {
                        return 'Mohon isi nama perusahaan';
                      } else {
                        companyName = value;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 3,
                    decoration: new InputDecoration(
                      hintText:
                      "Jalan Sudirman No.5, Jakarta Selatan, DKI Jakarta 12230",
                      labelText: "Alamat Perusahaan",
                      icon: Icon(Icons.location_on_outlined),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      print(value);
                      if (value.isEmpty) {
                        return 'Mohon isi alamat perusahaan';
                      } else {
                        companyAddress = value;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "employment@majugasjaya.com",
                      labelText: "Email Perusahaan",
                      icon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      print(value);
                      if (value.isEmpty) {
                        return 'Mohon isi email perusahaan';
                      } else {
                        companyEmail = value;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "+62xxxxxxxxxx",
                      labelText: "Nomor Telepon Perusahaan",
                      icon: Icon(Icons.phone),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      print(value);
                      if (value.isEmpty) {
                        return 'Mohon isi nomor telepon perusahaan';
                      } else {
                        companyPhoneNumber = value;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 5,
                    decoration: new InputDecoration(
                      hintText:
                      "PT Maju Gas Jaya adalah perusahaan distributor gas terbesar di Asia Tenggara",
                      labelText: "Deskripsi Perusahaan",
                      icon: Icon(Icons.assignment_rounded),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      print(value);
                      if (value.isEmpty) {
                        return 'Mohon isi deskripsi perusahaan';
                      } else {
                        companyDescription = value;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "Anto Sutanto",
                      labelText: "Nama Pembuka Lowongan",
                      icon: Icon(Icons.people_alt),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      print(value);
                      if (value.isEmpty) {
                        return 'Mohon isi username Anda sebagai verifikasi';
                      } else {
                        companyOwner = value;
                      }
                      return null;
                    },
                  ),
                ),
                RaisedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Color(0xFFDA5144)),
                  ),
                  color: Colors.black,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      print("Memvalidasi...");
                      print("Nama Perusahaan: " + companyName);
                      print("Alamat Perusahaan: " + companyAddress);
                      print("Email Perusahaan: " + companyEmail);
                      print("Telepon Perusahaan: " + companyPhoneNumber);
                      print("Deskripsi Perusahaan: " + companyDescription);
                      print("Pembuka Lowongan: " + companyOwner);
                      print("Tervalidasi");

                      print(jsonEncode(<String, dynamic>{
                        'companyName': companyName,
                        'companyAddress': companyAddress,
                        'companyEmail': companyEmail,
                        'companyPhoneNumber': companyPhoneNumber,
                        'companyDescription': companyDescription,
                        'companyOwner': companyOwner
                      }));
                      final response = await http.post(
                        Uri.parse(
                            'http://caseworqer.herokuapp.com/profilperusahaan/formprofilperusahaan'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, dynamic>{
                          'companyName': companyName,
                          'companyAddress': companyAddress,
                          'companyEmail': companyEmail,
                          'companyPhoneNumber': companyPhoneNumber,
                          'companyDescription': companyDescription,
                          'companyOwner': companyOwner
                        }),
                      );
                      print(response.statusCode);
                      if (response.statusCode == 201 || response.statusCode == 200) {
                        print(response.statusCode);
                        Navigator.pop(context);
                      }
                      else {
                        throw Exception('Gagal mengirim data.');
                      }
                    }
                    else {
                      print("Gagal tervalidasi");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
