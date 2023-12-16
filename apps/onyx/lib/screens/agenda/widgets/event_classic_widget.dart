import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lyon1agendaclient/lyon1agendaclient.dart';
import 'package:onyx/core/extensions/extensions_export.dart';
import 'package:onyx/core/theme/theme.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/tomuss/widgets/tomuss_element_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EventClassicWidget extends StatelessWidget {
  final Event event;

  const EventClassicWidget({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.transparent,
      closedElevation: 0.0,
      openElevation: 0.0,
      tappable: false,
      openColor: Theme.of(context).colorScheme.background,
      middleColor: Theme.of(context).colorScheme.background,
      transitionType: ContainerTransitionType.fadeThrough,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      openBuilder: (context, _) => EventDetailPage(event: event),
      closedBuilder: (context, openContainer) {
        return TomussElementWidget(
          onTap: openContainer,
          left: Flexible(
            flex: 40,
            fit: FlexFit.tight,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        '${event.start.toWeekDayName()} ${event.start.day}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        '${event.start.hour.toFixedLengthString(2)}:${event.start.minute.toFixedLengthString(2)}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        '${event.end.hour.toFixedLengthString(2)}:${event.end.minute.toFixedLengthString(2)}',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color!
                                .withOpacity(0.8),
                            fontSize: 11),
                      ),
                    ],
                  ),
                ),
                (event.start.isBefore(DateTime.now()) &&
                        event.end.isAfter(DateTime.now()))
                    ? Transform.translate(
                        offset: Offset(-(30.sp * 0.45), 0),
                        child: Icon(
                          Icons.arrow_right_rounded,
                          size: 30.sp,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          right: Flexible(
            flex: 150,
            child: Container(
              padding: EdgeInsets.only(left: 4.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event.name,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AutoSizeText(
                    '${event.end.difference(event.start).durationBeautifull()} • ${event.location}',
                    textAlign: TextAlign.left,
                    maxLines: 2,
                    softWrap: true,
                    style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
