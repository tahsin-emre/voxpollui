import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/community/view/community_create_view.dart';

mixin CommunityCreateMixin on State<CommunityCreateView> {
  late final _communityCubit = context.read<CommunityCubit>();
  final formKey = GlobalKey<FormState>();
  final nameCont = TextEditingController();
  final isPublicNotifier = ValueNotifier<bool>(true);
  final imageUrlNotifier = ValueNotifier<String?>(null);
  final categoryIdNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _communityCubit.getCategories();
  }

  Future<void> pickImage() async {}

  Future<void> onSave() async {
    await _communityCubit.createCommunity();
  }
}
