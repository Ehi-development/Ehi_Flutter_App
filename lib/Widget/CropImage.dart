import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hey_flutter/Pages/AddDetailPage.dart';
import 'package:hey_flutter/UtilityClass/RouteBuilder.dart';
import 'package:hey_flutter/Widget/Theme.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';

class CropImage extends StatefulWidget {
  final username;
  final password;
  final Offset position;

  const CropImage({Key key, this.username, this.password, this.position}) : super(key: key);

  @override
  CropImageState createState() => CropImageState();
}

class CropImageState extends State<CropImage> {
  final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
          child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
        ),
      ),
    );
  }

  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(_sample, key: cropKey),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Annulla',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                onPressed: () => _cropImage().then((image){
                    setState(() {
                      _sample=null;
                      _file=null;
                    });
                    }
                  )
              ),
              FlatButton(
                  child: Text(
                    'Accetta',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: Colors.white),
                  ),
                  onPressed: () => _cropImage().then((image){
                    List<int> imageBytes = image.readAsBytesSync();
                    Navigator.of(context).pushReplacement(CircularRevealRoute(widget: AddDetailPage(username: widget.username, password: widget.password, image: base64.encode(imageBytes),),position:widget.position));
                  })
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    return Material(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(MoobTheme.radius)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text(
                  'Galleria',
                  style: TextStyle(color: MoobTheme.textColor),
                ),
                leading: Icon(Icons.image),
                onTap: () => _openImage(),
              ),
              ListTile(
                title: Text(
                  'Camera',
                  style: TextStyle(color: MoobTheme.textColor),
                ),
                leading: Icon(Icons.camera_alt),
                onTap: () => _openCamera(),
              ),
            ],
          ),
        ),
    );
  }

  Future<void> _openImage() async {
    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size.longestSide.ceil(),
    );

    _sample?.delete();
    _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  Future<void> _openCamera() async {
    final file = await ImagePicker.pickImage(source: ImageSource.camera);
    final sample = await ImageCrop.sampleImage(
      file: file,
      preferredSize: context.size.longestSide.ceil(),
    );

    _sample?.delete();
    _file?.delete();

    setState(() {
      _sample = sample;
      _file = file;
    });
  }

  Future<File> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return null;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    _lastCropped?.delete();
    _lastCropped = file;

    return _lastCropped;
  }
}