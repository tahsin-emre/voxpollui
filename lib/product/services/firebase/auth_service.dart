import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:voxpollui/product/services/firebase/base_service.dart';

final class AuthService extends BaseService {
  factory AuthService() => _instance;
  AuthService._();
  static final AuthService _instance = AuthService._();
  static String? verificationId;

  Future<void> verifyPhone({
    required String phoneNumber,
    required StreamController<AuthStatus> authStream,
  }) async {
    try {
      await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 90),
        verificationCompleted: (credential) async {
          await auth.signInWithCredential(credential);
          authStream.sink.add(AuthStatus.onSuccess);
        },
        codeSent: (id, token) {
          verificationId = id;
          authStream.sink.add(AuthStatus.onCodeSent);
        },
        verificationFailed: (FirebaseException e) {
          authStream.sink.add(AuthStatus.onError);
        },
        codeAutoRetrievalTimeout: (timeout) {
          authStream.sink.add(AuthStatus.onError);
        },
      );
    } on Exception {
      authStream.sink.add(AuthStatus.onError);
    }
  }

  Future<String?> verifyOtp({
    required String code,
    required StreamController<AuthStatus> authStream,
  }) async {
    try {
      if (verificationId == null) {
        authStream.sink.add(AuthStatus.onError);
        return null;
      }
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: code,
      );
      final response = await auth.signInWithCredential(credential);
      return response.user?.uid;
    } on Exception {
      authStream.sink.add(AuthStatus.onError);
      return null;
    }
  }

  String? getCurrentUserId() {
    return auth.currentUser?.uid;
  }
}

enum AuthStatus {
  none,
  onSuccess,
  onCodeSent,
  onError,
}
