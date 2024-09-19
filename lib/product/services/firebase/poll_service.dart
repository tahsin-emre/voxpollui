import 'package:voxpollui/product/models/poll/poll_model.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';
import 'package:voxpollui/product/services/http/http_endpoints.dart';
import 'package:voxpollui/product/services/http/http_service.dart';

final class PollService extends BaseService {
  factory PollService() => _instance;
  PollService._();
  static final PollService _instance = PollService._();

  ///Get Polls For Feed View
  Future<List<PollModel>> getPolls() async {
    ///Implement getPolls via Cloud Functions
    final polls = await db.collection('polls').get();
    return polls.docs.map(PollModel.fromQDS).toList();
  }

  Future<PollModel?> getPoll(String pollId) async {
    final poll = await db.collection('polls').doc(pollId).get();
    return PollModel.fromDS(poll);
  }

  ///Create Poll
  Future<String?> createPoll(PollModel poll) async {
    try {
      final pollId = await db.collection('polls').add(poll.toMap());
      return pollId.id;
    } catch (e) {
      return null;
    }
  }

  ///Check If User Voted
  Future<bool> checkIfUserVoted({
    required String pollId,
    required String userId,
  }) async {
    final vote = await db
        .collection('polls')
        .doc(pollId)
        .collection('votes')
        .doc()
        .get();
    return vote.exists;
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