import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/community/cubit/community_cubit.dart';
import 'package:voxpollui/features/community/view/community_create_view.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';
import 'package:voxpollui/product/services/firebase/upload_service.dart';
import 'package:voxpollui/product/utils/extensions/context_ext.dart';

mixin CommunityCreateMixin on State<CommunityCreateView> {
  late final _communityCubit = context.read<CommunityCubit>();
  late final _authCubit = context.read<AuthCubit>();
  final _uploadService = UploadService();
  final formKey = GlobalKey<FormState>();
  final nameCont = TextEditingController();
  final descriptionCont = TextEditingController();
  final isPublicNotifier = ValueNotifier<bool>(true);
  final imageUrlNotifier = ValueNotifier<String?>(null);
  final categoryIdNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    _communityCubit.getCategories();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 25,
    );
    if (pickedFile == null) return;
    final imageUrl = await _uploadService.uploadImage(
      userId: _authCubit.state.user?.id ?? 'Unknown User',
      file: pickedFile,
      folder: UploadFolder.communityImage,
    );
    imageUrlNotifier.value = imageUrl;
  }

  Future<void> onSave() async {
    final community = CommunityModel(
      id: '',
      name: nameCont.text,
      userName: nameCont.text.replaceAll(' ', '').toLowerCase(),
      description: descriptionCont.text,
      isPublic: isPublicNotifier.value,
      imageUrl: imageUrlNotifier.value,
      categoryId: categoryIdNotifier.value,
      managerList: [_authCubit.state.user!.id],
      memberCount: 1,
    );
    final response = await _communityCubit.createCommunity(community);
    if (response) {
      notifyAndPop();
    } else {
      notifyFail();
    }
  }

  void notifyFail() {
    context.showSnackBar(LocaleKeys.base_somethingWentWrong.tr());
  }

  void notifyAndPop() {
    context
      ..showSnackBar(LocaleKeys.community_communityCreated.tr())
      ..pop();
    //Community Successfully Created Page will be added later.
  }
}
