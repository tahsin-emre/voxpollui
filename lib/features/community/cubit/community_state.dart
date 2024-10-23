import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/category_model.dart';
import 'package:voxpollui/product/initialize/models/owner_model/community_model.dart';

final class CommunityState extends Equatable {
  const CommunityState({
    this.isLoading = false,
    this.communityList,
    this.myCommunityList,
    this.categoryList,
  });

  CommunityState copyWith({
    bool? isLoading,
    List<CommunityModel>? communityList,
    List<CommunityModel>? myCommunityList,
    List<CategoryModel>? categoryList,
  }) {
    return CommunityState(
      isLoading: isLoading ?? this.isLoading,
      communityList: communityList ?? this.communityList,
      myCommunityList: myCommunityList ?? this.myCommunityList,
      categoryList: categoryList ?? this.categoryList,
    );
  }

  final bool isLoading;
  final List<CommunityModel>? communityList;
  final List<CommunityModel>? myCommunityList;
  final List<CategoryModel>? categoryList;

  @override
  List<Object?> get props => [
        isLoading,
        communityList,
        myCommunityList,
        categoryList,
      ];
}
