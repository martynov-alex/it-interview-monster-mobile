import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_interview_monster/src/feature/initialization/widget/dependencies_scope.dart';
import 'package:it_interview_monster/src/feature/settings/bloc/app_settings_bloc.dart';
import 'package:it_interview_monster/src/feature/settings/model/app_settings.dart';

/// SettingsScope widget.
class SettingsScope extends StatefulWidget {
  const SettingsScope({required this.child, super.key});

  /// The child widget.
  final Widget child;

  /// Get the [AppSettingsBloc] instance.
  static AppSettingsBloc of(BuildContext context, {bool listen = true}) {
    final settingsScope =
        listen
            ? context.dependOnInheritedWidgetOfExactType<_InheritedSettings>()
            : context.getInheritedWidgetOfExactType<_InheritedSettings>();
    return settingsScope!.state._appSettingsBloc;
  }

  /// Get the [AppSettings] instance.
  static AppSettings settingsOf(BuildContext context, {bool listen = true}) {
    final settingsScope =
        listen
            ? context.dependOnInheritedWidgetOfExactType<_InheritedSettings>()
            : context.getInheritedWidgetOfExactType<_InheritedSettings>();
    return settingsScope!.settings ?? const AppSettings();
  }

  @override
  State<SettingsScope> createState() => _SettingsScopeState();
}

/// State for widget SettingsScope.
class _SettingsScopeState extends State<SettingsScope> {
  late final AppSettingsBloc _appSettingsBloc;

  @override
  void initState() {
    super.initState();
    _appSettingsBloc = DependenciesScope.of(context).appSettingsBloc;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingsBloc, AppSettingsState>(
      bloc: _appSettingsBloc,
      builder:
          (context, state) => _InheritedSettings(
            settings: state.appSettings,
            state: this,
            child: widget.child,
          ),
    );
  }
}

/// _InheritedSettings widget.
class _InheritedSettings extends InheritedWidget {
  const _InheritedSettings({
    required super.child,
    required this.state,
    required this.settings,
  });

  /// _SettingsScopeState instance.
  final _SettingsScopeState state;
  final AppSettings? settings;

  @override
  bool updateShouldNotify(covariant _InheritedSettings oldWidget) =>
      settings != oldWidget.settings;
}
