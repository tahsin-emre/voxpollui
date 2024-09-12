import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/product/preferences/preferences_state.dart';

final class PreferencesCubit extends Cubit<PreferencesState> {
  PreferencesCubit() : super(const PreferencesState());

  void setPreferences({
    required bool isFirst,
    required bool isDarkMode,
  }) {
    emit(
      state.copyWith(
        isFirst: isFirst,
        isDarkMode: isDarkMode,
      ),
    );
  }
}
