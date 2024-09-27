import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/home/view/home_view.dart';
import 'package:voxpollui/product/initialize/models/user_model.dart';
import 'package:voxpollui/product/initialize/router/route_tree.dart';

mixin HomeMixin on State<HomeView> {
  late final _authCubit = context.read<AuthCubit>();
  late final UserModel user;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    user = _authCubit.state.user!;
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  void onAdd() {
    const PollCreateRoute().push<void>(context);
  }

  void onPageChanged(int index) {
    if (index == 0) {
      const FeedRoute().go(context);
    } else if (index == 1) {
      const DiscoverRoute().go(context);
    } else if (index == 2) {
      const CommunityRoute().go(context);
    } else if (index == 3) {
      const MyProfileRoute().go(context);
    }
  }
}
