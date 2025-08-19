import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:linkify/core/exports/app_router.dart';

class ImagePresentationPage extends StatelessWidget {
  const ImagePresentationPage({super.key, required this.image});
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            GoRouter.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 173, 173, 173),
            size: 30,
          ),
        ),
      ),
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
