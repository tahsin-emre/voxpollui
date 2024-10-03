import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/category_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';

final class PollState extends Equatable {
  const PollState({
    this.isLoading = false,
    this.selectedPoll,
    this.feedList,
    this.categoryList,
  });

  PollState copyWith({
    bool? isLoading,
    PollModel? selectedPoll,
    List<PollModel>? feedList,
    List<CategoryModel>? categoryList,
  }) {
    return PollState(
      isLoading: isLoading ?? this.isLoading,
      selectedPoll: selectedPoll ?? this.selectedPoll,
      feedList: feedList ?? this.feedList,
      categoryList: categoryList ?? this.categoryList,
    );
  }

  final bool isLoading;
  final PollModel? selectedPoll;
  final List<PollModel>? feedList;
  final List<CategoryModel>? categoryList;

  @override
  List<Object?> get props => [
        isLoading,
        selectedPoll,
        feedList,
        categoryList,
      ];
}
