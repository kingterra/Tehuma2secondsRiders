import 'package:flutter/material.dart';

class SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  SliverHeaderDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 60.0; // Ajusta la altura según sea necesario

  @override
  double get minExtent => 60.0; // Ajusta la altura según sea necesario

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
