import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/theme/theme_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:path_provider/path_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class GradeWidget extends StatefulWidget {
  final List<Grade> grades;
  final String? text1;
  final String? text2;
  final bool isSeen;
  final VoidCallback? onTap;
  final int depth;
  final bool showCoef;

  const GradeWidget({
    super.key,
    required this.grades,
    this.text1,
    this.text2,
    this.depth = 1,
    this.isSeen = false,
    this.onTap,
    this.showCoef = true,
  });

  @override
  State<GradeWidget> createState() => _GradeWidgetState();
}

class _GradeWidgetState extends State<GradeWidget> {
  ScreenshotController screenshotController = ScreenshotController();
  double numerator = 0;
  double denominator = 0;
  String gradeNumerator = '';

  void calculateNumerator() {
    if (widget.depth != 0) {
      numerator = widget.grades.first.numerator;
      denominator = widget.grades.first.denominator;
    } else {
      if (widget.grades.length == 1) {
        denominator = widget.grades.first.denominator;
      } else {
        denominator = 20;
      }
      double coefSum = 0.0;
      numerator = 0;
      for (var i in widget.grades) {
        if (!i.numerator.isNaN && !i.denominator.isNaN) {
          numerator += (i.numerator / i.denominator) * (i.coef);
          coefSum += (i.coef);
        }
      }
      numerator = (numerator / ((coefSum != 0) ? coefSum : 1)) * denominator;
    }
    gradeNumerator =
        ((widget.grades.isNotEmpty) ? numerator.toStringAsPrecision(3) : '-');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TomussCubit, TomussState>(builder: (context, state) {
      calculateNumerator();
      return GestureDetector(
        onTap: (widget.onTap != null) ? () => widget.onTap!() : null,
        child: Screenshot(
          controller: screenshotController,
          child: TomussElementWidget(
            color: TomussLogic.getMainGradeColor(
                forceGreen:
                    context.read<SettingsCubit>().state.settings.forceGreen,
                isSeen: widget.isSeen,
                grades: widget.grades),
            left: Column(
              children: [
                const Spacer(
                  flex: 4,
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 10,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      gradeNumerator,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: OnyxTheme.darkTheme.colorScheme.background,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Spacer(),
                    Flexible(
                      flex: 5,
                      child: Container(
                        height: 0.2.h,
                        color: OnyxTheme.darkTheme.colorScheme.background,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                Flexible(
                  fit: FlexFit.tight,
                  flex: 10,
                  child: Text(
                    ((widget.grades.isNotEmpty) ? denominator : '-').toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: OnyxTheme.darkTheme.colorScheme.background,
                        fontSize: 16.sp),
                  ),
                ),
              ],
            ),
            right: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  flex: 11,
                  fit: FlexFit.tight,
                  child: LayoutBuilder(builder: (context, contraints) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.text1 ??
                              widget.grades.first.title.replaceAll("_", " "),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 15.sp,
                          ),
                        ),
                        Text(
                          widget.text2 ??
                              "Moyenne : ${widget.grades.first.average.toStringAsFixed(2)} · Mediane : ${widget.grades.first.mediane.toStringAsFixed(2)}\nClassement : ${widget.grades.first.rank + 1}/${widget.grades.first.groupeSize}\nProfesseur : ${widget.grades.first.author}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 12.5.sp,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                const Spacer(
                  flex: 1,
                ),
                if (widget.depth == 1 && widget.showCoef)
                  GradeCoefWidget(grade: widget.grades.first),
                IconButton(
                    onPressed: () async {
                      Directory tmpDir = await getTemporaryDirectory();
                      await screenshotController.captureAndSave(
                        tmpDir.path,
                        pixelRatio: 3.0,
                        fileName: 'screenshot.png',
                      );
                      Share.shareXFiles(
                          [XFile("${tmpDir.path}/screenshot.png")],
                          text: "Voici ma note en ${widget.text1} !");
                    },
                    icon: Icon(
                      Icons.share_rounded,
                      size: 20.sp,
                    )),
              ],
            ),
            onTap: widget.onTap,
          ),
        ),
      );
    });
  }
}
