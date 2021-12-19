/// Flutter code sample for BottomNavigationBar

// This example shows a [BottomNavigationBar] as it is used within a [Scaffold]
// widget. The [BottomNavigationBar] has three [BottomNavigationBarItem]
// widgets, which means it defaults to [BottomNavigationBarType.fixed], and
// the [currentIndex] is set to index 0. The selected item is
// amber. The `_onItemTapped` function changes the selected item's index
// and displays a corresponding message in the center of the [Scaffold].

import 'package:flutter/material.dart';
import 'package:caseworqer/pelamarKerja.dart';
import 'package:caseworqer/tipsKarier.dart';
import 'package:caseworqer/forum.dart';
import 'package:caseworqer/companyReview.dart';
import 'package:caseworqer/user.dart';
import 'package:caseworqer/profilPerusahaan.dart';
import 'package:caseworqer/lowonganKerja.dart';
// import 'package:caseworqer/form.dart';

void main() => runApp(const MyApp());

/// This is the main application widget.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'CaseWorqer';

  @override
  Widget build(BuildContext context) {
    var add_routes = <String, WidgetBuilder>{
      add_forum.addRoute: (BuildContext context) =>
          new add_forum(title: "AddForum"),
    };
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: _title,
        theme: ThemeData(
          // Define the default font family.
          fontFamily: 'Rubik',
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.lightGreen.shade200,
            foregroundColor: Colors.deepOrange.shade900,
          ),

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
              headline6:
                  TextStyle(fontSize: 20.0, color: Colors.deepOrange.shade900)),
        ),
        home: MyStatefulWidget(),
        routes: {
          '/AddForum': (BuildContext context) =>
              new add_forum(title: "AddForum"),
        });
  }
}

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Text(
      'Welcome to CaseWorqer',
      style: optionStyle,
    ),
    pelamarKerja(),
    tipsKarier(),
    forum(),
    companyReview(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: const Text('Caseworqer'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.green,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.grey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work, color: Colors.grey),
            label: 'Lowongan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb, color: Colors.grey),
            label: 'Tips Karier',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Colors.grey),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star, color: Colors.grey),
            label: 'Company Review',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'My Profile',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/cover.jpg'))),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => user()))
            },
          ),
          ListTile(
            leading: Icon(Icons.business),
            title: Text('Perusahaan Saya'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => profilPerusahaan()))
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Buka Lowongan'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => lowonganKerja()))
            },
          ),
        ],
      ),
    );
  }
}

// void login() {
//   runApp(LoginPage());
// }
