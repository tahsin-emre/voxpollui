import 'package:easy_localization/easy_localization.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';

enum Gender {
  none,
  male,
  female,
}

extension GenderExtension on Gender {
  String get toText {
    if (this == Gender.male) return LocaleKeys.auth_genderMale.tr();
    if (this == Gender.female) return LocaleKeys.auth_genderFemale.tr();
    return LocaleKeys.auth_gender.tr();
  }
}
