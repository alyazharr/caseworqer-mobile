import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class companyReview extends StatefulWidget {
  @override
  _companyReview createState() => _companyReview();
}

class _companyReview extends State<companyReview> {
  List<Jobs> _job = <Jobs>[];

  Future<List<Jobs>> fetchNotes() async {
    var url = 'http://caseworqer.herokuapp.com/company_review/json-joblist';
    var response = await http.get(url);
    print(response);
    // ignore: deprecated_member_use
    var job = <Jobs>[];
    if (response.statusCode == 200) {
      print("200");
      var jobsJson = json.decode(response.body);
      print(jobsJson);
      for (var jobJson in jobsJson) {
        print(Jobs.fromJson(jobJson));
        job.add(Jobs.fromJson(jobJson));
      }
    }
    return job;
  }

  List<Review> _review = <Review>[];

  Future<List<Review>> getListPost() async {
    var url = 'http://caseworqer.herokuapp.com/company_review/json-jobrate';
    var response = await http.get(url);
    print(response);
    // ignore: deprecated_member_use
    var review = <Review>[];
    if (response.statusCode == 200) {
      print("200");
      var postJson = json.decode(response.body);
      print(postJson);
      for (var pJson in postJson) {
        print(Review.fromJson(pJson));
        review.add(Review.fromJson(pJson));
      }
    }
    return review;
  }

  @override
  void initState() {
    fetchNotes().then((value) {
      setState(() {
        _job.addAll(value);
      });
    });
    getListPost().then((value) {
      setState(() {
        _review.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Color(0xFFDA5144),
        title: Text('COMPANY REVIEW',
            style: TextStyle(fontFamily: 'Sansita One')),
        centerTitle: true,
      ),
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
                    color: Color.fromRGBO(205,73,57,50)
                  ),
                ),
                Text(
                  _job[index].fields["company"],
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
              MaterialPageRoute(
                  builder: (context) => ReviewPost(_review[index].pekerjaan)),
            );
          },
        );
      },
      itemCount: _job.length,
    ));
  }
}

class Jobs {
  String model = "";
  int pk = 0;

  Map<String, dynamic> fields = {};

  Jobs(this.model, this.pk, this.fields);

  Jobs.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields = json['fields'];
  }
}

class Review {
  String model = "";
  int pk = 0;
  int pekerjaan = 0;
  Map<String, dynamic> fields = {};

  Review(this.model, this.pk, this.fields, this.pekerjaan);

  Review.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields = json['fields'];
    pekerjaan = json['fields'][0];

  } 
}

class ReviewPost extends StatefulWidget {
  int id;

  ReviewPost(this.id);
  @override
  _ReviewPostState createState() => _ReviewPostState();
}

class _ReviewPostState extends State<ReviewPost>  {

  List<Review> _review = <Review>[];

  Future<List<Review>> getListPost() async {
    var url = 'http://caseworqer.herokuapp.com/company_review/json-jobrate';
    var response = await http.get(url);
    print(response);
    // ignore: deprecated_member_use
    var review = <Review>[];
    if (response.statusCode == 200) {
      print("200");
      var postJson = json.decode(response.body);
      print(postJson);
      for (var pJson in postJson) {
        print(Review.fromJson(pJson));
        review.add(Review.fromJson(pJson));
      }
    }
    return review;
  }

  @override
  void initState() {
    getListPost().then((value) {
      setState(() {
        _review.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Color(0xFFDA5144),
        title: Text('COMPANY REVIEW',
            style: TextStyle(fontFamily: 'Sansita One')),
        centerTitle: true,
      ),
    body: Container (
      child: ListView.builder(
        reverse: true,
        itemCount: _review.length,
        itemBuilder: (context, index) {
          return ListBody(children: <Widget> [
            Card(
              child: Padding(
                    padding: EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
              Row(
                children: <Widget>[
                  Column(children: <Widget>[
                    Image(
                      image: AssetImage(
                          'assets/images/profil_forum.jpg'),
                      width: 35,
                      height: 35,
                    ),
                  ]),
                  Text('    '),
                  Flexible(
                    child: Text(
                _review[index].fields["postTime"],
                style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(0, 0, 0, 50),
                fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text(
            _review[index].fields["description"],
              style: TextStyle(
                fontSize: 15,
                color:Color.fromRGBO(0, 0, 0, 50),
              ),
            ),
            const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  } 
}

// class ReviewForm extends StatefulWidget {
//   int id;

//   ReviewForm(this.id);
//   @override
//   _ReviewFormState createState() => _ReviewFormState();
// }

// class _ReviewFormState extends State<ReviewForm> {
  
// }
