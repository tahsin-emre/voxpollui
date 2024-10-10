enum HttpEndpoints {
  votepoll,
  followuser,
  unfollowuser,
  joincommunity,
}

extension HttpEndpointsExtension on HttpEndpoints {
  Uri get toUri => Uri.parse('https://$name-6nz4bpqo3q-uc.a.run.app');
}
