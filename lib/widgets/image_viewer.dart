import 'package:flutter/material.dart';
import 'package:personal_safety/models/event_model.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewer extends StatelessWidget {
  final String data;

  ImageViewer({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: PhotoView(
        imageProvider:
            NetworkImage("https://personalsafety.azurewebsites.net/$data"),
      ),
    );
  }
}
