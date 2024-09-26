import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/community/community_model.dart';

final class CommunityState extends Equatable {
  const CommunityState({
    this.isLoading = false,
    this.communityList,
    this.myCommunityList,
  });

  CommunityState copyWith({
    bool? isLoading,
    List<CommunityModel>? communityList,
    List<CommunityModel>? myCommunityList,
  }) {
    return CommunityState(
      isLoading: isLoading ?? this.isLoading,
      communityList: communityList ?? this.communityList,
      myCommunityList: myCommunityList ?? this.myCommunityList,
    );
  }

  final bool isLoading;
  final List<CommunityModel>? communityList;
  final List<CommunityModel>? myCommunityList;

  @override
  List<Object?> get props => [
        isLoading,
        communityList,
        myCommunityList,
      ];
}
