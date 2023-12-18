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
    // streamController.add(DateTime.now());
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
          children: state.newElements
              .where((element) => element.teachingUnitElement.isVisible)
              .map(
            (e) {
              Widget widget;
              switch (e.teachingUnitElement.runtimeType) {
                case const (Grade):
                  widget = GradeWidget(
                    showCoef: false,
                    grades: [e.teachingUnitElement as Grade],
                    clickable: true,
                    teachingUnit: e.teachingUnit,
                    // onTap: () {
                    //   streamController.add(e);
                    // },
                  );
                  break;
                case const (Enumeration):
                  widget = EnumerationWidget(
                      enumeration: (e.teachingUnitElement as Enumeration));
                case const (Presence):
                  widget = PresenceWidget(
                      presence: (e.teachingUnitElement as Presence));
                case const (TomussText):
                  widget = TomussTextWidget(
                      text: (e.teachingUnitElement as TomussText));
                case const (Upload):
                  widget =
                      UploadWidget(upload: (e.teachingUnitElement as Upload));
                case const (StageCode):
                  widget = StageCodeWidget(
                      stageCode: (e.teachingUnitElement as StageCode));
                case const (URL):
                  widget = URLWidget(url: (e.teachingUnitElement as URL));
                default:
                  widget = const Text("coucou");
                  break;
              }
              return widget;
            },
          ).toList(),
        );
      },
    );
  }
}
