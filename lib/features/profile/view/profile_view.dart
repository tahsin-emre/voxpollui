import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/authentication/cubit/auth_state.dart';
import 'package:voxpollui/features/profile/mixin/profile_mixin.dart';
import 'package:voxpollui/product/localization/locale_keys.g.dart';
import 'package:voxpollui/product/models/user_model.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> with ProfileMixin {
  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, UserModel?>(
      selector: (state) => state.user,
      builder: (_, user) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(LocaleKeys.profile_title.tr()),
              Text(user?.phone ?? ''),
              Text(user?.name ?? ''),
              Text(user?.surname ?? ''),
              ElevatedButton(
                onPressed: signOut,
                child: Text(LocaleKeys.auth_logout.tr()),
              ),
            ],
          ),
        );
      },
    );
  }
}
