import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;


class Artikel {
  String model = "";
  int pk = 0;
  Map<String, dynamic> fields = {};

  Artikel(this.model, this.pk, this.fields);

  Artikel.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields = json['fields'];
  }
}


class ArtikelDetail extends StatelessWidget {
  final Artikel berita;
  const ArtikelDetail({
    Key? key,
    required this.berita,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Caseworqer")
      ),
      body:
      Container(
          padding: EdgeInsets.only(top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
          // child:Text(berita.fields["Title"]),
               
          child:ListView(
            children:[

              Text(berita.fields["Title"],
                style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                ),
              ),
              Html( data: berita.fields["Article"],)
            ]
          )  
      )
    );
  }
}
// Search Bar Widget
class BeritaApi {
  static Future<List<Artikel>> getBooks(String query) async {
    final url = Uri.parse('http://caseworqer.herokuapp.com/tipskarier/json/');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List beritas = json.decode(response.body);

      return beritas.map((json) => Artikel.fromJson(json)).where((news) {
        final titleLower = news.fields["Title"].toLowerCase();
        final summaryLower = news.fields["Summary"].toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            summaryLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    controller.clear();
                    widget.onChanged('');
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}

class tipsKarier extends StatefulWidget {
  @override
  _tipsKarier createState() => _tipsKarier();
}

class _tipsKarier extends State<tipsKarier> {
  List<Artikel> news = [];
  String query = '';
  Timer? debouncer;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 100),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final beritas = await BeritaApi.getBooks(query);

    setState(() => this.news = beritas);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        // appBar: AppBar(
        //   title: Text("CaseWorqer"),
        //   centerTitle: true,
        // ),
        body: Column(
          children: <Widget>[
              Container(
                // margin: const EdgeInsets.fromLTRB(16, 0, 5, 0),
                padding: EdgeInsets.only(top: 8.0, left: 5.0),
                child: ElevatedButton(
                child: const Text('Edit Mode'),
                onPressed: () {
                   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FormArtikel()),
                    );
                  }
                ),
              ),
            buildSearch(),
            Expanded(
              child: ListView.builder(
                itemCount: news.length,
                itemBuilder: (context, index) {
                  final berita = news[index];

                 
                  return buildBook(berita);
                },
              ),
            ),
          ],
        ),
      );

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Judul Artikel',
        onChanged: searchBerita,
      );

  Future searchBerita(String query) async => debounce(() async {
        final books = await BeritaApi.getBooks(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.news = books;
        });
      });

  Widget buildBook(Artikel book) => ListTile(
        // leading: Image.network(
        //   book.urlImage,
        //   fit: BoxFit.cover,
        //   width: 50,
        //   height: 50,
        // ),
        title: Text(book.fields["Title"]),
        subtitle: Text(book.fields["Summary"]),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArtikelDetail(berita: book ),
            )
          );
        }
        
      );
}
// tes 123
class SecondRoute extends StatefulWidget {
  SecondRoute({Key? key}) : super(key: key);

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//flutter CRUD 
//flutter CRUD 
class Articles {
  int pk;
  String model;
  Map<String, dynamic> fields={};
//ctrlz sampe ini bossqu okeoke


  Articles({this.pk = 0 ,this.model= "",required this.fields });

  factory Articles.fromJson(Map<String, dynamic> map) {
    return Articles(pk: map['pk'],model: map['model'],fields:map['fields']);
    
  }

  Map<String, dynamic> toJson() {
    return { "pk": pk, "model": model, "fields": fields};
  }

  @override
  String toString() {
    return 'Articles{ pk: $pk, model: $model, fields: $fields}';
  }

}

List<Articles> profileFromJson(String jsonData) {
  final data = json.decode(jsonData);
  return List<Articles>.from(data.map((item) => Articles.fromJson(item)));
}

String profileToJson(Articles data) {
  final jsonData = data.toJson();
  return json.encode(jsonData);
}

class ArticlesService {
  final String baseUrl = "http://caseworqer.herokuapp.com/tipskarier/json/";
  // HttpClient client = HttpClient();

  Future<List<Articles>?> getArticles() async {
    final response = await http.get("http://caseworqer.herokuapp.com/tipskarier/json/");
    if (response.statusCode == 200) {
      return profileFromJson(response.body);
    } else {
      return null;
    }
  }

  Future<bool> createArticles(Articles data) async {
    final response = await http.post(
      "$baseUrl",
      headers: <String, String>{'Content-Type': 'application/json;'},
      body: profileToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateArticles(Articles data) async {
    final response = await http.put(
      "$baseUrl/${data.pk}",
      headers:  <String, String>{'Content-Type': 'application/json;'},
      body: profileToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteArticles(int pk) async {
    final response = await http.delete(
      "$baseUrl/$pk",
      headers:  <String, String>{'Content-Type': 'application/json;'},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}

//form tips karier
final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class FormAddScreen extends StatefulWidget {

  Articles articlese;
  FormAddScreen({required this.articlese});
  // FormAddScreen({
  //   Key? key,
  //   required this.articlese,
  // }) : super(key: key);

  @override
  _FormAddScreenState createState() => _FormAddScreenState();
}

class _FormAddScreenState extends State<FormAddScreen> {
  bool _isLoading = false;
  ArticlesService _apiService = ArticlesService();
  late bool isFieldTitleValid;
  late bool isFieldSummaryValid;
  late bool isFieldCoverValid;
  late bool isFieldHighlightValid;
  late bool isFieldArticleValid;
  TextEditingController _controllerTitle = TextEditingController();
  TextEditingController _controllerSummary = TextEditingController();
  TextEditingController _controllerArticle = TextEditingController();
  TextEditingController _controllerCover = TextEditingController();
  TextEditingController _controllerHighlight = TextEditingController();

  @override
  void initState() {
    isFieldTitleValid = true;
    _controllerTitle.text = widget.articlese.fields["Title"];
    isFieldSummaryValid = true;
    _controllerSummary.text = widget.articlese.fields["Summary"];
    isFieldArticleValid = true;
    _controllerArticle.text = widget.articlese.fields["Article"];
    isFieldCoverValid = true;
    _controllerCover.text = widget.articlese.fields["Cover"];
    isFieldHighlightValid = true;
    _controllerHighlight.text = widget.articlese.fields["Highlight"].toString();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.articlese == null ? "Form Add" : "Change Data",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldTitle(),
                _buildTextFieldSummary(),
                _buildTextFieldArticle(),
                _buildTextFieldCover(),
                _buildTextFieldHighlight(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.articlese == null
                          ? "Submit".toUpperCase()
                          : "Update Data".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {
                      if (isFieldTitleValid == null ||
                          isFieldSummaryValid == null ||
                         isFieldArticleValid == null ||
                          !isFieldTitleValid||
                          !isFieldSummaryValid||
                          !isFieldArticleValid) {
                        _scaffoldState.currentState!.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String title = _controllerTitle.text.toString();
                      String summary = _controllerSummary.text.toString();
                      String article = _controllerArticle.text.toString();
                      String cover = _controllerCover.text.toString();
                      int highlight = int.parse(_controllerHighlight.text.toString());
                      Articles article1 = new Articles(fields: {});
                          //Articles(title: title, summary: summary,article: article, cover: cover,highlight: highlight);
                      article1.fields["Title"] = title;
                      article1.fields["Summary"] = summary;
                      article1.fields["Article"] = article;
                      article1.fields["Cover"] = cover;
                      article1.fields["Highlight"] = highlight;

                      if (widget.articlese == null) {
                        _apiService.createArticles(article1).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState!.context, true);
                          } else {
                            _scaffoldState.currentState!.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      } else {
                        article1.pk = widget.articlese.pk;
                        _apiService.updateArticles(article1).then((isSuccess) {
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState!.context, true);
                          } else {
                            _scaffoldState.currentState!.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldTitle() {
    return TextField(
      controller: _controllerTitle,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Judul Artikel",
        errorText: isFieldTitleValid == null || isFieldTitleValid
            ? null
            : "Judul Artikel is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != isFieldTitleValid) {
          setState(() => isFieldTitleValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldSummary() {
    return TextField(
      controller: _controllerSummary,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Summary",
        errorText: isFieldSummaryValid == null || isFieldSummaryValid
            ? null
            : "Summary is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != isFieldSummaryValid) {
          setState(() => isFieldSummaryValid = isFieldValid);
        }
      },
    );
  }
  Widget _buildTextFieldArticle() {
  return TextField(
    controller: _controllerArticle,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      labelText: "Artikel",
      errorText: isFieldArticleValid == null || isFieldArticleValid
          ? null
          : "Artikel is required",
    ),
    onChanged: (value) {
      bool isFieldValid = value.trim().isNotEmpty;
      if (isFieldValid != isFieldArticleValid) {
        setState(() => isFieldArticleValid = isFieldValid);
      }
    },
  );
}
  Widget _buildTextFieldCover() {
  return TextField(
    controller: _controllerCover,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      labelText: "Cover",
      errorText: isFieldCoverValid == null || isFieldCoverValid
          ? null
          : "Cover is required",
    ),
    onChanged: (value) {
      bool isFieldValid = value.trim().isNotEmpty;
      if (isFieldValid != isFieldCoverValid) {
        setState(() => isFieldCoverValid = isFieldValid);
      }
    },
  );
}

  Widget _buildTextFieldHighlight() {
    return TextField(
      controller: _controllerHighlight,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Highlight",
        errorText: isFieldHighlightValid == null || isFieldHighlightValid
            ? null
            : "Highlight is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != isFieldHighlightValid) {
          setState(() => isFieldHighlightValid = isFieldValid);
        }
      },
    );
  }
}

//page crud
class CRUDScreen extends StatefulWidget {
  @override
  _CRUDScreenState createState() => _CRUDScreenState();
}

class _CRUDScreenState extends State<CRUDScreen> {
  late BuildContext context;
  late ArticlesService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ArticlesService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getArticles(),
        builder: (BuildContext context, AsyncSnapshot<List<Articles>?> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Articles>? article2 = snapshot.data;
            return _buildListView(article2!);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Articles> article3) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Articles article4 = article3[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      article4.fields["Title"],
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(article4.fields["Summary"]),
                    Text(article4.fields["Highlight"].toString()),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: <Widget>[
                    //     FlatButton(
                    //       onPressed: () {
                    //         showDialog(
                    //             context: context,
                    //             builder: (context) {
                    //               return AlertDialog(
                    //                 title: Text("Warning"),
                    //                 content: Text("Are you sure want to delete data profile ${article4.fields["Title"]}?"),
                    //                 actions: <Widget>[
                    //                   FlatButton(
                    //                     child: Text("Yes"),
                    //                     onPressed: () {
                    //                       Navigator.pop(context);
                    //                       apiService.deleteArticles(article4.pk).then((isSuccess) {
                    //                         if (isSuccess) {
                    //                           setState(() {});
                    //                           Scaffold.of(context)
                    //                               .showSnackBar(SnackBar(content: Text("Delete data success")));
                    //                         } else {
                    //                           Scaffold.of(context)
                    //                               .showSnackBar(SnackBar(content: Text("Delete data failed")));
                    //                         }
                    //                       });
                    //                     },
                    //                   ),
                    //                   FlatButton(
                    //                     child: Text("No"),
                    //                     onPressed: () {
                    //                       Navigator.pop(context);
                    //                     },
                    //                   )
                    //                 ],
                    //               );
                    //             });
                    //       },
                    //       child: Text(
                    //         "Delete",
                    //         style: TextStyle(color: Colors.red),
                    //       ),
                    //     ),
                    //     FlatButton(
                    //       onPressed: () async {
                    //         var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    //           return FormAddScreen(articlese: article4);
                    //         }));
                    //         if (result != null) {
                    //           setState(() {});
                    //         }
                    //       },
                    //       child: Text(
                    //         "Edit",
                    //         style: TextStyle(color: Colors.blue),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: article3.length,
      ),
    );
  }
}


// GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

// class App extends StatefulWidget {
//   @override
//   _AppState createState() => _AppState();
// }

// class _AppState extends State<App> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Colors.orange,
//         accentColor: Colors.orangeAccent,
//       ),
//       home: Scaffold(
//         key: scaffoldState,
//         appBar: AppBar(
//           title: Text(
//             "Flutter CRUD API",
//             style: TextStyle(
//               color: Colors.white,
//             ),
//           ),
//           actions: <Widget>[
//             GestureDetector(
//               onTap: () async {
//                 var result = await Navigator.push(
//                   scaffoldState.currentContext,
//                   MaterialPageRoute(builder: (BuildContext context) {
//                     return FormAddScreen(articles: ,);
//                   }),
//                 );
//                 if (result != null) {
//                   setState(() {});
//                 }
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(right: 16.0),
//                 child: Icon(
//                   Icons.add,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         body: CRUDScreen(),
//       ),
//     );
//   }
// }
GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
class FormArtikel extends StatelessWidget {
  const FormArtikel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
            "Flutter CRUD API",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return ArtikelForm();
                  }),
                );
                // if (result != null) {
                //   setState(() {});
                // }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],),
      body: CRUDScreen()
    );
  }
}
class ArtikelForm extends StatefulWidget {
  //int id;

  ArtikelForm();
  @override
  _ArtikelFormState createState() => _ArtikelFormState();
}

// enum jenisKelamin { Pria, Wanita }

class _ArtikelFormState extends State<ArtikelForm> {
  final _formKey = GlobalKey<FormState>();
  // late int articlepk = 3;

  late String title1;
  late int highlight1;
  late String article1;
  late String summary1;

  // String title1;
  //late String cover1;
  // String model = "tipskarier.tipskarier";
  // String jenisKelaminForm;
  // int idLowongan;

  // double nilaiSlider = 1;
  // bool nilaiCheckBox = false;
  // bool nilaiSwitch = true;
  // jenisKelamin _character;
  static const TextStyle judulStyle =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Artikel"),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                const Text("Form Artikel", style: judulStyle),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      // hintText: "contoh: Susilo Bambang",
                      labelText: "Judul Artikel",
                      // icon: Icon(Icons.people),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      print(value);
                      if (value!.isEmpty) {
                        return 'judul tidak boleh kosong';
                      } else {
                        title1 = value;
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: new InputDecoration(
                      labelText: "Highlight Masukkan (0)",
                      //icon: Icon(Icons.calendar_today),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      print(value);
                      if (value!.isEmpty) {
                        return 'Highlight tidak boleh kosong';
                      } else {
                        highlight1 = int.parse(value);
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 2,
                    autofocus: true,
                    decoration: new InputDecoration(
                      labelText: "Ringkasan",
                      // icon: Icon(Icons.school),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      print(value);
                      if (value!.isEmpty) {
                        return 'Ringkasan tidak boleh kosong';
                      } else {
                        summary1 = value;
                      }
                      return null;
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: TextFormField(
                //     decoration: new InputDecoration(
                //       labelText: "Alamat",
                //       icon: Icon(Icons.home),
                //       border: OutlineInputBorder(
                //           borderRadius: new BorderRadius.circular(5.0)),
                //     ),
                //     validator: (value) {
                //       print(value);
                //       if (value!.isEmpty) {
                //         return 'Alamat tidak boleh kosong';
                //       } else {
                //         cover1 = value;
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                
         
               
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    maxLines: 5,
                    autofocus: true,
                    decoration: new InputDecoration(
                      labelText: "Masukkan Artikel",
                      //icon: Icon(Icons.),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      print(value);
                      if (value!.isEmpty) {
                        return 'Artikel tidak boleh kosong';
                      } else {
                        article1 = value;
                      }
                      return null;
                    },
                  ),
                ),
                RaisedButton(
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blue,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      //articlepk = widget.id;
                      print("Tervalidasi");
                      print(title1);
                      print(highlight1);
                      print(summary1);
                      //print(cover1);
                     // print(model);
                      print(article1);
                      //print(articlepk);
                      print("end");

                      // Map<String, dynamic> toJson() => {
                      //       'nama': nama,
                      //       'usia': usia,
                      //       'pendidikan': pendidikan,
                      //       'alamat': alamat,
                      //       'email': email,
                      //       'jenisKelamin': jenisKelaminForm,
                      //       'sertifikatVaksin': sertifikatVaksin,
                      //       'idLowongan': idLowongan
                      //     };
                      print(jsonEncode(<String, dynamic>{
                        'Title': title1,
                        'Summary': summary1,
                        'Article': "<p>$article1</p>",
                        'Cover':null,
                        'Highlight': highlight1,
                      }));
                      final response = await http.post(
                        Uri.parse('http://caseworqer.herokuapp.com/tipskarier/add/'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                        },
                        body: jsonEncode(<String, dynamic>{
                          'Title': title1,
                          'Article': article1,
                          'Cover': null,
                          'Summary': "<p>$summary1</p>",
                          'Highlight': highlight1
                        }),
                         
                      );
                      print(response.statusCode);
                      if (response.statusCode == 201 ||response.statusCode == 200) {
                        // If the server did return a 201 CREATED response,
                        // then parse the JSON.
                        print(response.statusCode);
                        //print(response.body);
                        Navigator.pop(context);
                      } else {
                        // If the server did not return a 201 CREATED response,
                        // then throw an exception.
                        throw Exception('Failed to send data.');
                      }
                    } else {
                      print("tidak tervalidasi");
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

