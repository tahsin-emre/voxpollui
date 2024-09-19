import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/home/view/home_view.dart';
import 'package:voxpollui/product/models/user_model.dart';
import 'package:voxpollui/product/router/route_tree.dart';

mixin HomeMixin on State<HomeView> {
  late final _authCubit = context.read<AuthCubit>();
  late final UserModel user;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    user = _authCubit.state.user!;
  }

  void onCreatePoll() {
    const PollCreateRoute().push<void>(context);
  }

  void onPageChanged(int index) {
    if (index == 0) {
      const FeedRoute().go(context);
    } else if (index == 3) {
      const ProfileRoute().go(context);
    }
  }
}
