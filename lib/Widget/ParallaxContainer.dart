import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";

class ParallaxContainer extends StatefulWidget {

  final String imageUrl;
  final double height;
  final ScrollController controller;

  ParallaxContainer({Key key, this.imageUrl, this.height=200, this.controller,}) : super(key: key);

  @override
  ParallaxContainerState createState() => ParallaxContainerState();
}

class ParallaxContainerState extends State<ParallaxContainer>{

  double slide=0;
  final ScrollController scroll = ScrollController();

  void initState(){
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => scroll.jumpTo((widget.height-widget.controller.position.pixels)/4));

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        controller: scroll,
        child: CachedNetworkImage(
            imageUrl: widget.imageUrl,
            imageBuilder: (context, imageProvider) => Container(
              height: widget.height/4*5,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Center(child: Icon(Icons.error, color: Colors.red)),
        ),
      ),
    );
  }

}