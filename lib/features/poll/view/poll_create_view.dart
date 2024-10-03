import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/poll/cubit/poll_cubit.dart';
import 'package:voxpollui/features/poll/cubit/poll_state.dart';
import 'package:voxpollui/features/poll/mixin/poll_create_mixin.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_app_bar.dart';
import 'package:voxpollui/features/sub_features/common_widgets/custom_input_decoration.dart';
import 'package:voxpollui/features/sub_features/common_widgets/extended_elevated_button.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/category_model.dart';
import 'package:voxpollui/product/initialize/models/poll/option_model.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';
import 'package:voxpollui/product/utils/constants/page_paddings.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

part '../widget/poll_create_fields.dart';

class PollCreateView extends StatefulWidget {
  const PollCreateView({super.key});

  @override
  State<PollCreateView> createState() => _PollCreateViewState();
}

class _PollCreateViewState extends State<PollCreateView> with PollCreateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: BlocBuilder<PollCubit, PollState>(
        builder: (_, state) {
          final categories = state.categoryList ?? [];
          return Skeletonizer(
            enabled: state.isLoading,
            child: Padding(
              padding: PagePaddings.horL,
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleKeys.poll_createPoll.tr(),
                        style: TextStyle(
                          fontSize: 28,
                          fontFamily: FontConstants.gilroyBold,
                        ),
                      ),
                      _NameField(
                        titleCont,
                        imageUrlNotifier: imageUrlNotifier,
                        onImage: pickImage,
                      ),
                      const SizedBox(height: WidgetSizes.xl),
                      _OptionsField(
                        optionsNotifier: optionsNotifier,
                        onChanged: (val) => optionsNotifier.value = val,
                      ),
                      const SizedBox(height: WidgetSizes.xl),
                      _CategoryField(
                        categories,
                        onChanged: (value) => categoryIdNotifier.value = value,
                      ),
                      const SizedBox(height: WidgetSizes.xl),
                      _TimeField(
                        dayCont: dayCont,
                        hourCont: hourCont,
                        minuteCont: minuteCont,
                      ),
                      const SizedBox(height: WidgetSizes.xl),
                      _PublicField(
                        valueNotifier: isPublicNotifier,
                        onChanged: (value) => isPublicNotifier.value = value,
                      ),
                      ExtendedElevatedButton(
                        onPressed: onSave,
                        text: LocaleKeys.poll_publish.tr(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
