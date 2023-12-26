import 'package:flutter/material.dart';
import 'package:onyx/core/res.dart';
import 'package:onyx/core/screens/home/widgets/preview/agenda_preview.dart';
import 'package:onyx/core/screens/home/widgets/preview/tomuss_preview.dart';
import 'package:onyx/screens/agenda/agenda_export.dart';
import 'package:onyx/screens/colloscope/pages/colloscope_page.dart';
import 'package:onyx/screens/colloscope/widgets/colloscope_bottom_nav_bar_icon.dart';
import 'package:onyx/screens/izly/izly_export.dart';
import 'package:onyx/screens/mails/mails_export.dart';
import 'package:onyx/screens/map/map_export.dart';
import 'package:onyx/screens/settings/settings_export.dart';
import 'package:onyx/screens/settings/widgets/screen_settings/colloscope_settings_widget.dart';
import 'package:onyx/screens/settings/widgets/screen_settings/email_settings_widget.dart';
import 'package:onyx/screens/tomuss/tomuss_export.dart';

extension FunctionalitiesExtention on Functionalities {
  String toCleanString() {
    switch (this) {
      case Functionalities.tomuss:
        return "Notes";
      case Functionalities.agenda:
        return "Agenda";
      case Functionalities.mail:
        return "Mail";
      case Functionalities.map:
        return "Carte";
      case Functionalities.izly:
        return "Izly";
      case Functionalities.settings:
        return "Paramètres";
      case Functionalities.colloscope:
        return "Colloscope";
    }
  }

  IconData toIcon() {
    switch (this) {
      case Functionalities.tomuss:
        return Icons.class_rounded;
      case Functionalities.agenda:
        return Icons.calendar_today_rounded;
      case Functionalities.mail:
        return Icons.email_rounded;
      case Functionalities.map:
        return Icons.map_rounded;
      case Functionalities.izly:
        return Icons.attach_money_rounded;
      case Functionalities.settings:
        return Icons.settings_rounded;
      case Functionalities.colloscope:
        return Icons.school_rounded;
    }
  }

  Widget toPage() {
    switch (this) {
      case Functionalities.tomuss:
        return const TomussPage();
      case Functionalities.agenda:
        return const AgendaPage();
      case Functionalities.mail:
        return const MailsPage();
      case Functionalities.map:
        return const MapPage();
      case Functionalities.izly:
        return const IzlyPage();
      case Functionalities.settings:
        return const SettingsPage();
      case Functionalities.colloscope:
        return const ColloscopePage();
    }
  }

  Widget toBottomBarIcon({required bool selected}) {
    switch (this) {
      case Functionalities.tomuss:
        return TomussBottomNavBarIcon(selected: selected);
      case Functionalities.agenda:
        return AgendaBottomNavBarIcon(selected: selected);
      case Functionalities.mail:
        return MailBottomNavBarIcon(selected: selected);
      case Functionalities.map:
        return MapBottomNavBarIcon(selected: selected);
      case Functionalities.izly:
        return IzlyBottomNavBarIcon(selected: selected);
      case Functionalities.settings:
        return SettingsBottomNavBarIcon(selected: selected);
      case Functionalities.colloscope:
        return ColloscopeBottomNavBarIcon(selected: selected);
    }
  }

  Widget toSettings({Key? key, VoidCallback? sizeUpdate}) {
    switch (this) {
      case Functionalities.tomuss:
        return TomussSettingsWidget(
          key: key,
        );
      case Functionalities.agenda:
        return AgendaSettingsWidget(
          key: key,
        );
      case Functionalities.mail:
        return MailSettingsWidget(
          key: key,
        );
      case Functionalities.map:
        return MapSettingsWidget(
          key: key,
        );
      case Functionalities.izly:
        return IzlySettingsWidget(
          key: key,
        );
      case Functionalities.settings:
        return SettingsSettingsWidget(
          key: key,
        );
      case Functionalities.colloscope:
        return ColloscopeSettingsWidget(
          key: key,
        );
    }
  }

  Widget toPreview() {
    switch (this) {
      case Functionalities.tomuss:
        return const TomussPreview();
      case Functionalities.agenda:
        return const AgendaPreview();
      // case Functionalities.mail:
      //   return const MailPreview();
      // case Functionalities.map:
      //   return const MapPreview();
      // case Functionalities.izly:
      // return const IzlyPreview();
      // case Functionalities.settings:
      //   return const SettingsPreview();
      default:
        return const Text("coucou");
    }
  }
}
