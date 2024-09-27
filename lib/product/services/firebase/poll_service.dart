import 'package:voxpollui/product/initialize/models/poll/community_category_model.dart';
import 'package:voxpollui/product/initialize/models/poll/poll_model.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';
import 'package:voxpollui/product/services/http/http_endpoints.dart';
import 'package:voxpollui/product/services/http/http_service.dart';

final class PollService extends BaseService {
  factory PollService() => _instance;
  PollService._();
  static final PollService _instance = PollService._();

  ///Get Polls For Feed View
  Future<List<PollModel>> getFeedPolls() async {
    ///Implement getPolls via Cloud Functions
    final polls = await db.collection(FireStoreCollections.polls.name).get();
    return polls.docs.map((e) => PollModel.fromJson(e.data(), e.id)).toList();
  }

  ///Get Poll Details
  Future<PollModel?> getPoll(String pollId) async {
    final response =
        await db.collection(FireStoreCollections.polls.name).doc(pollId).get();
    if (!response.exists) return null;
    return PollModel.fromJson(response.data()!, response.id);
  }

  ///Get Polls By User
  Future<List<PollModel>> getPollsByUser(String userId) async {
    final polls = await db
        .collection(FireStoreCollections.polls.name)
        .where('ownerId', isEqualTo: userId)
        .get();
    return polls.docs.map((e) => PollModel.fromJson(e.data(), e.id)).toList();
  }

  ///Create Poll
  Future<String?> createPoll(PollModel poll) async {
    try {
      final pollId = await db
          .collection(FireStoreCollections.polls.name)
          .add(poll.toMap());
      return pollId.id;
    } catch (e) {
      return null;
    }
  }

  ///Get Poll Categories
  Future<List<PollCategoryModel>> getPollCategories() async {
    final response =
        await db.collection(FireStoreCollections.pollCategories.name).get();
    final categoryList = response.docs.map(PollCategoryModel.fromQDS).toList();
    return categoryList;
  }

  ///Check If User Voted
  Future<String?> checkIfUserVoted({
    required String pollId,
    required String userId,
  }) async {
    final vote = await db
        .collection(FireStoreCollections.polls.name)
        .doc(pollId)
        .collection(FireStoreCollections.votes.name)
        .doc(userId)
        .get();
    return vote.data()?['optionId'] as String?;
  }

  ///Vote Poll
  Future<bool> votePoll(String pollId, String userId, String optionId) async {
    final response = await HttpService().sendRequest(
      HttpEndpoints.votepoll,
      {'pollId': pollId, 'userId': userId, 'optionId': optionId},
    );
    if (response.body == 'true') return true;
    return false;
  }
}
