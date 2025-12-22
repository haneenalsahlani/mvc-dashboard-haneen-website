import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/androidstudio.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';

Widget KImageBuilder(context, imageUrl) {
  if (imageUrl.contains("svg")) {
    return SvgPicture.network(imageUrl, errorBuilder: KImageErrorBuilder);
  }
  if (imageUrl.contains("json")) {
    return Lottie.network(imageUrl, errorBuilder: KImageErrorBuilder);
  }
  return Image.network(imageUrl, errorBuilder: KImageErrorBuilder);
}

Widget KCodeBuilder(context, name, code, closed) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: HighlightView(
        code,
        language: name,
        tabSize: 6,

        theme: androidstudioTheme,
        padding: const EdgeInsets.all(40),
      ),
    ),
  );
}

Widget KImageErrorBuilder(context, error, stackTrace) {
  return const Icon(Icons.error);
}
