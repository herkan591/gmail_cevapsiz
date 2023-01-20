class GmailMesajFiltreOlustur{

  static String birHafta(){
    return "older_than:7d";
  }
  static String ucAy(){

    return "older_than:3m";

  }
  static String birAy(){

    return "older_than:1m";

  }
  static String altiAy(){

    return "older_than:6m";
  }
  static String birYil(){

    return "older_than:1y";
  }


  static String gonderici(String gonderici){

    return "from:"+gonderici;

  }




  static String sorguBirlestir(List<String> sorgular){

    String sorgu="";

    for(int i=0;i<sorgular.length;i++){

      if(i==0){

        sorgu=sorgular.elementAt(i);

      }else{

        sorgu=sorgu+" "+sorgular.elementAt(i);

      }




    }

    return sorgu;


  }




}