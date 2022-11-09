// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:core/core.dart';
import 'package:flutter/material.dart';

class TapableSubHeading extends StatefulWidget {
  final String title;
  final Function() onTap;

  TapableSubHeading({super.key, required this.title, required this.onTap});

  @override
  State<TapableSubHeading> createState() => _TapableSubHeadingState();
}

class _TapableSubHeadingState extends State<TapableSubHeading> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.title,
          style: kHeading6,
        ),
        InkWell(
          onTap: widget.onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
