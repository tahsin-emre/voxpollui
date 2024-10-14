import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voxpollui/features/community/view/community_edit_view.dart';

mixin CommunityEditMixin on State<CommunityEditView> {
  final profileUrlNotifier = ValueNotifier<String?>(null);
  final backUrlNotifier = ValueNotifier<String?>(null);
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setCurrentData();
  }

  void changeProfileUrl(String? url) {
    profileUrlNotifier.value = url;
    setState(() {});
  }

  void changeBackUrl(String? url) {
    backUrlNotifier.value = url;
    setState(() {});
  }

  void setCurrentData() {
    profileUrlNotifier.value = widget.community.imageUrl;
    backUrlNotifier.value = widget.community.backgroundUrl;
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
    );

    context.pop(community);
  }
}
