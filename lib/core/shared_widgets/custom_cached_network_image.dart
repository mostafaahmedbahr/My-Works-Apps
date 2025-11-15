
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetWorkImage extends StatelessWidget {
  const CustomNetWorkImage({
    super.key,
    required this.imageUrl,
    required this.raduis,
    this.width,
    this.height,
    this.fit,
  });

  final String imageUrl;
  final double raduis;
  final double? height;
  final double? width;
  final BoxFit? fit;

  Widget _buildShimmer() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(raduis),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: width ?? double.infinity,
          height: height ?? double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(raduis),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(raduis),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        fit: fit ?? BoxFit.contain,
        placeholder: (context, url) => _buildShimmer(),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(raduis),
            color: Colors.grey[200],
          ),
          child: const Icon(Icons.error, color: Colors.grey),
        ),
      ),
    );
  }
}
