import 'package:flutter/material.dart';
import 'package:meme_factory/core/widgets/shimmer_loading.dart';

class ShimmerGridItem extends StatelessWidget {
  const ShimmerGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: double.infinity, // Set height as needed
        width: double.infinity, // Adjust width if necessary
      ),
    );
  }
}
