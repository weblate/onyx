import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

class StageCodeCompactWidget extends StatelessWidget {
  final StageCode stageCode;
  final TeachingUnit teachingUnit;

  const StageCodeCompactWidget(
      {super.key,
      required this.stageCode,
      required this.teachingUnit});

  @override
  Widget build(BuildContext context) {
    return TomussCompactElementWidget(
      teachingUnit: teachingUnit,
      text1: stageCode.title,
      text2: stageCode.value,
      text3: teachingUnit.title,
    );
  }
}
