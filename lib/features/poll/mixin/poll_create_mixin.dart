import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/poll/cubit/poll_cubit.dart';
import 'package:voxpollui/features/poll/view/poll_create_view.dart';
import 'package:voxpollui/product/initialize/localization/locale_keys.g.dart';
import 'package:voxpollui/product/initialize/models/poll/option_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/services/firebase/upload_service.dart';
import 'package:voxpollui/product/utils/extensions/context_ext.dart';

mixin PollCreateMixin on State<PollCreateView> {
  late final _pollCubit = context.read<PollCubit>();
  late final _authCubit = context.read<AuthCubit>();
  final _uploadService = UploadService();
  final formKey = GlobalKey<FormState>();
  final titleCont = TextEditingController();
  final dayCont = TextEditingController();
  final hourCont = TextEditingController();
  final minuteCont = TextEditingController();
  final imageUrlNotifier = ValueNotifier<String?>(null);
  final categoryIdNotifier = ValueNotifier<String?>(null);
  final isPublicNotifier = ValueNotifier<bool>(true);
  final optionsNotifier = ValueNotifier<List<OptionModel>>([]);

  @override
  void initState() {
    super.initState();
    optionsNotifier.value = [
      const OptionModel(id: '0', optionText: '', voteCount: 0),
      const OptionModel(id: '1', optionText: '', voteCount: 0),
    ];
    _pollCubit.getCategories();
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
    final endTime = DateTime.now().add(
      Duration(
        days: int.tryParse(dayCont.text) ?? 0,
        hours: int.tryParse(hourCont.text) ?? 0,
        minutes: int.tryParse(minuteCont.text) ?? 0,
      ),
    );
    final poll = PollModel(
      id: '',
      ownerId: widget.ownerId,
      title: titleCont.text,
      createdAt: DateTime.now(),
      endAt: endTime,
      imageUrl: imageUrlNotifier.value,
      categoryId: categoryIdNotifier.value,
      isPublic: isPublicNotifier.value,
      options: optionsNotifier.value,
    );

    final response = await _pollCubit.createPoll(poll);
    if (response == null) {
      notifyFail();
      return;
    }
    notifyAndPop();
  }

  void notifyFail() {
    context
      ..showSnackBar(LocaleKeys.base_somethingWentWrong.tr())
      ..pop();
  }

  void notifyAndPop() {
    context
      ..showSnackBar(LocaleKeys.poll_pollPublished.tr())
      ..pop();
    //Go to the poll detail page added later.
  }
}
