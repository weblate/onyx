import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CommonOnyxWidget extends StatelessWidget {
  const CommonOnyxWidget(
      {super.key,
      this.color,
      this.onTap,
      required this.left,
      required this.right,
      this.tapable = false,
      this.openedChild});

  final Color? color;
  final Function()? onTap;
  final Widget left;
  final Widget right;
  final Widget? openedChild;
  final bool tapable;

  @override
  Widget build(BuildContext context) {
    assert(tapable || openedChild == null);
    return OpenContainer(
        tappable: false,
        closedColor: Colors.transparent,
        openColor: Colors.transparent,
        closedElevation: 0,
        openElevation: 0,
        openBuilder: (context, callOpen) {
          if (openedChild != null) {
            return openedChild!;
          }
          return const Placeholder();
        },
        closedBuilder: (context, callOpen) {
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: (tapable)
                  ? () {
                      if (onTap != null) onTap!();
                      callOpen();
                    }
                  : null,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: SizedBox(
                height: 11.h,
                // (Device.screenType == ScreenType.mobile &&
                //         Device.orientation == Orientation.portrait)
                //     ? 11.h
                //     : null,
                child: Ink(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SizedBox(
                        height: constraints.maxHeight,
                        child: Row(
                          children: [
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: SizedBox(
                                height: constraints.maxHeight,
                                child: Ink(
                                    decoration: BoxDecoration(
                                        color: color ??
                                            Theme.of(context).primaryColor,
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                        )),
                                    child: left),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              fit: FlexFit.tight,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: constraints.maxWidth * 0.02),
                                padding: EdgeInsets.symmetric(
                                    vertical: constraints.maxHeight * 0.02),
                                child: right,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                // child: child,
              ),
            ),
          );
        });
  }
}
