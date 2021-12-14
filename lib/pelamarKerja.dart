// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class pelamarKerja extends StatefulWidget {
  @override
  _pelamarKerja createState() => _pelamarKerja();
}

class _pelamarKerja extends State<pelamarKerja> {
  List<Job> _job = List<Job>();

  Future<List<Job>> fetchNotes() async {
    var url = 'http://caseworqer.herokuapp.com/pelamarkerja/json';
    var response = await http.get(url);
    print(response);
    // ignore: deprecated_member_use
    var job = List<Job>();
    if (response.statusCode == 200) {
      print("200");
      var jobsJson = json.decode(response.body);
      print(jobsJson);
      for (var jobJson in jobsJson) {
        print(Job.fromJson(jobJson));
        job.add(Job.fromJson(jobJson));
      }
    }
    return job;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _job.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          child: Padding(
            padding: EdgeInsets.only(
                top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _job[index].fields["jobs"],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _job[index].fields["company"],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  _job[index].fields["location"],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  _job[index].fields["jobType"],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  _job[index].fields["about"],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LamarForm()),
            );
          },
        );
      },
      itemCount: _job.length,
    ));
  }
}

class Job {
  String model = "";
  int pk = 0;
  Map<String, dynamic> fields = {};

  Job(this.model, this.pk, this.fields);

  Job.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields = json['fields'];
  }
}

class LamarForm extends StatefulWidget {
  @override
  _LamarFormState createState() => _LamarFormState();
}

enum jenisKelamin { Pria, Wanita }

class _LamarFormState extends State<LamarForm> {
  final _formKey = GlobalKey<FormState>();

  double nilaiSlider = 1;
  bool nilaiCheckBox = false;
  bool nilaiSwitch = true;
  jenisKelamin _character = jenisKelamin.Pria;
  static const TextStyle judulStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lamar Kerja"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text("Form Lamaran Kerja", style: judulStyle),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      hintText: "contoh: Susilo Bambang",
                      labelText: "Nama Lengkap",
                      icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "Usia",
                      icon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Usia tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "Pendidikan",
                      icon: Icon(Icons.school),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Pendidikan tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "Alamat",
                      icon: Icon(Icons.home),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Alamat tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "Email",
                      icon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return 'Email tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                ),
                Column(
                  children: <Widget>[
                    const Text("Jenis Kelamin", textAlign: TextAlign.left),
                    ListTile(
                      title: const Text('Pria'),
                      leading: Radio<jenisKelamin>(
                        value: jenisKelamin.Pria,
                        groupValue: _character,
                        onChanged: (jenisKelamin value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text('Wanita'),
                      leading: Radio<jenisKelamin>(
                        value: jenisKelamin.Wanita,
                        groupValue: _character,
                        onChanged: (jenisKelamin value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    obscureText: true,
                    decoration: new InputDecoration(
                      labelText: "Link Sertifikat Vaksin",
                      icon: Icon(Icons.link),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    if (_formKey.currentState.validate()) {}
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
