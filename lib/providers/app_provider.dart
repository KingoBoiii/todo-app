import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  Client client = Client();
  late Account account;
  late bool _isLoggedIn;
  bool get isLoggedIn => _isLoggedIn;

  AppProvider() {
    client
      .setEndpoint('https://cloud.appwrite.io/v1')
      .setProject('65592a4d4664cb4bdf01');
      //.setSelfSigned(status: true); // For self signed certificates, only use for development

    account = Account(client);
  }

  signInGoogle() {
    account.createOAuth2Session(
      provider: 'google'
    ).then((response) {
      _isLoggedIn = true;
      notifyListeners();
    })
    .catchError((error) {
      _isLoggedIn = false;
      notifyListeners();
    });
  }
}