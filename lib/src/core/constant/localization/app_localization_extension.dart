import 'package:flutter/material.dart';
import 'package:it_interview_monster/src/core/constant/localization/generated/app_localizations.gen.dart';

extension AppLocalizationsExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}
