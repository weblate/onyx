import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScreenPreviewWidget extends StatelessWidget {
  const ScreenPreviewWidget({
    super.key,
    required this.title,
    required this.children,
    required this.onTap,
    this.stream = const Stream.empty(),
  });
  final String title;
  final List<Widget> children;
  final Widget onTap;
  final Stream stream;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.transparent,
      closedElevation: 0,
      tappable: false,
      openBuilder: (context, action) {
        return Stack(
          children: [
            onTap,
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back))
          ],
        );
      },
      closedBuilder: (context, action) {
        return Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              action.call();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    title,
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
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, rawIndex) {
                        int index = rawIndex * 2;
                        if (index >= children.length) {
                          return null;
                        }
                        return Column(
                          children: [
                            for (var i = 0;
                                i < 2 && i + index < children.length;
                                i++)
                              Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                ),
                                child: children[index + i],
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
