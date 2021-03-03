import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final Uint8List image;

  FullScreenImage(this.image);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: PhotoView(
          imageProvider: Image.memory(image).image,
          maxScale: PhotoViewComputedScale.contained * 3,
          minScale: PhotoViewComputedScale.contained * .5,
        ),
      ),
    );
  }
}
