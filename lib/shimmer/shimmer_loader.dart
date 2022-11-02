import 'package:app_listview/shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ShimmerLoader extends HookWidget {
  const ShimmerLoader({
    super.key,
    required this.shimmerItem,
  });

  final Widget shimmerItem;

  @override
  Widget build(BuildContext context) {
    final shimmerGradient = LinearGradient(
      colors: [
        Theme.of(context).hintColor,
        Theme.of(context).hoverColor,
        Theme.of(context).hintColor,
      ],
      stops: const [
        0.1,
        0.3,
        0.4,
      ],
      begin: const Alignment(-1.0, -0.3),
      end: const Alignment(1.0, 0.3),
      tileMode: TileMode.clamp,
    );

    return Shimmer(
      linearGradient: shimmerGradient,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          return ShimmerLoading(
            isLoading: true,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: shimmerItem,
            ),
          );
        },
      ),
    );
  }
}
