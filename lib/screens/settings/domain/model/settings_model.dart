import 'package:hive_flutter/hive_flutter.dart';

import 'package:oloid2/screens/settings/settings_export.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 7)
class SettingsModel {
  @HiveField(0)
  late bool keepMeLoggedIn;

  @HiveField(1)
  late bool forceGreen;
  @HiveField(2)
  late ThemeModeEnum themeMode;
  @HiveField(3)
  late bool newGradeNotification;

  @HiveField(4)
  late bool showHiddenUE;

  @HiveField(5)
  late bool fetchAgendaAuto;

  @HiveField(6)
  late bool showMiniCalendar;

  @HiveField(7)
  late bool calendarUpdateNotification;

  @HiveField(8)
  late String agendaURL;

  @HiveField(9)
  late bool newMailNotification;

  @HiveField(10)
  late bool blockTrackers;

  @HiveField(11)
  late bool darkerMail;

  SettingsModel({
    this.keepMeLoggedIn = true,
    this.forceGreen = false,
    this.themeMode = ThemeModeEnum.system,
    this.newGradeNotification = false,
    this.showHiddenUE = false,
    this.fetchAgendaAuto = true,
    this.showMiniCalendar = true,
    this.calendarUpdateNotification = true,
    this.agendaURL = "",
    this.newMailNotification = false,
    this.blockTrackers = true,
    this.darkerMail = false,
  });

  void copy(SettingsModel s) {
    keepMeLoggedIn = s.keepMeLoggedIn;
    forceGreen = s.forceGreen;
    themeMode = s.themeMode;
    newGradeNotification = s.newGradeNotification;
    showHiddenUE = s.showHiddenUE;
    fetchAgendaAuto = s.fetchAgendaAuto;
    agendaURL = s.agendaURL;
    newMailNotification = s.newMailNotification;
    blockTrackers = s.blockTrackers;
    calendarUpdateNotification = s.calendarUpdateNotification;
    darkerMail = s.darkerMail;
  }

  SettingsModel copyWith({
    bool? keepMeLoggedIn,
    bool? forceGreen,
    ThemeModeEnum? themeMode,
    bool? newGradeNotification,
    bool? showHiddenUE,
    bool? fetchAgendaAuto,
    bool? showMiniCalendar,
    bool? calendarUpdateNotification,
    String? agendaURL,
    bool? newMailNotification,
    bool? blockTrackers,
    bool? darkerMail,
  }) {
    return SettingsModel(
      keepMeLoggedIn: keepMeLoggedIn ?? this.keepMeLoggedIn,
      forceGreen: forceGreen ?? this.forceGreen,
      themeMode: themeMode ?? this.themeMode,
      newGradeNotification: newGradeNotification ?? this.newGradeNotification,
      showHiddenUE: showHiddenUE ?? this.showHiddenUE,
      fetchAgendaAuto: fetchAgendaAuto ?? this.fetchAgendaAuto,
      calendarUpdateNotification:
          calendarUpdateNotification ?? this.calendarUpdateNotification,
      showMiniCalendar: showMiniCalendar ?? this.showMiniCalendar,
      agendaURL: agendaURL ?? this.agendaURL,
      newMailNotification: newMailNotification ?? this.newMailNotification,
      blockTrackers: blockTrackers ?? this.blockTrackers,
      darkerMail: darkerMail ?? this.darkerMail,
    );
  }

  @override
  String toString() {
    return 'SettingsModel(keepMeLoggedIn: $keepMeLoggedIn, forceGreen: $forceGreen, themeMode: $themeMode, newGradeNotification: $newGradeNotification, showHiddenUE: $showHiddenUE, fetchAgendaAuto: $fetchAgendaAuto, calendarUpdateNotification: $calendarUpdateNotification showMiniCalendar: $showMiniCalendar, agendaURL: $agendaURL, newMailNotification: $newMailNotification, blockTrackers: $blockTrackers, darkerMail: $darkerMail)';
  }
}
