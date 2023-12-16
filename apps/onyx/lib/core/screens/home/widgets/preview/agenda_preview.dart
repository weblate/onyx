import 'dart:async';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/screens/home/logic/home_logic.dart';
import 'package:onyx/core/screens/home/widgets/preview/screen_preview_widget.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/agenda/states/agenda_cubit.dart';
import 'package:onyx/screens/agenda/widgets/event_classic_widget.dart';
import 'package:onyx/screens/login/login_export.dart';
import 'package:onyx/screens/settings/states/settings_cubit.dart';

class AgendaPreview extends StatelessWidget {
  const AgendaPreview({super.key});

  @override
  Widget build(BuildContext context) {
    // streamController.add(DateTime.now());
    return BlocBuilder<AgendaCubit, AgendaState>(
      builder: (context, state) {
        print("hello we should build it");
        print(state.status);
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
            AgendaLogic.dayListMock.first.events); //TODO change this !

        return OpenContainer(
            closedColor: Colors.transparent,
            closedElevation: 0,
            tappable: false,
            openBuilder: (context, action) {
              return Stack(
                children: [
                  const AgendaPage(),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back))
                ],
              );
            },
            closedBuilder: (context, action) {
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () {
                    HomeLogic.openScreenMessage = null;
                    action();
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Agenda",
                          style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: PageView(
                            children: state
                                .days(context
                                    .read<SettingsCubit>()
                                    .state
                                    .settings)
                                .where((e) => e.date
                                    .shrink(3)
                                    .add(const Duration(days: 1))
                                    .isAfter(DateTime.now()))
                                .map(
                                  (e) => ListView(
                                      shrinkWrap: true,
                                      children: day!.events
                                          .map(
                                            (e) => Container(
                                              padding: const EdgeInsets.only(
                                                bottom: 8,
                                              ),
                                              child: EventClassicWidget(
                                                event: e,
                                              ),
                                            ),
                                          )
                                          .toList()),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
    );
  }
}
