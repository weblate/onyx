import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

class TomussTextCompactWidget extends StatelessWidget {
  final TomussText text;
  final TeachingUnit teachingUnit;

  const TomussTextCompactWidget(
      {super.key, required this.text, required this.teachingUnit});

  @override
  Widget build(BuildContext context) {
    return TomussCompactElementWidget(
      teachingUnit: teachingUnit,
      text1: text.value,
      text2: text.title,
      text3: teachingUnit.title,
    );
  }
}
