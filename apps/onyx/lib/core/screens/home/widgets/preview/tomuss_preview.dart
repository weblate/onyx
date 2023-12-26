import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/screens/home/widgets/preview/screen_preview_widget.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:onyx/screens/tomuss/widgets/tomuss_element_widgets/enumeration_widget.dart';

class TomussPreview extends StatelessWidget {
  const TomussPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TomussCubit, TomussState>(
      builder: (context, state) {
        final streamController = StreamController<
            ({
              TeachingUnit teachingUnit,
              TeachingUnitElement teachingUnitElement
            })>();
        return ScreenPreviewWidget(
          title: "Tomuss",
          onTap: const TomussPage(),
          stream: streamController.stream,
          children: TomussLogic.teachingUnitsModelListMock
              .map((e) {
                return e.grades
                    .map(
                      (element) => Container(
                        padding: const EdgeInsets.only(
                          bottom: 4,
                        ),
                        child: GradeWidget(
                          showCoef: false,
                          grades: [element],
                          clickable: true,
                          teachingUnit: e,
                        ),
                      ),
                    )
                    .toList();
              })
              .toList()
              .expand((element) => element)
              .toList(),
        );
      },
    );
  }
}
