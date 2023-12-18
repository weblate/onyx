import 'package:lyon1tomussclient/lyon1tomussclient.dart';
import 'package:flutter/material.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';
import 'package:url_launcher/url_launcher.dart';

class URLCompactWidget extends StatelessWidget {
  final URL url;
  final TeachingUnit teachingUnit;

  const URLCompactWidget(
      {super.key,
      required this.url,
      required this.teachingUnit});

  @override
  Widget build(BuildContext context) {
    return TomussCompactElementWidget(
      teachingUnit: teachingUnit,
      text1: url.title,
      text3: teachingUnit.title,
      child2: IconButton(
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(url.value))) {
              await launchUrl(Uri.parse(url.value),
                  mode: LaunchMode.externalApplication);
            } else {
              // ignore: use_build_context_synchronously
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Erreur'),
                        content: const Text('Impossible d\'ouvrir le lien'),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'))
                        ],
                      ));
            }
          },
          icon: const Icon(Icons.open_in_new_rounded)),
    );
  }
}
