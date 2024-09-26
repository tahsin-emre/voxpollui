import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/authentication/cubit/auth_cubit.dart';
import 'package:voxpollui/features/poll/cubit/poll_cubit.dart';
import 'package:voxpollui/features/poll/view/poll_create_view.dart';
import 'package:voxpollui/product/services/firebase/upload_service.dart';

mixin PollCreateMixin on State<PollCreateView> {
  late final _pollCubit = context.read<PollCubit>();
  late final _authCubit = context.read<AuthCubit>();
  final _uploadService = UploadService();
  final formKey = GlobalKey<FormState>();

  Future<void> onSave() async {}
}
