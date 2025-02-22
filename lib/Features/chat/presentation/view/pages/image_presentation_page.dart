import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImagePresentationPage extends StatelessWidget {
  const ImagePresentationPage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InteractiveViewer(
        clipBehavior: Clip.none,
        maxScale: 5,
        minScale: 1,
        child: Center(
            child: CachedNetworkImage(imageUrl: image, fit: BoxFit.contain)),
      ),
    );
  }
}
