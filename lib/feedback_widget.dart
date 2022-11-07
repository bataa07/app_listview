import 'package:flutter/material.dart';

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    super.key,
    required this.dragChildKey,
    required this.child,
  });

  final GlobalKey dragChildKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final RenderBox renderBox =
        dragChildKey.currentContext?.findRenderObject() as RenderBox;

    print("renderBox : ${renderBox.localToGlobal(Offset.zero)}");

    final size = renderBox.size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Material(child: child),
    );
  }
}
