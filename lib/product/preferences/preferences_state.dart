import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class PreferencesState extends Equatable {
  const PreferencesState({
    this.preferences,
    this.isFirst,
    this.isDarkMode,
  });

  PreferencesState copyWith({
    SharedPreferences? preferences,
    bool? isFirst,
    bool? isDarkMode,
  }) {
    return PreferencesState(
      preferences: preferences ?? this.preferences,
      isFirst: isFirst ?? this.isFirst,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  final SharedPreferences? preferences;
  final bool? isFirst;
  final bool? isDarkMode;

  @override
  List<Object?> get props => [preferences, isFirst, isDarkMode];
}
