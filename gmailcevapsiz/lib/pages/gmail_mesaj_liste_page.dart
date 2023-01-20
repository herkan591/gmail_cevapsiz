import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:gmailcevapsiz/gmail_mesaj_filtre_olustur.dart';
import 'package:gmailcevapsiz/google_servisler.dart';
import 'package:gmailcevapsiz/model/GmailMesajFiltreModel.dart';
import 'package:gmailcevapsiz/model/GmailMesajModel.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:intl/intl.dart';





class GmailMesajListePage extends StatefulWidget {
  GmailMesajListePage(this.filtre);

  GmailMesajFiltreModel filtre;

  @override
  _GmailMesajListePageState createState() => _GmailMesajListePageState(filtre);
}

class _GmailMesajListePageState extends State<GmailMesajListePage>{

  _GmailMesajListePageState(this.filtre);

  GmailMesajFiltreModel filtre;

  final aramaFieldController = new TextEditingController();


  final user = FirebaseAuth.instance.currentUser;
  final GmailApi gmailApi=GoogleServisler.getGmailApi();




  List<GmailMesajModel> sonucListe = [];
  List<GmailMesajModel> aramaListe = [];



  @override
  void initState(){

    super.initState();


      getCevapsizMailler();



    aramaFieldController.addListener((){
      aramaYap(aramaFieldController.text);
    });


  }

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 16.0);


  @override
  Widget build(BuildContext context) {


    return  MaterialApp(


        home: Scaffold(

          appBar: AppBar(
            title: Text("QFollowUp"),
          ),

            body: Column(

                children: [


                  Row(
                      children: <Widget>[

                        new Flexible(

                          child: TextField(

                            obscureText: false,
                            style: TextStyle(fontSize: 15),
                            controller: aramaFieldController,
                            decoration: InputDecoration(
                              hintText: "arama...",
                              hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.teal,
                                ),
                              ),
                            ),

                          ),


                        ),


                      ]
                  ),


                  Expanded(

                    child : ListView.builder(
                      itemCount: aramaListe == null ? 0 : aramaListe.length,
                      itemBuilder: (BuildContext context, int index) {

                        GmailMesajModel satir = aramaListe.elementAt(index);

                        return new GestureDetector(

                            child: Container(
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Card(
                                      child: Container(
                                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                                        child: Column(

                                          children: <Widget>[


                                            Row(
                                              children: <Widget>[

                                                Text(
                                                  satir.getTarih(),
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.blue
                                                  ),

                                                ),



                                              ],
                                            ),

                                            SizedBox(
                                              height:10 ,
                                            ),
                                            Row(
                                              children: <Widget>[

                                                Text(
                                                  satir.getAliciMail(),
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.orange,
                                                  ),

                                                ),



                                              ],
                                            ),
                                            SizedBox(
                                              height:10 ,
                                            ),
                                            Row(
                                              children: <Widget>[

                                                Expanded(
                                                  child: Text(
                                                    satir.getKonu(),

                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black,
                                                    ),

                                                  ),
                                                ),


                                              ],
                                            ),



                                          ],

                                        ),

                                      ),


                                    ),
                                  ],
                                ),
                              ),
                            )

                        );

                      },
                    ),

                  ),
                ]

            ),

          ),

    );


  }




  aramaYap(String aramadeger){

    print(aramadeger);
    aramaListe = [];

    for(int i = 0; i < sonucListe.length; i++){

      GmailMesajModel satir = sonucListe.elementAt(i);

      if(satir.getTarih().toString().toUpperCase().contains(aramadeger.toUpperCase()) || satir.getTarih().toString().toLowerCase().contains(aramadeger.toLowerCase())
          ||satir.getAliciMail().toUpperCase().contains(aramadeger.toUpperCase()) || satir.getAliciMail().toLowerCase().contains(aramadeger.toLowerCase())
          || satir.getKonu().toString().toLowerCase().contains(aramadeger.toLowerCase())|| satir.getKonu().toString().toLowerCase().contains(aramadeger.toLowerCase())
      ){

        aramaListe.add(satir);

      }

    }

    setState(() {

    });

  }


  sureFiltresi(){

    if(filtre.getFiltreId()=="bir_hafta")return GmailMesajFiltreOlustur.birHafta();
    if(filtre.getFiltreId()=="bir_ay")return GmailMesajFiltreOlustur.birAy();
    if(filtre.getFiltreId()=="uc_ay")return GmailMesajFiltreOlustur.ucAy();
    if(filtre.getFiltreId()=="alti_ay")return GmailMesajFiltreOlustur.altiAy();
    if(filtre.getFiltreId()=="bir_yil")return GmailMesajFiltreOlustur.birYil();
    

  }

  getCevapsizMailler() async {


    print("cevapsizlar");
    aramaListe=[];
    sonucListe=[];
    
    String cevapsizMaillerFiltre=GmailMesajFiltreOlustur.sorguBirlestir([GmailMesajFiltreOlustur.gonderici(user.email),
        sureFiltresi()]);


    print(cevapsizMaillerFiltre);

    var mesajThreadsResponse=await gmailApi.users.threads.list(user.email,q:cevapsizMaillerFiltre);

    print(mesajThreadsResponse.toJson());

    var mesajThreads=mesajThreadsResponse.threads;

    if(mesajThreads!=null){

      for(var x in mesajThreads){

        var mesajThread=await gmailApi.users.threads.get(user.email, x.id);

        if(mesajThread.messages.length==1){

          GmailMesajModel satir=new GmailMesajModel();


          for(var header in mesajThread.messages.elementAt(0).payload.headers){


            if(header.name=="To") satir.setAliciMail(header.value);

            if(header.name=="Date") satir.setTarih(header.value);

            if(header.name=="Subject") satir.setKonu(header.value);


          }


          setState(() {
            sonucListe.add(satir);
            aramaListe.add(satir);
          });



        }


      }


    }








  }





}
