import 'package:flutter/material.dart';

Widget buildErrorWidget(String error) {
  return Container(
    child: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Opps!! an error occured",
          // error,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    ),
  );
}
