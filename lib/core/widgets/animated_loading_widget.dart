import 'package:flutter/material.dart';

class AnimatedLoadingWidget extends StatelessWidget {
  final double height;

  const AnimatedLoadingWidget({super.key, this.height = 80});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}
