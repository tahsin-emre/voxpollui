import 'package:equatable/equatable.dart';
import 'package:voxpollui/product/initialize/models/community/community_model.dart';

final class CommunityState extends Equatable {
  const CommunityState({this.isLoading = false, this.communityList});

  CommunityState copyWith({
    List<CommunityModel>? communityList,
    bool? isLoading,
  }) {
    return CommunityState(
      communityList: communityList ?? this.communityList,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  final bool isLoading;
  final List<CommunityModel>? communityList;

  @override
  List<Object?> get props => [communityList, isLoading];
}
