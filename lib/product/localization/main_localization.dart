import 'package:easy_localization/easy_localization.dart';
import 'package:voxpollui/product/constants/locale_constants.dart';

final class MainLocalization extends EasyLocalization {
  MainLocalization({
    required super.child,
    super.key,
  }) : super(
          path: translationsPath,
          useOnlyLangCode: true,
          fallbackLocale: LocaleConstants.tr,
          supportedLocales: [
            LocaleConstants.tr,
          ],
        );

  static const translationsPath = 'assets/translations';
}
