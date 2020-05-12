import 'package:bipolar_unsplash/components/appBar.dart';
import 'package:flutter/material.dart';

import 'components/homePage.dart';

void main() => runApp(BipolarUnsplash());

class BipolarUnsplash extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Color(242424),
          body: TabBarView(
            children: <Widget>[Home("cats"), Home("nature")],
          ),
          appBar: genAppBar(),
        ),
      ),
    );
  }
}

