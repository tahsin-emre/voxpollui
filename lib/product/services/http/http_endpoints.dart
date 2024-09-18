enum HttpEndpoints {
  votepoll,
  followuser,
  unfollowuser,
}

extension HttpEndpointsExtension on HttpEndpoints {
  Uri get toUri => Uri.parse('https://$name-6nz4bpqo3q-uc.a.run.app');
}
