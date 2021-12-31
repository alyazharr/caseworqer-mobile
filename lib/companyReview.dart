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
  String query = '';
  Timer? debouncer;

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
    final jobs = await searchJob.getJobs(query);

    setState(() => this._job = jobs);
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: 'Cari pekerjaan',
        onChanged: searchBerita,
      );

  Future searchBerita(String query) async => debounce(() async {
        final books = await searchJob.getJobs(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this._job = books;
        });
      });

  Future<List<Jobs>> fetchNotes() async {
    var url = 'https://caseworqer.herokuapp.com/company_review/json-joblist';
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
    var url = 'https://caseworqer.herokuapp.com/company_review/json-jobrate';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Color(0xFFDA5144),
        title: Text('COMPANY REVIEW',
            style: TextStyle(fontFamily: 'Sansita One')),
        centerTitle: true,
      ),
        body: 
        Column(
          children: <Widget>[
            buildSearch(),
            Expanded(
        child: ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          child: Padding(
            padding: EdgeInsets.only(
                top: 32.0, bottom: 32.0, left: 16.0, right: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
                  Row(children: <Widget>[
                    Padding(padding:EdgeInsets.only(bottom:5.0, right:5.0), child:
                      Image(
                        image: AssetImage(
                            'assets/images/Png-Item-1780031.png'),
                        width: 35,
                        height: 35,
                      ),
                    ),        
                Text(
                  _job[index].fields["jobs"],
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(205,73,57,50)
                  ),
                ),
                ]),
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
                  builder: (context) => ReviewPost(_job[index].pk)),
            );
          },
        );
      },
      itemCount: _job.length,
    )
            )
  ]
)
    );

    
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
  int index = 0;

  ReviewPost(this.id);
  @override
  _ReviewPostState createState() {
      print(id);
    return _ReviewPostState(id);
  }
}

class _ReviewPostState extends State<ReviewPost>  {
  int index_job=0;

  _ReviewPostState(this.index_job);

  List<Jobs> _job = <Jobs>[];

  Future<List<Jobs>> fetchNotes() async {
    var url = 'https://caseworqer.herokuapp.com/company_review/json-joblist';
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
    var url = 'https://caseworqer.herokuapp.com/company_review/json-jobrate';
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
    // double valueRate;

    // for (int i=0; i < _review.length; i++) {
    //   valueRate =  _review[i].fields['value'];
    //   valueRate = (valueRate + valueRate)/i;
    // }
    super.initState();
  }

  @override
  
  Widget build(BuildContext context) {
    String namaJob = "";
    String namaComp = "";
    String desc = "";
    
    // for (int j=0; j < _job.length; j++) {
    //   if (_job[index_job-1].pk  == _review[j].fields['pekerjaan']) {
    //   namaJob= _job[j].fields['jobs'];
    //   namaComp = _job[j].fields['company'];
    //   desc = _job[j].fields['description'];
    //   print(_job.length);
    //   print(index_job-1);
    //   print(j);
    //   print(_job[index_job-1].pk);
    //   print(_review[j].fields['pekerjaan']);
    //   }
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Color(0xFFDA5144),
        title: Text('COMPANY REVIEW',
            style: TextStyle(fontFamily: 'Sansita One')),
        centerTitle: true,
      ),
    body:   
    Container (child: 
      ListView.builder(
        reverse: false,
        itemCount: _review.length,
        itemBuilder: (context, index) {
          if (_job[index_job-1].pk  == _review[index].fields['pekerjaan']) {
          return ListBody(children: <Widget>[
            Card(
              child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
              Row(
                children: <Widget>[
                  Column(children: <Widget>[
                    Image(
                      image: AssetImage(
                          'assets/images/avatar7.png'),
                      width: 35,
                      height: 35,
                    ),
                  ]),
                  Text('    '),
                  Flexible( 
                    child: Text(
                _review[index].fields["penulis"].join(),
                style: TextStyle(
                fontSize: 15,
                color: Color.fromRGBO(0, 0, 0, 50),
                fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Column(children: [
            Row(
                children: <Widget>[
                  RatingBarIndicator (
                  rating: _review[index].fields["value"].toDouble(),
                    itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: Colors.amber,
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                ),
            ],
          ),
          ]),
          const SizedBox(height: 5),
          Text(
            _review[index].fields["description"],
              style: TextStyle(
                fontSize: 15,
                color:Color.fromRGBO(0, 0, 0, 50),
              ),
            ),
                  ],
                ),
              ),
          )]);
          } else {
            return const SizedBox(height: 0);
          }
        }),
    ),
    floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color.fromRGBO(218,81,68,50),
        foregroundColor: Color(0xFFFFFFFF),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return addReviewForm(id_review: _job[index_job-1].pk, index: index_job);
          }));
        },
      ),
    );
  } 
}

class addReviewForm extends StatefulWidget {
  final int id_review;
  final int index;
  addReviewForm({Key? key, required this.id_review, required this.index})
       : super(key: key);

  @override
  _addReviewFormState createState() {
    print(id_review);
  return _addReviewFormState();
  } 
}

// class Comment extends StatefulWidget {
//   final int pk;
//   final int index;
//   const Comment({Key? key, required this.pk, required this.index})
//       : super(key: key);

//   @override
//   _CommentState createState() => _CommentState();
// }

class _addReviewFormState extends State<addReviewForm> {
  TextEditingController message_controller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int _ratings= 0;
  
  late String username;
  String? desc;
  late int id_job;
  double? valueRate;
  var now = DateTime.now();

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
    body: Form(
      key: _formKey,
      child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
      children: [
        const Text("Give your feedback..", style: 
        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Padding(padding: const EdgeInsets.all(8.0),
          child: Rating((rating) {
                setState(() {
                  _ratings = rating;
                  print(_ratings);
                });
              }, 5),  
        ),
        Padding (
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                    controller: message_controller,
                    decoration: new InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(vertical: 40.0),
                      hintText: "   Give your feedback...",
                      filled: true,
                      labelText: "  Desc",
                      icon: Icon(Icons.sticky_note_2_outlined),
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0)),
                    ),
                    validator: (value) {
                      print(value);
                      if (value==null || value.isEmpty) {
                        return 'Give your feedback...';
                      } else {
                        desc = value;
                      }
                      return null;
                    },
                    maxLines: 5,
                  ),
                ),
                Row (mainAxisAlignment: MainAxisAlignment.end, 
                children: <Widget>[
                  Container(
                  width: 127,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () async {
                    id_job = widget.id_review;
                    print(id_job);
                      final response = await http.post(
                        Uri.parse(
                          'https://caseworqer.herokuapp.com/company_review/postMethod/' + id_job.toString()));
                      print(response.statusCode);
                    if (_formKey.currentState!.validate()) {
                      id_job = widget.id_review;
                      final response = await http.post(
                        Uri.parse(
                          'https://caseworqer.herokuapp.com/company_review/postMethod/' + id_job.toString()),
                      headers: <String, String>{
                            'Content-Type':
                                'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, dynamic>{
                          'pekerjaan': id_job,
                          'penulis':['D01'],
                          'value':_ratings,
                          'description': desc,
                          'postTime':
                              '${now.year}-${now.month}-${now.day}T${now.hour}:${now.minute}:${now.second}.${now.millisecondsSinceEpoch}Z',
                        }),
                      );
                  if (response.statusCode == 201 ||
                      response.statusCode == 200 || response.statusCode == 500) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Thank You!')),
                    );
                  } else {
                    throw Exception('Failed to create feedback.');
                      }
                    }
                    },
                    color: Color(0xFF34ae57),
                      child: Text('POST',
                          style: TextStyle(color: Colors.white))),
                  ),
              Text('  '),
              Container(width: 75, height: 40, child: CancelButton()),
              Text('  '),
              ],
            ),
            ],
          ),
        ),
      ),
    ),
    );
  }

}

/// A widget to display rating as assigned using [rating] property.
///
/// This is a read only version of [Rating].
///
/// Use [Rating], if interactive version is required.
/// i.e. if user input is required.
class RatingBarIndicator extends StatefulWidget {
  RatingBarIndicator({
    required this.itemBuilder,
    this.textDirection,
    this.unratedColor,
    this.direction = Axis.horizontal,
    this.itemCount = 5,
    this.itemPadding = EdgeInsets.zero,
    this.itemSize = 40.0,
    this.physics = const NeverScrollableScrollPhysics(),
    this.rating = 0.0,
  });

  /// {@macro flutterRatingBar.itemBuilder}
  final IndexedWidgetBuilder itemBuilder;

  /// {@macro flutterRatingBar.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutterRatingBar.unratedColor}
  final Color? unratedColor;

  /// {@macro flutterRatingBar.direction}
  final Axis direction;

  /// {@macro flutterRatingBar.itemCount}
  final int itemCount;

  /// {@macro flutterRatingBar.itemPadding}
  final EdgeInsets itemPadding;

  /// {@macro flutterRatingBar.itemSize}
  final double itemSize;

  /// Controls the scrolling behaviour of rating bar.
  ///
  /// Default is [NeverScrollableScrollPhysics].
  final ScrollPhysics physics;

  /// Defines the rating value for indicator.
  ///
  /// Default is 0.0
  final double rating;

  @override
  _RatingBarIndicatorState createState() => _RatingBarIndicatorState();
}

class _RatingBarIndicatorState extends State<RatingBarIndicator> {
  double _ratingFraction = 0.0;
  int _ratingNumber = 0;
  bool _isRTL = false;

  @override
  void initState() {
    super.initState();
    _ratingNumber = widget.rating.truncate() + 1;
    _ratingFraction = widget.rating - _ratingNumber + 1;
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = widget.textDirection ?? Directionality.of(context);
    _isRTL = textDirection == TextDirection.rtl;
    _ratingNumber = widget.rating.truncate() + 1;
    _ratingFraction = widget.rating - _ratingNumber + 1;
    return SingleChildScrollView(
      scrollDirection: widget.direction,
      physics: widget.physics,
      child: widget.direction == Axis.horizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: textDirection,
              children: _children,
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              textDirection: textDirection,
              children: _children,
            ),
    );
  }

  List<Widget> get _children {
    return List.generate(
      widget.itemCount,
      (index) {
        if (widget.textDirection != null) {
          if (widget.textDirection == TextDirection.rtl &&
              Directionality.of(context) != TextDirection.rtl) {
            return Transform(
              transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
              alignment: Alignment.center,
              transformHitTests: false,
              child: _buildItems(index),
            );
          }
        }
        return _buildItems(index);
      },
    );
  }

  Widget _buildItems(int index) {
    return Padding(
      padding: widget.itemPadding,
      child: SizedBox(
        width: widget.itemSize,
        height: widget.itemSize,
        child: Stack(
          fit: StackFit.expand,
          children: [
            FittedBox(
              fit: BoxFit.contain,
              child: index + 1 < _ratingNumber
                  ? widget.itemBuilder(context, index)
                  : ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        widget.unratedColor ?? Theme.of(context).disabledColor,
                        BlendMode.srcIn,
                      ),
                      child: widget.itemBuilder(context, index),
                    ),
            ),
            if (index + 1 == _ratingNumber)
              if (_isRTL)
                FittedBox(
                  fit: BoxFit.contain,
                  child: ClipRect(
                    clipper: _IndicatorClipper(
                      ratingFraction: _ratingFraction,
                      rtlMode: _isRTL,
                    ),
                    child: widget.itemBuilder(context, index),
                  ),
                )
              else
                FittedBox(
                  fit: BoxFit.contain,
                  child: ClipRect(
                    clipper: _IndicatorClipper(
                      ratingFraction: _ratingFraction,
                    ),
                    child: widget.itemBuilder(context, index),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

class _IndicatorClipper extends CustomClipper<Rect> {
  _IndicatorClipper({
    required this.ratingFraction,
    this.rtlMode = false,
  });

  final double ratingFraction;
  final bool rtlMode;

  @override
  Rect getClip(Size size) {
    return rtlMode
        ? Rect.fromLTRB(
            size.width - size.width * ratingFraction,
            0.0,
            size.width,
            size.height,
          )
        : Rect.fromLTRB(
            0.0,
            0.0,
            size.width * ratingFraction,
            size.height,
          );
  }

  @override
  bool shouldReclip(_IndicatorClipper oldClipper) {
    return ratingFraction != oldClipper.ratingFraction ||
        rtlMode != oldClipper.rtlMode;
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
                color: Color.fromRGBO(248, 249, 250, 50), fontSize: 15, fontFamily: "Sansita One")),
      ),
    );
  }
}

// Search Bar Widget
class searchJob {
  static Future<List<Jobs>> getJobs(String query) async {
    final url = Uri.parse('https://caseworqer.herokuapp.com/company_review/json-joblist');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List jobs = json.decode(response.body);

      return jobs.map((json) => Jobs.fromJson(json)).where((_job) {
        final titleLower = _job.fields["jobs"].toLowerCase();
        final summaryLower = _job.fields["company"].toLowerCase();
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

class Rating extends StatefulWidget {
  final int maximumRating;
  final Function(int) onRatingSelected;

  Rating(this.onRatingSelected, [this.maximumRating = 5]);

  @override
  _Rating createState() => _Rating();
}

class _Rating extends State<Rating> {
  int _currentRating = 0;

  Widget _buildRatingStar(int index) {
    if (index < _currentRating) {
      return Icon(Icons.star, color: Colors.orange, size: 50,);
    } else {
      return Icon(Icons.star_border_outlined, size: 50,);
    }
  }

  Widget _buildBody() {
    final stars = List<Widget>.generate(this.widget.maximumRating, (index) {
      return GestureDetector(
        child: _buildRatingStar(index),
        onTap: () {
          setState(() {
            _currentRating = index + 1;
          });

          this.widget.onRatingSelected(_currentRating);
        },
      );
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: stars,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}


