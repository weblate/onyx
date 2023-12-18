import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/theme/theme_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GradeCompactWidget extends StatelessWidget {
  final Grade grade;
  final TeachingUnit teachingUnit;

  const GradeCompactWidget(
      {super.key, required this.grade, required this.teachingUnit});

  @override
  Widget build(BuildContext context) {
    return TomussCompactElementWidget(
      color: TomussLogic.getMainGradeColor(
          forceGreen: context.read<SettingsCubit>().state.settings.forceGreen,
          isSeen: false,
          grades: [grade]),
      teachingUnit: teachingUnit,
      child2: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            grade.numerator.toString(),
            style: TextStyle(
              color: OnyxTheme.darkTheme.colorScheme.background,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '/${grade.denominator.toStringAsFixed(0)}',
            style: TextStyle(
              color: OnyxTheme.darkTheme.colorScheme.background,
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      text1: grade.title.replaceAll("_", " "),
      text3: teachingUnit.title,
    );
  }
}
