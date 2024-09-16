import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/poll/cubit/poll_state.dart';
import 'package:voxpollui/product/services/firebase/poll_service.dart';

final class PollCubit extends Cubit<PollState> {
  PollCubit() : super(const PollState());
  final _pollService = PollService();
  Future<void> getPolls() async {
    final polls = await _pollService.getPolls();
    emit(state.copyWith(pollList: polls));
  }
}
