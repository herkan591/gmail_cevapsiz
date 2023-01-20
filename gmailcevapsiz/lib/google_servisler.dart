import 'package:googleapis/gmail/v1.dart';

import 'google_auth_client.dart';

class GoogleServisler{

  static GmailApi _gmailApi;

  static GoogleAuthClient _client;

  static setGoogleAuthClient(GoogleAuthClient client){

    _client=client;

  }

  static GmailApi getGmailApi(){


    if(_gmailApi == null){

      return new GmailApi(_client);

    }

    return _gmailApi;

  }



}