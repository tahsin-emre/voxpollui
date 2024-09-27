import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:voxpollui/features/profile/cubit/profile_cubit.dart';
import 'package:voxpollui/features/profile/cubit/profile_state.dart';
import 'package:voxpollui/features/profile/mixin/profile_mixin.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/user_model.dart';
import 'package:voxpollui/product/utils/constants/color_constants.dart';
import 'package:voxpollui/product/utils/constants/font_constants.dart';
import 'package:voxpollui/product/utils/constants/icon_constants.dart';
import 'package:voxpollui/product/utils/constants/widget_sizes.dart';

part '../widget/profile_fields.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, this.userId});
  final String? userId;
  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ProfileMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (_, state) {
          final user = state.user;
          return Skeletonizer(
            enabled: state.isLoading,
            child: Column(
              children: [
                if (user != null)
                  _ProfileImageHeader(user, hasAppBar: !isOwnProfile),
                if (user != null)
                  _ProfileInfo(user, pollCount: state.polls?.length ?? 0),
                const Divider(),
              ],
            ),
          );
        },
      ),
    );
  }
}
