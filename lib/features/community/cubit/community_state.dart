import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/category_model.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';

final class CommunityState extends Equatable {
  const CommunityState({
    this.isLoading = false,
    this.communityList,
    this.myCommunityList,
    this.categoryList,
    this.selectedCommunity,
    this.selectedNewPolls,
    this.selectedOldPolls,
  });

  CommunityState copyWith({
    bool? isLoading,
    List<CommunityModel>? communityList,
    List<CommunityModel>? myCommunityList,
    List<CategoryModel>? categoryList,
    CommunityModel? selectedCommunity,
    List<PollModel>? selectedNewPolls,
    List<PollModel>? selectedOldPolls,
  }) {
    return CommunityState(
      isLoading: isLoading ?? this.isLoading,
      communityList: communityList ?? this.communityList,
      myCommunityList: myCommunityList ?? this.myCommunityList,
      categoryList: categoryList ?? this.categoryList,
      selectedCommunity: selectedCommunity ?? this.selectedCommunity,
      selectedNewPolls: selectedNewPolls ?? this.selectedNewPolls,
      selectedOldPolls: selectedOldPolls ?? this.selectedOldPolls,
    );
  }

  final bool isLoading;
  final List<CommunityModel>? communityList;
  final List<CommunityModel>? myCommunityList;
  final List<CategoryModel>? categoryList;
  final CommunityModel? selectedCommunity;
  final List<PollModel>? selectedNewPolls;
  final List<PollModel>? selectedOldPolls;

  @override
  List<Object?> get props => [
        isLoading,
        communityList,
        myCommunityList,
        categoryList,
        selectedCommunity,
        selectedNewPolls,
        selectedOldPolls,
      ];
}
