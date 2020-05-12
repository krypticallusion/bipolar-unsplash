import 'package:bipolar_unsplash/api/models.dart';
import 'package:bipolar_unsplash/api/unsplash.dart';
import 'package:bipolar_unsplash/streams/streams.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class Home extends StatefulWidget {
  final String query;

  Home(this.query);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading;
  int initialPage = 0;
  Unsplash unsplash = Unsplash.fromJson({"results": []});

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchPhotos();
  }

  fetchPhotos() {
    initialPage += 1;
    getPhotos(query: widget.query, page: initialPage).then((value) {
      setState(() {
        unsplash.results.addAll(value.results);
        isLoading = false;
        lazyLoader.changeLoadStatus(false);
      });
    });
  }

  Widget imageGrid() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: unsplash.results.length,
      itemBuilder: (BuildContext context, int index) {
        //Loading new images 3 blocks high than bottom should be fine...
        if ((index == unsplash.results.length - 7) && !isLoading) {
          lazyLoader.changeLoadStatus(true);
          fetchPhotos();
        }

        return Card(
          elevation: 0,
          color: Colors.transparent,
          child: FadeInImage(
            placeholder: Image.memory(kTransparentImage).image,
            image: CachedNetworkImageProvider(
                unsplash.results[index].urls["regular"]),
            fadeInDuration: Duration(milliseconds: 200),
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      children: <Widget>[
        Expanded(child: imageGrid()),
        //show only when loading and not on initial page
        lazyLoaderWidget(),
      ],
    );
  }
}



lazyLoaderWidget() {
  return StreamBuilder(
    stream: lazyLoader.stream,
    initialData: false,
    builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      if (snapshot.data) {
        return Container(
          margin: EdgeInsets.all(20),
          height: 40,
          width: 40,
          child: CircularProgressIndicator(),
        );
      } else {
        return Container();
      }
    },
  );
}
