import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/community/view/community_create_view.dart';

mixin CommunityCreateMixin on State<CommunityCreateView> {
  late final _communityCubit = context.read<CommunityCubit>();
  final formKey = GlobalKey<FormState>();
  final nameCont = TextEditingController();
  final isPublic = ValueNotifier<bool>(true);
  final imageUrl = ValueNotifier<String?>(null);

  Future<void> onSave() async {}
}
