import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:math' as math;
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
  List<Jobs> _job = <Jobs>[];
  List<Review> _review = <Review>[];

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
            return addReviewForm(_review[index_job].pekerjaan);
          }));
        },
      ),
    );
  } 
}

class addReviewForm extends StatefulWidget {
  int id_review;

  addReviewForm(this.id_review);
  @override
  _addReviewFormState createState() => _addReviewFormState();
}

class _addReviewFormState extends State<addReviewForm> {
  TextEditingController message_controller = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          child: RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (valueRate) {
                print(valueRate);
            },
          ),
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
                      final response = await http.post(
                        Uri.parse(
                          'https://caseworqer.herokuapp.com/company_review/job/' + id_job.toString()));
                      print(response.statusCode);
                    if (_formKey.currentState!.validate()) {
                      id_job = widget.id_review;
                      final response = await http.post(
                        Uri.parse(
                          'https://caseworqer.herokuapp.com/company_review/job/' + id_job.toString()),
                      headers: <String, String>{
                            'Content-Type':
                                'application/json; charset=UTF-8',
                      },
                      body: jsonEncode(<String, dynamic>{
                          "model": "company_review.perusahaankomen",
                            "fields": {
                          'pekerjaan': id_job,
                          'penulis':['penulis'],
                          'value':valueRate,
                          'desc': desc,
                          'postTime':
                              '${now.year}-${now.month}-${now.day}T${now.hour}:${now.minute}:${now.second}.${now.millisecondsSinceEpoch}Z',
                          }
                        }),
                      );
                  if (response.statusCode == 201 ||
                      response.statusCode == 200) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Give Your Feedback')),
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
/// This is a read only version of [RatingBar].
///
/// Use [RatingBar], if interactive version is required.
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

/// Defines widgets which are to used as rating bar items.
class RatingWidget {
  RatingWidget({
    required this.full,
    required this.half,
    required this.empty,
  });

  /// Defines widget to be used as rating bar item when the item is completely rated.
  final Widget full;

  /// Defines widget to be used as rating bar item when only the half portion of item is rated.
  final Widget half;

  /// Defines widget to be used as rating bar item when the item is unrated.
  final Widget empty;
}

/// A widget to receive rating input from users.
///
/// [RatingBar] can also be used to display rating
///
/// Prefer using [RatingBarIndicator] instead, if read only version is required.
/// As RatingBarIndicator supports any fractional rating value.
class RatingBar extends StatefulWidget {
  /// Creates [RatingBar] using the [ratingWidget].
  const RatingBar({
    /// Customizes the Rating Bar item with [RatingWidget].
    required RatingWidget ratingWidget,
    required this.onRatingUpdate,
    this.glowColor,
    this.maxRating,
    this.textDirection,
    this.unratedColor,
    this.allowHalfRating = false,
    this.direction = Axis.horizontal,
    this.glow = true,
    this.glowRadius = 2,
    this.ignoreGestures = false,
    this.initialRating = 0.0,
    this.itemCount = 5,
    this.itemPadding = EdgeInsets.zero,
    this.itemSize = 40.0,
    this.minRating = 0,
    this.tapOnlyMode = false,
    this.updateOnDrag = false,
    this.wrapAlignment = WrapAlignment.start,
  })  : _itemBuilder = null,
        _ratingWidget = ratingWidget;

  /// Creates [RatingBar] using the [itemBuilder].
  const RatingBar.builder({
    /// {@template flutterRatingBar.itemBuilder}
    /// Widget for each rating bar item.
    /// {@endtemplate}
    required IndexedWidgetBuilder itemBuilder,
    required this.onRatingUpdate,
    this.glowColor,
    this.maxRating,
    this.textDirection,
    this.unratedColor,
    this.allowHalfRating = false,
    this.direction = Axis.horizontal,
    this.glow = true,
    this.glowRadius = 2,
    this.ignoreGestures = false,
    this.initialRating = 0.0,
    this.itemCount = 5,
    this.itemPadding = EdgeInsets.zero,
    this.itemSize = 40.0,
    this.minRating = 0,
    this.tapOnlyMode = false,
    this.updateOnDrag = false,
    this.wrapAlignment = WrapAlignment.start,
  })  : _itemBuilder = itemBuilder,
        _ratingWidget = null;

  /// Return current rating whenever rating is updated.
  ///
  /// [updateOnDrag] can be used to change the behaviour how the callback reports the update.
  final ValueChanged<double> onRatingUpdate;

  /// Defines color for glow.
  ///
  /// Default is [ThemeData.accentColor].
  final Color? glowColor;

  /// Sets maximum rating
  ///
  /// Default is [itemCount].
  final double? maxRating;

  /// {@template flutterRatingBar.textDirection}
  /// The text flows from right to left if [textDirection] = TextDirection.rtl
  /// {@endtemplate}
  final TextDirection? textDirection;

  /// {@template flutterRatingBar.unratedColor}
  /// Defines color for the unrated portion.
  ///
  /// Default is [ThemeData.disabledColor].
  /// {@endtemplate}
  final Color? unratedColor;

  /// Default [allowHalfRating] = false. Setting true enables half rating support.
  final bool allowHalfRating;

  /// {@template flutterRatingBar.direction}
  /// Direction of rating bar.
  ///
  /// Default = Axis.horizontal
  /// {@endtemplate}
  final Axis direction;

  /// if set to true, Rating Bar item will glow when being touched.
  ///
  /// Default is true.
  final bool glow;

  /// Defines the radius of glow.
  ///
  /// Default is 2.
  final double glowRadius;

  /// if set to true, will disable any gestures over the rating bar.
  ///
  /// Default is false.
  final bool ignoreGestures;

  /// Defines the initial rating to be set to the rating bar.
  final double initialRating;

  /// {@template flutterRatingBar.itemCount}
  /// Defines total number of rating bar items.
  ///
  /// Default is 5.
  /// {@endtemplate}
  final int itemCount;

  /// {@template flutterRatingBar.itemPadding}
  /// The amount of space by which to inset each rating item.
  /// {@endtemplate}
  final EdgeInsetsGeometry itemPadding;

  /// {@template flutterRatingBar.itemSize}
  /// Defines width and height of each rating item in the bar.
  ///
  /// Default is 40.0
  /// {@endtemplate}
  final double itemSize;

  /// Sets minimum rating
  ///
  /// Default is 0.
  final double minRating;

  /// if set to true will disable drag to rate feature. Note: Enabling this mode will disable half rating capability.
  ///
  /// Default is false.
  final bool tapOnlyMode;

  /// Defines whether or not the `onRatingUpdate` updates while dragging.
  ///
  /// Default is false.
  final bool updateOnDrag;

  /// How the item within the [RatingBar] should be placed in the main axis.
  ///
  /// For example, if [wrapAlignment] is [WrapAlignment.center], the item in
  /// the RatingBar are grouped together in the center of their run in the main axis.
  ///
  /// Defaults to [WrapAlignment.start].
  final WrapAlignment wrapAlignment;

  final IndexedWidgetBuilder? _itemBuilder;
  final RatingWidget? _ratingWidget;

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double _rating = 0.0;
  bool _isRTL = false;
  double iconRating = 0.0;

  late double _minRating, _maxRating;
  late final ValueNotifier<bool> _glow;

  @override
  void initState() {
    super.initState();
    _glow = ValueNotifier(false);
    _minRating = widget.minRating;
    _maxRating = widget.maxRating ?? widget.itemCount.toDouble();
    _rating = widget.initialRating;
  }

  @override
  void didUpdateWidget(RatingBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRating != widget.initialRating) {
      _rating = widget.initialRating;
    }
    _minRating = widget.minRating;
    _maxRating = widget.maxRating ?? widget.itemCount.toDouble();
  }

  @override
  void dispose() {
    _glow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = widget.textDirection ?? Directionality.of(context);
    _isRTL = textDirection == TextDirection.rtl;
    iconRating = 0.0;

    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.start,
        textDirection: textDirection,
        direction: widget.direction,
        children: List.generate(
          widget.itemCount,
          (index) => _buildRating(context, index),
        ),
      ),
    );
  }

  Widget _buildRating(BuildContext context, int index) {
    final ratingWidget = widget._ratingWidget;
    final item = widget._itemBuilder?.call(context, index);
    final ratingOffset = widget.allowHalfRating ? 0.5 : 1.0;

    Widget _ratingWidget;

    if (index >= _rating) {
      _ratingWidget = _NoRatingWidget(
        size: widget.itemSize,
        child: ratingWidget?.empty ?? item!,
        enableMask: ratingWidget == null,
        unratedColor: widget.unratedColor ?? Theme.of(context).disabledColor,
      );
    } else if (index >= _rating - ratingOffset && widget.allowHalfRating) {
      if (ratingWidget?.half == null) {
        _ratingWidget = _HalfRatingWidget(
          size: widget.itemSize,
          child: item!,
          enableMask: ratingWidget == null,
          rtlMode: _isRTL,
          unratedColor: widget.unratedColor ?? Theme.of(context).disabledColor,
        );
      } else {
        _ratingWidget = SizedBox(
          width: widget.itemSize,
          height: widget.itemSize,
          child: FittedBox(
            fit: BoxFit.contain,
            child: _isRTL
                ? Transform(
                    transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                    alignment: Alignment.center,
                    transformHitTests: false,
                    child: ratingWidget!.half,
                  )
                : ratingWidget!.half,
          ),
        );
      }
      iconRating += 0.5;
    } else {
      _ratingWidget = SizedBox(
        width: widget.itemSize,
        height: widget.itemSize,
        child: FittedBox(
          fit: BoxFit.contain,
          child: ratingWidget?.full ?? item,
        ),
      );
      iconRating += 1.0;
    }

    return IgnorePointer(
      ignoring: widget.ignoreGestures,
      child: GestureDetector(
        onTapDown: (details) {
          double value;
          if (index == 0 && (_rating == 1 || _rating == 0.5)) {
            value = 0;
          } else {
            final tappedPosition = details.localPosition.dx;
            final tappedOnFirstHalf = tappedPosition <= widget.itemSize / 2;
            value = index +
                (tappedOnFirstHalf && widget.allowHalfRating ? 0.5 : 1.0);
          }

          value = math.max(value, widget.minRating);
          widget.onRatingUpdate(value);
          _rating = value;
          setState(() {});
        },
        onHorizontalDragStart: _isHorizontal ? _onDragStart : null,
        onHorizontalDragEnd: _isHorizontal ? _onDragEnd : null,
        onHorizontalDragUpdate: _isHorizontal ? _onDragUpdate : null,
        onVerticalDragStart: _isHorizontal ? null : _onDragStart,
        onVerticalDragEnd: _isHorizontal ? null : _onDragEnd,
        onVerticalDragUpdate: _isHorizontal ? null : _onDragUpdate,
        child: Padding(
          padding: widget.itemPadding,
          child: ValueListenableBuilder<bool>(
            valueListenable: _glow,
            builder: (context, glow, child) {
              if (glow && widget.glow) {
                final glowColor =
                    widget.glowColor ?? Theme.of(context).accentColor;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withAlpha(30),
                        blurRadius: 10,
                        spreadRadius: widget.glowRadius,
                      ),
                      BoxShadow(
                        color: glowColor.withAlpha(20),
                        blurRadius: 10,
                        spreadRadius: widget.glowRadius,
                      ),
                    ],
                  ),
                  child: child,
                );
              }
              return child!;
            },
            child: _ratingWidget,
          ),
        ),
      ),
    );
  }

  bool get _isHorizontal => widget.direction == Axis.horizontal;

  void _onDragUpdate(DragUpdateDetails dragDetails) {
    if (!widget.tapOnlyMode) {
      final box = context.findRenderObject() as RenderBox?;
      if (box == null) return;

      final _pos = box.globalToLocal(dragDetails.globalPosition);
      double i;
      if (widget.direction == Axis.horizontal) {
        i = _pos.dx / (widget.itemSize + widget.itemPadding.horizontal);
      } else {
        i = _pos.dy / (widget.itemSize + widget.itemPadding.vertical);
      }
      var currentRating = widget.allowHalfRating ? i : i.round().toDouble();
      if (currentRating > widget.itemCount) {
        currentRating = widget.itemCount.toDouble();
      }
      if (currentRating < 0) {
        currentRating = 0.0;
      }
      if (_isRTL && widget.direction == Axis.horizontal) {
        currentRating = widget.itemCount - currentRating;
      }

      _rating = currentRating.clamp(_minRating, _maxRating);
      if (widget.updateOnDrag) widget.onRatingUpdate(iconRating);
      setState(() {});
    }
  }

  void _onDragStart(DragStartDetails details) {
    _glow.value = true;
  }

  void _onDragEnd(DragEndDetails details) {
    _glow.value = false;
    widget.onRatingUpdate(iconRating);
    iconRating = 0.0;
  }
}

class _HalfRatingWidget extends StatelessWidget {
  _HalfRatingWidget({
    required this.size,
    required this.child,
    required this.enableMask,
    required this.rtlMode,
    required this.unratedColor,
  });

  final Widget child;
  final double size;
  final bool enableMask;
  final bool rtlMode;
  final Color unratedColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: enableMask
          ? Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: _NoRatingWidget(
                    child: child,
                    size: size,
                    unratedColor: unratedColor,
                    enableMask: enableMask,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: ClipRect(
                    clipper: _HalfClipper(
                      rtlMode: rtlMode,
                    ),
                    child: child,
                  ),
                ),
              ],
            )
          : FittedBox(
              child: child,
              fit: BoxFit.contain,
            ),
    );
  }
}

class _HalfClipper extends CustomClipper<Rect> {
  _HalfClipper({required this.rtlMode});

  final bool rtlMode;

  @override
  Rect getClip(Size size) => rtlMode
      ? Rect.fromLTRB(
          size.width / 2,
          0.0,
          size.width,
          size.height,
        )
      : Rect.fromLTRB(
          0.0,
          0.0,
          size.width / 2,
          size.height,
        );

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

class _NoRatingWidget extends StatelessWidget {
  _NoRatingWidget({
    required this.size,
    required this.child,
    required this.enableMask,
    required this.unratedColor,
  });

  final double size;
  final Widget child;
  final bool enableMask;
  final Color unratedColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child: enableMask
            ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                  unratedColor,
                  BlendMode.srcIn,
                ),
                child: child,
              )
            : child,
      ),
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
                color: Color.fromRGBO(248, 249, 250, 50), fontSize: 15, fontFamily: "Sansita One")),
      ),
    );
  }
}

// Search Bar Widget
class searchJob {
  static Future<List<Jobs>> getJobs(String query) async {
    final url = Uri.parse('http://caseworqer.herokuapp.com/company_review/json-joblist');
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


