// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class lowonganKerja extends StatefulWidget {
  @override
  lowonganKerjaState createState() => lowonganKerjaState();
}

enum tipePekerjaan { WFH, WFO, Gabungan }

class lowonganKerjaState extends State<lowonganKerja> {
  String pekerjaan;
  String perusahaan;
  String lokasi;
  String tipePekerjaanCheck;
  String tentangPekerjaan;
  tipePekerjaan _character;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildPekerjaan() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Pekerjaan'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Pekerjaan harus diisi';
        }
      },
      onSaved: (String value) {
        pekerjaan = value;
      },
    );
  }

  Widget buildPerusahaan() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Perusahaan'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Nama Perusahaan harus diisi';
        }
      },
      onSaved: (String value) {
        perusahaan = value;
      },
    );
  }

  Widget buildLokasi() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Lokasi'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Lokasi harus diisi';
        }
      },
      onSaved: (String value) {
        lokasi = value;
      },
    );
  }

  Widget buildTipePekerjaan() {
    return null;
  }

  Widget buildTentangPekerjaan() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Tentang Pekerjaan'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Tentang Pekerjaan harus diisi';
        }
      },
      onSaved: (String value) {
        tentangPekerjaan = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Buka Lowongan Kerja")),
      body: Container(
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildPekerjaan(),
              buildPerusahaan(),
              buildLokasi(),
              Column(
                children: <Widget>[
                  const Text("Tipe Pekerjaan", textAlign: TextAlign.left),
                  ListTile(
                    title: const Text('WFH'),
                    leading: Radio<tipePekerjaan>(
                      value: tipePekerjaan.WFH,
                      groupValue: _character,
                      onChanged: (tipePekerjaan value) {
                        setState(() {
                          _character = value;
                          tipePekerjaanCheck = "WFH";
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('WFO'),
                    leading: Radio<tipePekerjaan>(
                      value: tipePekerjaan.WFO,
                      groupValue: _character,
                      onChanged: (tipePekerjaan value) {
                        setState(() {
                          _character = value;
                          tipePekerjaanCheck = "WFO";
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Gabungan'),
                    leading: Radio<tipePekerjaan>(
                      value: tipePekerjaan.Gabungan,
                      groupValue: _character,
                      onChanged: (tipePekerjaan value) {
                        setState(() {
                          _character = value;
                          tipePekerjaanCheck = "Gabungan";
                        });
                      },
                    ),
                  ),
                ],
              ),
              buildTentangPekerjaan(),
              SizedBox(height: 100),
              RaisedButton(
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 17,
                  ),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) {
                    return;
                  }
                  _formKey.currentState.save();
                  print(pekerjaan);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
