import 'package:flutter/material.dart';

Widget buildLoadingWidget() {
  return const Center(
    child: Column(
      children: [
        CircularProgressIndicator(),
      ],
    ),
  );
}
