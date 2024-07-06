import 'dart:io';

import 'package:flutter/material.dart';

Widget boldText(String text) {
  return Text(
    text,
    style: const TextStyle(fontWeight: FontWeight.bold),
  );
}

Widget sizeBox(double w, [double? h]) {
  return SizedBox(
    width: w,
    height: h ?? w,
  );
}

  Widget getImgIcon() {
    return const SizedBox(
      height: 80,
      child: Icon(
        Icons.image,
        color: Colors.grey,
        size: 60,
      ),
    );
  }

  Widget showImage(String imgPath) {
    return Image.file(
      File(imgPath),
      fit: BoxFit.contain,
    );
  }
