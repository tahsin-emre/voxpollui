import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/poll/community_category_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';

final class PollState extends Equatable {
  const PollState({
    this.isLoading = false,
    this.pollList,
    this.categoryList,
  });

  PollState copyWith({
    bool? isLoading,
    List<PollModel>? pollList,
    List<PollCategoryModel>? categoryList,
  }) {
    return PollState(
      isLoading: isLoading ?? this.isLoading,
      pollList: pollList ?? this.pollList,
      categoryList: categoryList ?? this.categoryList,
    );
  }

  final bool isLoading;
  final List<PollModel>? pollList;
  final List<PollCategoryModel>? categoryList;

  @override
  List<Object?> get props => [pollList, categoryList, isLoading];
}
