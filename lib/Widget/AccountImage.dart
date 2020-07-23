import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hey_flutter/UtilityClass/UtilityTools.dart';

import 'Theme.dart';

class AccountImage extends StatelessWidget{
  final String photo;
  final int format;
  final Color borderColor;
  final double borderWidth;

  const AccountImage({Key key, this.photo, this.format=500, this.borderColor=Colors.white, this.borderWidth=2}) : super(key: key);

  getImage(){
    if(format!=null){
      return "${UtilityTools.getServerUrl()}getphoto/user/id/$photo?$format";
    }else{
      return "${UtilityTools.getServerUrl()}getphoto/user/id/$photo";
    }
  }

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: getImage(),
      imageBuilder: (context, imageProvider) => Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(MoobTheme.radius*4)),
          border: Border.all(color: borderColor,width: borderWidth),
          image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
          ),
        ),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error_outline,color: Colors.red,),
    );
  }

}