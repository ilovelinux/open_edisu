import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

// Wanted to try to override an existing widget
// insteading of creating a new one
class CenteredText extends Text {
  const CenteredText(
    String data, {
    super.key,
    super.style,
    super.strutStyle,
    super.textAlign = TextAlign.center,
    super.textDirection,
    super.locale,
    super.softWrap,
    super.overflow,
    super.textScaleFactor,
    super.maxLines,
    super.semanticsLabel,
    super.textWidthBasis,
    super.textHeightBehavior,
  }) : super(data);

  @override
  Widget build(BuildContext context) {
    return Center(child: super.build(context));
  }
}
