// import 'package:flutter/material.dart';

// class forum extends StatefulWidget {
//   @override
//   _forum createState() => _forum();
// }

// class _forum extends State<forum> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return Scaffold(body: Text("FORUM"));
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class forum extends StatefulWidget {
  @override
  _forum createState() => _forum();
}

class _forum extends State<forum> {
  final _formKey = GlobalKey<FormState>();

  // List<> _job = List<Job>();
  List<PostForum> _listForum = <PostForum>[];

  Future<List<PostForum>> getPostForum() async {
    var url = 'https://caseworqer.herokuapp.com/forum/json-forum';
    var response = await http.get(url);
    print(response);
    // ignore: deprecated_member_use
    var listForum = <PostForum>[];
    if (response.statusCode == 200) {
      print("200");
      var PostJson = json.decode(response.body);
      print(PostJson);
      for (var PostJson in PostJson) {
        print(PostForum.fromJson(PostJson));
        listForum.add(PostForum.fromJson(PostJson));
      }
    }
    return listForum;
  }

  @override
  void initState() {
    getPostForum().then((value) {
      setState(() {
        _listForum.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Color(0xFFDA5144),
        title: Text('CASEWORQER FORUM',
            style: TextStyle(fontFamily: 'Sansita One')),
        centerTitle: true,
      ),
      body: Container(
        child: ListView.builder(
            reverse: true,
            itemCount: _listForum.length,
            itemBuilder: (context, index) {
              return ListBody(children: <Widget>[
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
                                _listForum[index].fields["title"],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: primaryBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            const SizedBox(
                              width: 48,
                            ),
                            Text(
                              'by : ',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Text(
                              '@',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _listForum[index].fields["userPost"],
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' – ',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  _listForum[index]
                                      .fields["postTime"]
                                      .substring(0, 10),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                                Text('  '),
                                Text(
                                  _listForum[index]
                                      .fields["postTime"]
                                      .substring(11, 19),
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Text(''),
                        Text(
                          _listForum[index].fields["message"],
                          style: TextStyle(
                            fontSize: 15,
                            color: primaryBlack,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                Text(' ', style: TextStyle(fontSize: 6))
              ]);
            }),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF689775),
        foregroundColor: white,
        onPressed: () {
          // Navigator.pushNamed(context, add_forum.addRoute);
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return add_forum(0);
          }));
          ;
        },
      ),
    );
  }
}

class PostForum {
  String model = "";
  int pk = 0;
  Map<String, dynamic> fields = {};

  PostForum(this.model, this.pk, this.fields);

  PostForum.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields = json['fields'];
  }
}

class PostComment {
  String model = "";
  int pk = 0;
  Map<String, dynamic> fields = {};

  PostComment(this.model, this.pk, this.fields);

  PostComment.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields = json['fields'];
  }
}

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // The GestureDetector wraps the button.
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        Navigator.pop(context);
      },
      // The custom button
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color(0xFF689775),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text('Back to Forum',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: white,
                fontSize: 15,
                fontFamily: "Sansita One",
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class add_forum extends StatefulWidget {
  int id;
  add_forum(this.id);

  @override
  AddForumPage createState() => AddForumPage();
}

class AddForumPage extends State<add_forum> {
  TextEditingController title_controller = new TextEditingController();
  TextEditingController message_controller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late String titleForum;
  late String Message;
  late int id_forum;
  var now = DateTime.now();

  void clearAddForum() {
    title_controller.clear();
    message_controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Color(0xFFDA5144),
        title: Text('CASEWORQER FORUM',
            style: TextStyle(fontFamily: 'Sansita One')),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
                width: 500,
                height: 900,
                child: Column(
                  children: <Widget>[
                    Text('\n'),
                    Row(
                      children: <Widget>[
                        Text('     '),
                        Container(width: 155, height: 40, child: BackButton()),
                      ],
                    ),
                    Text('\n'),
                    Container(
                      width: 300,
                      height: 100,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your forum\'s title';
                          } else {
                            titleForum = value;
                          }
                          return null;
                        },
                        controller: title_controller,
                        decoration: InputDecoration(
                          fillColor: Colors.black12,
                          filled: true,
                          hintText: 'What\' Your Forum Title ?',
                          labelText: 'Post Title',
                          labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        maxLines: 20,
                      ),
                    ),
                    Text('\n'),
                    Container(
                      width: 300,
                      height: 300,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your forum\'s message';
                          } else {
                            Message = value;
                          }
                          return null;
                        },
                        controller: message_controller,
                        decoration: InputDecoration(
                            fillColor: Colors.black12,
                            filled: true,
                            hintText: 'Write Your Form Here ... ',
                            labelText: 'Post Message',
                            labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        maxLines: 12,
                      ),
                    ),
                    Text('\n'),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: <
                        Widget>[
                      Container(
                        width: 123,
                        height: 40,
                        child: RaisedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                id_forum = widget.id;
                                print("Forum tervalidasi");
                                print("Title Forum : ");
                                print(titleForum);
                                print("Message Forum : ");
                                print(Message);
                                print("end");

                                print(jsonEncode(<String, dynamic>{
                                  'title': titleForum,
                                  'message': Message,
                                  'postTime':
                                      '${now.year}-${now.month}-${now.day}T${now.hour}:${now.minute}:${now.second}.${now.millisecondsSinceEpoch}Z',
                                  'userPost': "Unknown",
                                }));

                                // Map<String, dynamic> toJson() => {
                                //       'title': titleForum,
                                //       'message': Message,
                                //     };
                                // print(jsonEncode(toJson));

                                final response = await http.post(
                                  Uri.parse(
                                      'https://caseworqer.herokuapp.com/forum/add'),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(<String, dynamic>{
                                    'title': titleForum,
                                    'message': Message,
                                    'postTime':
                                        '${now.year}-${now.month}-${now.day}T${now.hour}:${now.minute}:${now.second}.${now.millisecondsSinceEpoch}Z',
                                    'userPost': "Unknown",
                                  }),
                                );
                                print(response.statusCode);
                                if (response.statusCode == 201 ||
                                    response.statusCode == 200) {
                                  print(response.statusCode);
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Post Your Forum')),
                                  );
                                } else {
                                  throw Exception('Failed to create new post.');
                                }
                              }
                            },
                            color: Color(0xFF34ae57),
                            child: Text('Post to Forum',
                                style: TextStyle(color: Colors.white))),
                      ),
                      Text('  '),
                      Container(width: 75, height: 40, child: CancelButton()),
                      Text('  '),
                      Container(width: 75, height: 40, child: ResetButton()),
                      Text('       '),
                    ])
                  ],
                )),
          )),
    );
  }
}

class CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Do you really want to cancel ?'),
          content: const Text('All your written will be canceled and deleted'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              },
              child: const Text('Yes'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'No'),
              child: const Text('No'),
            ),
          ],
        ),
      ),
      // The custom button
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color(0xFFe93322),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text('Cancel',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: white, fontSize: 15, fontFamily: "Sansita One")),
      ),
    );
  }
}

class ResetButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () => {
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Do you really want to reset ?'),
            content: const Text('All your written will be deleted'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  // AddForumPage.title_controller.clear();
                  // AddForumPage.message_controller.clear();
                  Navigator.pop(context, 'OK');
                },
                child: const Text('OK'),
              ),
            ],
          ),
        ),
      },
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade600,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text('Reset',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: white, fontSize: 15, fontFamily: "Sansita One")),
      ),
    );
  }
}

const MaterialColor primaryBlack = MaterialColor(
  _blackPrimaryValue,
  <int, Color>{
    50: Color(0xFF000000),
    100: Color(0xFF000000),
    200: Color(0xFF000000),
    300: Color(0xFF000000),
    400: Color(0xFF000000),
    500: Color(_blackPrimaryValue),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);
const int _blackPrimaryValue = 0xFF000000;

const MaterialColor white = const MaterialColor(
  0xFFFFFFFF,
  const <int, Color>{
    50: const Color(0xFFFFFFFF),
    100: const Color(0xFFFFFFFF),
    200: const Color(0xFFFFFFFF),
    300: const Color(0xFFFFFFFF),
    400: const Color(0xFFFFFFFF),
    500: const Color(0xFFFFFFFF),
    600: const Color(0xFFFFFFFF),
    700: const Color(0xFFFFFFFF),
    800: const Color(0xFFFFFFFF),
    900: const Color(0xFFFFFFFF),
  },
);
