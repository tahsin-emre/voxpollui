import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/community/view/community_edit_view.dart';
import 'package:voxpollui/product/initialize/models/category_model.dart';

mixin CommunityEditMixin on State<CommunityEditView> {
  late final _communityCubit = context.read<CommunityCubit>();
  final profileUrlNotifier = ValueNotifier<String?>(null);
  final backUrlNotifier = ValueNotifier<String?>(null);
  final categoryIdNotifier = ValueNotifier<String?>(null);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final descriptionController = TextEditingController();
  List<CategoryModel> categories = <CategoryModel>[];

  @override
  void initState() {
    super.initState();
    setCurrentData();
    getCategories();
  }

  void getCategories() {
    categories = _communityCubit.state.categoryList ?? [];
    setState(() {});
  }

  void changeProfileUrl(String? url) {
    profileUrlNotifier.value = url;
    setState(() {});
  }

  void changeBackUrl(String? url) {
    backUrlNotifier.value = url;
    setState(() {});
  }

  void changeCategory(String? id) {
    categoryIdNotifier.value = id;
    setState(() {});
  }

  void setCurrentData() {
    profileUrlNotifier.value = widget.community.imageUrl;
    backUrlNotifier.value = widget.community.backgroundUrl;

    categoryIdNotifier.value = widget.community.categoryId;
    nameController.text = widget.community.name ?? '';
    usernameController.text = widget.community.userName ?? '';
    descriptionController.text = widget.community.description ?? '';
  }

  void onSave() {
    final community = widget.community.copyWith(
      name: nameController.text,
      userName: usernameController.text,
      imageUrl: profileUrlNotifier.value,
      backgroundUrl: backUrlNotifier.value,
      description: descriptionController.text,
      categoryId: categoryIdNotifier.value,
    );
    context.read<CommunityCubit>().updateCommunity(community);
    context.pop(community);
  }
}
