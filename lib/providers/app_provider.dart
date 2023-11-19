import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';

class AppProvider extends ChangeNotifier {
  Client client = Client();
  late Account account;
  late bool _authenticated;
  bool get authenticated => _authenticated;

  AppProvider() {
    _authenticated = false;

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
      _authenticated = true;
      notifyListeners();
    })
    .catchError((error) {
      _authenticated = false;
      notifyListeners();
    });
  }

  signOff() {
    account.deleteSessions()
      .then((response) {
        _authenticated = false;
        notifyListeners();
      })
      .catchError((error) {
        _authenticated = false;
        notifyListeners();
      });
  }
}