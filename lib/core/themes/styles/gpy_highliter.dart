import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/dracula.dart';
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
        theme: CustomTheme,
        padding: const EdgeInsets.all(40),
      ),
    ),
  );
}

const CustomTheme = {
  'root': TextStyle(
    backgroundColor: Color.fromARGB(255, 15, 15, 15),
    color: Color(0xFFD4D4D4),
  ),
  'keyword': TextStyle(
    color: Color(0xFF569CD6),
    fontWeight: FontWeight.bold,
  ), // Blue
  'selector-tag': TextStyle(
    color: Color(0xFF4EC9B0),
    fontWeight: FontWeight.bold,
  ), // Cyan
  'literal': TextStyle(
    color: Color(0xFFB5CEA8),
    fontWeight: FontWeight.bold,
  ), // Light Green
  'section': TextStyle(
    color: Color(0xFFDCDCAA),
    fontWeight: FontWeight.bold,
  ), // Yellow
  'link': TextStyle(color: Color(0xFF3B8EEA)), // Bright Blue
  'subst': TextStyle(color: Color(0xFFD4D4D4)), // Light Gray
  'string': TextStyle(color: Color(0xFFCE9178)), // Orange
  'title': TextStyle(
    color: Color(0xFFDCDC8B),
    fontWeight: FontWeight.bold,
  ), // Pale Yellow
  'name': TextStyle(
    color: Color(0xFF4FC1FF),
    fontWeight: FontWeight.bold,
  ), // Sky Blue
  'type': TextStyle(
    color: Color(0xFF4EC9B0),
    fontWeight: FontWeight.bold,
  ), // Teal
  'attribute': TextStyle(color: Color(0xFF9CDCFE)), // Light Blue
  'symbol': TextStyle(color: Color(0xFFC586C0)), // Purple
  'bullet': TextStyle(color: Color(0xFFD7BA7D)), // Gold
  'addition': TextStyle(color: Color(0xFF6A9955)), // Green
  'variable': TextStyle(color: Color(0xFF9CDCFE)), // Light Blue
  'template-tag': TextStyle(color: Color(0xFFC586C0)), // Purple
  'template-variable': TextStyle(color: Color(0xFF9CDCFE)), // Light Blue
  'comment': TextStyle(color: Color(0xFF6A9955)), // Muted Green
  'quote': TextStyle(color: Color(0xFF608B4E)), // Dark Green
  'deletion': TextStyle(color: Color(0xFFF48771)), // Red
  'meta': TextStyle(color: Color(0xFF808080)), // Gray
  'doctag': TextStyle(
    color: Color(0xFF569CD6),
    fontWeight: FontWeight.bold,
  ), // Blue
  'strong': TextStyle(
    color: Color(0xFFD4D4D4),
    fontWeight: FontWeight.bold,
  ), // White
  'emphasis': TextStyle(
    color: Color(0xFFD4D4D4),
    fontStyle: FontStyle.italic,
  ), // White
};
Widget KImageErrorBuilder(context, error, stackTrace) {
  return const Icon(Icons.error);
}
