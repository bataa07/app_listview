import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Theme.of(context).splashColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              Container(
                height: 16,
                decoration: BoxDecoration(
                  color: Theme.of(context).splashColor,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 16,
                decoration: BoxDecoration(
                  color: Theme.of(context).splashColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
