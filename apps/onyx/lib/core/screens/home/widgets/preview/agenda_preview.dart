import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/screens/home/widgets/preview/screen_preview_widget.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/agenda/widgets/event_classic_widget.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AgendaPreview extends StatelessWidget {
  const AgendaPreview({super.key});

  @override
  Widget build(BuildContext context) {
    // streamController.add(DateTime.now());
    return BlocBuilder<AgendaCubit, AgendaState>(
      builder: (context, state) {
        if (state.status == AgendaStatus.initial) {
          context.read<AgendaCubit>().load(
                lyon1Cas: context.read<AuthentificationCubit>().state.lyon1Cas,
                settings: context.read<SettingsCubit>().state.settings,
              );
        }
        Day? day;
        for (var i
            in state.days(context.read<SettingsCubit>().state.settings)) {
          if (i.date.isAfter(DateTime.now())) {
            day = i;
            break;
          }
        }
        day = Day(DateTime.now(),
            AgendaLogic.dayListMock.first.events); //TODO change this  to [] !

        return ScreenPreviewWidget(
          title: "Agenda",
          onTap: const AgendaPage(),
          children: state
              .days(context.read<SettingsCubit>().state.settings)
              .where((dayElement) => dayElement.date
                  .shrink(3)
                  .add(const Duration(days: 1))
                  .isAfter(DateTime.now()))
              .map((dayElement) => day!.events
                  .map(
                    (element) => Container(
                      padding: const EdgeInsets.only(
                        bottom: 4,
                      ),
                      child: EventClassicWidget(
                        event: element,
                      ),
                    ),
                  )
                  .toList())
              .toList()
              .expand((element) => element) // flatter the list
              .toList(),
        );
      },
    );
  }
}
