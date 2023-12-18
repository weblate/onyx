import 'package:flutter/material.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

class PresenceCompactWidget extends StatelessWidget {
  final Presence presence;
  final TeachingUnit teachingUnit;

  const PresenceCompactWidget(
      {super.key,
      required this.presence,
      required this.teachingUnit});

  @override
  Widget build(BuildContext context) {
    return TomussCompactElementWidget(
      teachingUnit: teachingUnit,
      text1: presence.value,
      text2: presence.title,
      text3: teachingUnit.title,
      color: presence.color.toColor(),
    );
  }
}
