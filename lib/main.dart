import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'SAU\'s Onbording Demo',
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _sauDotSize = 5.0;
  // The increase in the size of the selected dot
  static const double _sauMaxZoom = 1.8;

  // The distance between the center of each dot
  static const double _sauDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_sauMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _sauDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _sauDotSize * zoom,
            height: _sauDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final _controller = new PageController();

  static const _sauDuration = const Duration(milliseconds: 300);

  static const _sauCurve = Curves.ease;

  final List<Widget> _pages = <Widget>[
    new Column(
      children: <Widget>[
        Icon(
          Icons.tag_faces,
          size: 240,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: <Widget>[
              Text(
                "Welcome to Tontrends",
                style: TextStyle(fontSize: 30, color: Colors.black26),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Get trending with Tontrends",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.black54),
              )
            ],
          ),
        ),
      ],
    ),
    new Column(
      children: <Widget>[
        Icon(
          Icons.trending_up,
          size: 240,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: <Widget>[
              Text(
                "Trending",
                style: TextStyle(fontSize: 30, color: Colors.black26),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Topics the gist never stops...",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ],
    ),
    new Column(
      children: <Widget>[
        Icon(
          Icons.new_releases,
          size: 240,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: <Widget>[
              Text(
                "News",
                style: TextStyle(fontSize: 30, color: Colors.black26),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Stay informed with the latest news popping in",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ],
    ),
    new Column(
      children: <Widget>[
        Icon(
          Icons.people_outline,
          size: 240,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: <Widget>[
              Text(
                "Get Social",
                style: TextStyle(fontSize: 30, color: Colors.black26),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Share your favorites threads via your social media accounts",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ],
    ),
    new Column(
      children: <Widget>[
        Icon(
          Icons.content_copy,
          size: 240,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: <Widget>[
              Text(
                "Forum",
                style: TextStyle(fontSize: 30, color: Colors.black26),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Engage and keep the conversation going  ",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black54,
                ),
              )
            ],
          ),
        ),
      ],
    ),
  ];

  //boolean value to determine whether toshow or hide button. `true` by default
  bool nextBtnEnabled = true;
  bool skipBtnEnabled = true;
  bool prevBtnEnabled = false;
  bool doneBtnEnabled = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SafeArea(
        child: new Stack(
          children: <Widget>[
            new Center(
              child: new PageView.builder(
                physics: new AlwaysScrollableScrollPhysics(),
                controller: _controller,
                itemCount: _pages.length,
                itemBuilder: (BuildContext context, int index) {
                  return _pages[index % _pages.length];
                },
              ),
            ),
            //Skip Button
            Positioned(
              top: 0.0,
              right: 0.0,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  skipBtnEnabled
                      ? FlatButton(
                          splashColor: Colors.transparent,
                          colorBrightness: Brightness.light,
                          highlightColor: Colors.transparent,
                          child: Text("Skip"),
                          onPressed: () {
                            _controller.jumpToPage(4);
                            setState(() => nextBtnEnabled = false);
                            setState(() => doneBtnEnabled = true);
                          },
                        )
                      : SizedBox()
                ],
              ),
            ),
            //Prev Button
            Positioned(
                //Prev Button Position
                bottom: 5.0,
                left: 0.0,
                child: prevBtnEnabled
                    ? FlatButton(
                        splashColor: Colors.transparent,
                        colorBrightness: Brightness.light,
                        highlightColor: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_left),
                            Text("Prev")
                          ],
                        ),
                        onPressed: () {
                          _controller.previousPage(
                              duration: _sauDuration, curve: _sauCurve);
                          setState(() => skipBtnEnabled = true);
                          setState(() => nextBtnEnabled = true);
                          setState(() => doneBtnEnabled = false);
                        },
                      )
                    : SizedBox()),
            //Indicator
            Positioned(
              //Indicator Position
              bottom: 25.0,
              left: 0.0,
              right: 0.0,
              child: DotsIndicator(
                color: Colors.black45,
                controller: _controller,
                itemCount: _pages.length,
                onPageSelected: (int page) {
                  _controller.animateToPage(
                    page,
                    duration: _sauDuration,
                    curve: _sauCurve,
                  );
                },
              ),
            ),
            //Next Button
            Positioned(
                //Next Button Position
                bottom: 5.0,
                right: 0.0,
                child: nextBtnEnabled
                    ? FlatButton(
                        splashColor: Colors.transparent,
                        colorBrightness: Brightness.light,
                        highlightColor: Colors.transparent,
                        child: Row(
                          children: <Widget>[
                            Text("Next"),
                            Icon(Icons.arrow_right)
                          ],
                        ),
                        onPressed: () {
                          _controller.nextPage(
                              duration: _sauDuration, curve: _sauCurve);
                          setState(() => prevBtnEnabled = true);
                          setState(() => skipBtnEnabled = false);
                          if (_pages.length != 3) {
                            setState(() => doneBtnEnabled = false);
                          } else {
                            setState(() => doneBtnEnabled = true);
                          }
                        },
                      )
                    : SizedBox()),
            //Done Button
            Positioned(
                //Next Button Position
                bottom: 5.0,
                right: 0.0,
                child: doneBtnEnabled
                    ? FlatButton(
                        splashColor: Colors.transparent,
                        colorBrightness: Brightness.light,
                        highlightColor: Colors.transparent,
                        child: Text("Done"),
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                      )
                    : SizedBox()),
          ],
        ),
      ),
    );
  }
}
