import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class progressShimmer extends StatelessWidget {
  final double width;
  final double height;

  progressShimmer({
    this.width = double.infinity,
    this.height = 120.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.only(bottom: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,  
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

