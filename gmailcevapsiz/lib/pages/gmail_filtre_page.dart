import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmailcevapsiz/google_servisler.dart';
import 'package:gmailcevapsiz/model/GmailMesajFiltreModel.dart';
import 'package:googleapis/gmail/v1.dart';

import 'gmail_mesaj_liste_page.dart';



class GmailFiltrePage extends StatefulWidget {

  GmailFiltrePage();

  @override
  _GmailFiltrePageState createState() => _GmailFiltrePageState();
}

class _GmailFiltrePageState extends State<GmailFiltrePage> {


  final user = FirebaseAuth.instance.currentUser;

  final GmailApi gmailApi=GoogleServisler.getGmailApi();

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QFollowUp"),
      ),
      body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Text(
                    "Tarih filtresi seçiniz.",
                    style: TextStyle(
                      fontSize:20,
                      color: Colors.black
                    ),
                  ),
                  SizedBox(height: 50,),
                  RaisedButton(
                    child: Text("1 Hafta",style: TextStyle(color: Colors.white),),
                    color: Colors.lightBlue,

                    onPressed: (){
                      GmailMesajFiltreModel filtre=new GmailMesajFiltreModel();

                      filtre.setFiltreId("bir_hafta");
                      filtre.setFiltreAdi("1 Hafta");

                      mesajlaraGit(context,filtre);
                    },
                  ),
                  SizedBox(height: 15,),
                  RaisedButton(
                    child: Text("1 Ay",style: TextStyle(color: Colors.white),),
                    color: Colors.lightBlue,
                    onPressed: (){


                      GmailMesajFiltreModel filtre=new GmailMesajFiltreModel();

                      filtre.setFiltreId("bir_ay");
                      filtre.setFiltreAdi("1 Ay");

                      mesajlaraGit(context,filtre);
                    },
                  ),
                  SizedBox(height: 15,),
                  RaisedButton(
                    child: Text("3 Ay",style: TextStyle(color: Colors.white),),
                    color: Colors.lightBlue,
                    onPressed: (){
                      GmailMesajFiltreModel filtre=new GmailMesajFiltreModel();

                      filtre.setFiltreId("uc_ay");
                      filtre.setFiltreAdi("3 Ay");

                      mesajlaraGit(context,filtre);
                    },
                  ),
                  SizedBox(height: 15,),
                  RaisedButton(
                    child: Text("6 Ay",style: TextStyle(color: Colors.white),),
                    color: Colors.lightBlue,
                    onPressed: (){

                      GmailMesajFiltreModel filtre=new GmailMesajFiltreModel();

                      filtre.setFiltreId("alti_ay");
                      filtre.setFiltreAdi("6 Ay");

                      mesajlaraGit(context,filtre);

                    },
                  ),
                  SizedBox(height: 15,),
                  RaisedButton(
                    child: Text("1 Yıl",style: TextStyle(color: Colors.white),),
                    color: Colors.lightBlue,
                    onPressed: (){

                      GmailMesajFiltreModel filtre=new GmailMesajFiltreModel();

                      filtre.setFiltreId("bir_yil");
                      filtre.setFiltreAdi("1 Yıl");

                      mesajlaraGit(context,filtre);

                    },
                  ),
                ],
              ),
          ),
        ),
      ),

    );
  }




  void mesajlaraGit(BuildContext context,GmailMesajFiltreModel filtre) async{

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GmailMesajListePage(filtre)),
    );

  }











}
