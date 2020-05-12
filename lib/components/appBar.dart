import 'package:flutter/material.dart';

AppBar genAppBar() {
  return AppBar(
    title: Text("UNSPLASH"),
    elevation: 0,
    backgroundColor: Colors.transparent,
    bottom: TabBar(tabs: <Tab>[
      Tab(
        text: "Cats",
      ),
      Tab(
        text: "Nature",
      )
    ]),
  );
}