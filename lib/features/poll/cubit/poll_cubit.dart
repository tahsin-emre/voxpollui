import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voxpollui/features/poll/cubit/poll_state.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/services/firebase/poll_service.dart';

final class PollCubit extends Cubit<PollState> {
  PollCubit() : super(const PollState());
  final _pollService = PollService();

  Future<void> getPolls() async {
    emit(state.copyWith(isLoading: true));
    final polls = await _pollService.getPolls();
    final categoryList = await _pollService.getPollCategories();
    emit(
      state.copyWith(
        isLoading: false,
        pollList: polls,
        categoryList: categoryList,
      ),
    );
  }

  Future<String?> createPoll(PollModel poll) async {
    return _pollService.createPoll(poll);
  }

  Future<void> getCategories() async {
    emit(state.copyWith(isLoading: true));
    final categoryList = await _pollService.getPollCategories();
    emit(
      state.copyWith(categoryList: categoryList, isLoading: false),
    );
  }
}
