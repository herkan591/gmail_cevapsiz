import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:googleapis/websecurityscanner/v1.dart';

import 'google_servisler.dart';
import 'google_auth_client.dart';

class GoogleGirisIslemleri{

  GoogleSignInAccount googleUser;
  GoogleAuthCredential credential;
  GoogleSignInAuthentication googleAuth;

  Future<UserCredential> googleSignIn() async{

    try{

      final googleSignIn = GoogleSignIn.standard(scopes: [GmailApi.GmailReadonlyScope]);

      googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      googleAuth = await googleUser.authentication;

      // Create a new credential
      credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);


    }catch(e){

      debugPrint("Gmail girişi hata $e");


    }


  }

  void googleServisleriOlustur() async{

    final authHeaders = await googleUser.authHeaders;
    final client = GoogleAuthClient(authHeaders);
    GoogleServisler.setGoogleAuthClient(client);


  }


  Future<UserCredential> girisYap() async{

    UserCredential userCredential=await googleSignIn();

    if(googleUser!=null)googleServisleriOlustur();

    return userCredential;

  }





}