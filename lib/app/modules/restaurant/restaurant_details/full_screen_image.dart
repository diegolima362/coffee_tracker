import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final Image image;

  FullScreenImage(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () => Navigator.pop(context),
      ),
      body: PhotoView(
        imageProvider: image.image,
        maxScale: PhotoViewComputedScale.contained * 3,
        minScale: PhotoViewComputedScale.contained * .5,
      ),
    );
  }
}
