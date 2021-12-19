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

import 'package:flutter/material.dart';

class forum extends StatefulWidget {
  const forum({Key? key}) : super(key: key);
  @override
  _forum createState() => _forum();
}

class _forum extends State<forum> {
  final _formKey = GlobalKey<FormState>();

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
      body: Center(
        child: Container(
          width: 300,
          height: 700,
          child: Column(
            children: <Widget>[
              Text('\n'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(width: 125, height: 40, child: AddForumButton()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddForumButton extends StatelessWidget {
  const AddForumButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The GestureDetector wraps the button.
    return GestureDetector(
      // When the child is tapped, show a snackbar.
      onTap: () {
        Navigator.pushNamed(context, add_forum.addRoute);
      },
      // The custom button
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Color(0xFF689775),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: const Text('Add Forum',
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

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

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
  const add_forum({Key? key, required this.title}) : super(key: key);
  static const String addRoute = "/AddForum";
  final String title;
  @override
  AddForumPage createState() => AddForumPage();
}

class AddForumPage extends State<add_forum> {
  TextEditingController title_controller = new TextEditingController();
  TextEditingController message_controller = new TextEditingController();
  String pasteValue = "";

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
      body: Center(
        child: Container(
            width: 500,
            height: 700,
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
                  child: TextField(
                    controller: title_controller,
                    // onChanged: (text) {
                    //   print("Title : $text");
                    // },
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
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 300,
                  height: 100,
                  child: TextField(
                    controller: message_controller,
                    // onChanged: (text) {
                    //   print("Message : $text");
                    // },
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
                Text('\n'),
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        width: 123,
                        height: 40,
                        child: RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
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
      ),
    );
  }
}

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key}) : super(key: key);
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
  ResetButton({Key? key}) : super(key: key);
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
