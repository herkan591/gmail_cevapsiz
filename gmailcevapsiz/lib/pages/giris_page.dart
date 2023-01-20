import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:gmailcevapsiz/google_giris_islemleri.dart';
import 'package:gmailcevapsiz/google_servisler.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:googleapis/gmail/v1.dart';

import '../google_auth_client.dart';
import 'gmail_filtre_page.dart';


class GirisPage extends StatefulWidget {
  @override
  _GirisPageState createState() => _GirisPageState();
}

class _GirisPageState extends State<GirisPage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            Image.asset("assets/images/google.png"),
            SignInButton(
              Buttons.GoogleDark,

              text: "Sign in with Google",
              onPressed: () {

                googleGiris(context);

              },
            ),
          ],
        ),
      ),
    );
  }
}


googleGiris(BuildContext context) async{

  GoogleGirisIslemleri googleGiris=new GoogleGirisIslemleri();

  await googleGiris.girisYap();

  if(FirebaseAuth.instance.currentUser!=null){

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GmailFiltrePage()),
    );

  }


}


