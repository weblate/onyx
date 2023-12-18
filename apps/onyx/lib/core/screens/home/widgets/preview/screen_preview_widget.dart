import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

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
    Function()? openAction;
    stream.listen((event) {
      openAction!.call();
    });

    openAction = () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Scaffold(body: onTap),
        ),
      );
    };

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
          openAction = action;
          return Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                openAction!.call();
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
                      child: ListView(
                        shrinkWrap: true,
                        children: children
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                ),
                                child: e,
                              ),
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
  }
}
