String biSiirYazsanaDeniz() {
  ///Aynı dize tekrarını kontrol etmeli

  dizeSayisi=8; //random(1,12)  4  8  12 // .01 .15 .82 .02 
  float rnd=random(100);
  if (rnd<1) dizeSayisi=int(random(2, 13));
  else if (rnd<16) dizeSayisi=4;
  else if (rnd<18) dizeSayisi=12;

  beyit=4; // random(1,12) 2 4 6 // .01 .20 .75 .04 
  rnd=random(100);
  if (rnd<1) beyit=int(random(2, 13));
  else if (rnd<21) beyit=2;
  else if (rnd<25) beyit=6;


  heceSayisi=0;
  kaf=2;//0 1 2 3 // .15 .25 .57 .03
  rnd=random(100);
  if (rnd<15) kaf=0;
  else if (rnd<40) kaf=2;
  else if (rnd<43) kaf=6;

  int kelimeSayisi=3;
  rnd=random(100);
  if (rnd<.3) kelimeSayisi=1;
  else if (rnd<20) kelimeSayisi=2;


  //bunu yaptım yoksa A4'e zor sığıyor.
  if (dizeSayisi==10) beyit=5;
  if (dizeSayisi==11) beyit=11;
  if (dizeSayisi==12) beyit=6;

  //  dizeSayisi=12;
  //  kelimeSayisi=3; 
  //  beyit=2;

  loadBigVariables();


  println("---------------------------------");

  boolean check=false;
  while (!check) { 
    heceSayisi=0;   
    heceUzunluklariList.clear();
    siir.clear();
    //heceUzunluklari=null;

    for (int m=0; m<kelimeSayisi; m++) {

      int h=1+int(random(4));
      if (m==kelimeSayisi) h++;
      heceSayisi+=h;
      heceUzunluklariList.append(h);
      //println(m+" "+h);
    }
    heceUzunluklari = heceUzunluklariList.array();


    siirUret();
    String siirFile[] = new String[siir.size()+1];

    boolean dupCheck=true;
    //  println("Şiir Boyutu : "+siir.size ());
    for (int i=0; i<siir.size ()-1; i++) {
      for (int j=i+1; j<siir.size (); j++) {
        if (siir.get(i).equals(siir.get(j))==true) {
          dupCheck=false;
          print(".");
        }
      }
    }

    if (siirFile.length>=dizeSayisi && dupCheck) check=true;

    //else print(siirFile.length);
  }
  println("");
  String ret=siiriYaz();
  return ret;
}



boolean checkDize() {
  return true;
}

String dizeyiDuzenle(String s) {
  //println(s);
  String k[]=splitTokens(s, " \t");
  String s2="";
  for (int i=0; i<heceUzunluklari.length-1; i++) {
    s2+=k[i]+" ";
  }
  s2+=k[heceUzunluklari.length-1];
  //println("s2 :"+s2);
  return s2;
}

boolean checkDize(String s) {
  Boolean ret=true;
  //hece
  String k[]=splitTokens(s, " \t");

  for (int i=0; i<heceUzunluklari.length; i++) {
    if (kelimeHecele(k[i]).length!=heceUzunluklari[i]) ret=false;
  }

  if (k[heceUzunluklari.length-1].length()>2) {
    if (siir.size()==1 || siir.size()==3 || siir.size()==4 || siir.size()==5 || siir.size()==7) { 
      //println("1 "+k[2].substring(k[2].length()-kaf));
      //println("2 "+kafiye1);
      if (k[heceUzunluklari.length-1].substring(k[heceUzunluklari.length-1].length()-kaf).equals(kafiye1)==false) ret=false;
      if (siir.size()==2 || siir.size()==6 ) 
        if (k[heceUzunluklari.length-1].substring(k[heceUzunluklari.length-1].length()-kaf).equals(kafiye2)==false) ret=false;
    }
  } else
    ret=false;



  return ret;
}

String siiriYaz() {
  //title eklemek lazım bi de iki enter sonuna
  // imza eklemek lazım
  StringList siirTemp=new StringList();

  String baslik="";
  int b=int(random(siir.size ()));
  String[] baslikKelimeleri = split(siir.get(b), ' ');
  int x=int(random(baslikKelimeleri.length));
  if (x<baslikKelimeleri.length-1)
    baslik=baslikKelimeleri[x]+" "+baslikKelimeleri[x+1];
  else
    baslik=baslikKelimeleri[x];
  baslik=upperCase(baslik);
  siirTemp.append(baslik);
  siirTemp.append("");


  //  for (int i=0; i<siir.size (); i++) { 





  int k=0;
  for (int i=0; i<siir.size (); i++) {
    if (i%beyit==0 && i>0 && i<dizeSayisi-1) {
      //println("");
      siirTemp.append("");
    }
    siirTemp.append(siir.get(i));
    k++;
    //println(siir.get(i));
  }

  siirTemp.append("");
  k=siir.get(siir.size()-1).length();

  String s="";
  for (int i=0; i<k-11; i++) {
    s=s+" ";
  }
  s=s+"DENİZ YILMAZ";
  siirTemp.append(s);

  String ret="";
  for (int i=0; i<siirTemp.size (); i++) {
    println(siirTemp.get(i));
    ret=ret+siirTemp.get(i)+char(10);
  }

  String[] siirFile = siirTemp.array();
  String t=""+hour()+"-"+minute()+"-"+second()+"-"+millis();
  String fileName="siir-"+t+".txt";
  saveStrings((fileName), siirFile);
  siir.clear();

  return ret;
}

void turkceKarakterDuzelt() {
  for (int i=0; i<siir.size (); i++) {
    String dize=siir.get(i);
    for (int m=0; m<dize.length (); m++) {
      //GUSIOC
      if (dize.charAt(m)=='G') dize=dize.substring(0, m)+"ğ"+dize.substring(m+1);
      if (dize.charAt(m)=='U') dize=dize.substring(0, m)+"ü"+dize.substring(m+1);
      if (dize.charAt(m)=='S') dize=dize.substring(0, m)+"s"+dize.substring(m+1);
      if (dize.charAt(m)=='I') dize=dize.substring(0, m)+"ı"+dize.substring(m+1);
      if (dize.charAt(m)=='O') dize=dize.substring(0, m)+"ö"+dize.substring(m+1);
      if (dize.charAt(m)=='C') dize=dize.substring(0, m)+"ç"+dize.substring(m+1);
      dize=Character.toUpperCase(dize.charAt(0))+dize.substring(1);
    }    
    siir.set(i, dize);
  }
}

void siirUret() {
  int k=0;
  int limit=30000;
  //println("siir.size"+siir.size ());
  //println("dize sayisi"+dizeSayisi);
  while (siir.size ()<dizeSayisi && k<=limit) {
    k++;
    if (siir.size()==1) {
      kafiye1=siir.get(0).substring(siir.get(0).length()-kaf);
      //println(kafiye1);
    }
    if (siir.size()==3) kafiye2=siir.get(2).substring(siir.get(2).length()-kaf);
    String dize=kokListesi[int(random(kokListesi.length))];
    dize=dizeyiDuzenle(dize);
    //if (k==1) println(dize);
    if (checkDize(dize)) siir.append(dize);
    //if (k%1000==0) println(k);
  }
  //println("k :"+k);
  turkceKarakterDuzelt();
  //  for (int i=0; i<dizeSayisi; i++) {
  //    println("i : "+i);
  //    //String dize=vezneUygunKelimeBul(heceUzunluklari[0]);
  //    String dize=vezneUygunAkrostijBul(heceUzunluklari[0], akrostij.charAt(i));
  //    //println("dize : "+dize);
  // 
  //    if ((i%4)==2)
  //      dize=dize+" "+vezneUygunKelimeBul(heceUzunluklari[heceUzunluklari.length-1], kafiyelik1);
  //    else
  //      dize=dize+" "+vezneUygunKelimeBul(heceUzunluklari[heceUzunluklari.length-1], kafiyelik2);
  //    siir.append(dize);
  //    //println("final dize : "+dize);
  //  }
  //
  //   for (int m=1; m<heceUzunluklari.length-1; m++) {
  //      //println("m : "+m);
  //      dize=dize+" "+vezneUygunKelimeBul(heceUzunluklari[m]);
  //      //println("dize : "+dize);
  //    }
  // String dize=vezneUygunKelimeBul(heceUzunluklari[heceUzunluklari.length-1], kafiyelik);
  // println(sifir+" - "+kelimeVezniOlc(sifir)+" - "+vezinAdi(kelimeVezniOlc(sifir)));
  // siir.set(0, sifir );


  // String s=vezneUygunKelimeBul(heceUzunluklari[0]);
  // for (int i=1; i<heceUzunluklari.length-1; i++) {
  //   s=s+" "+vezneUygunKelimeBul(heceUzunluklari[i]);
  //   println(i);
  // }

  //  siir.set(0, s+" "+sifir );
}

String kafiyeBelirle(int uzunluk, String[] list, int minimumCount, int kafiyeNo, int kafiyeHeceSayisi) {
  String kafiye="";
  StringList kafiyeListesi=new StringList();
  while (kafiye.length ()==0) {
    int n=int(random(list.length));
    if (list[n].length()>=uzunluk) kafiye=list[n].substring(list[n].length()-uzunluk);
    for (int i=0; i<list.length; i++) {
      if (list[i].length()>=uzunluk) 
        if (list[i].substring(list[i].length()-uzunluk).equals(kafiye)==true)
          if (kelimeHecele(list[i]).length==kafiyeHeceSayisi) 
            kafiyeListesi.append(list[i]);
    }
    if (kafiyeListesi.size()<minimumCount) {
      kafiye="";
      kafiyeListesi.clear();
    }
  }

  println(kafiye+" "+kafiyeListesi.size());
  if (kafiyeNo==1) kafiyelik1=kafiyeListesi;
  if (kafiyeNo==2) kafiyelik2=kafiyeListesi;
  return kafiye;
}



int kelimeVezniOlc(String kelime) {
  /*
fa'ûlün (fe'ûlün) (._ _) 1011
   fâ'ilün, fâ'ilât (_._) 1101
   
   mefâ'ilün (._._) 10101
   fâ'ilâtün (_._ _)11011
   mef’ûlâtü (_ _ _.)11110
   müstef'ilün (_ _._)11101
   
   müfâ'aletün (._.._)101001
   mütefâ'ilün (.._._)100101
   */
  int vezin=1;
  String[] heceler=kelimeHecele(kelime);

  for (int i= 0; i<heceler.length; i++) {
    //println(i);
    if (heceKapaliMi(heceler[i]))
      vezin=10*vezin+1;
    else
      vezin=vezin*10+0;
  }
  //  vezin=vezin+int(pow(10, heceler.length));
  //println("vezin = "+vezin);
  return vezin;
}

String vezinAdi(int n) {
  String vezin="kuraldışı";
  if (n==11) vezin="fa'";
  if (n==101) vezin="fe'ûl";
  if (n==111) vezin="fa'lün";


  if (n==1011) vezin="fe'ûlün";
  if (n==1101) vezin="fâ'ilün";
  if (n==10101) vezin="mefâ'ilün";
  if (n==11011) vezin="fâ'ilâtün";
  if (n==11110) vezin="mef’ûlâtü";
  if (n==11101) vezin="müstef'ilün";
  if (n==101001) vezin="müfâ'aletün";
  if (n==100101) vezin="mütefâ'ilün";
  //println("vezin = "+vezin);
  return vezin;
}

boolean heceKapaliMi(String hece) {
  boolean kapali=true;
  if (hece.length()==1) kapali=false;
  if ((hece.length()==2) && (countOf(sessizHarfler, hece.substring(1, 2))==0)) kapali=false;
  return kapali;
}


String vezneUygunKelimeBul() {
  String s="kuraldışı";
  String kelime="";
  while (s.equals ("kuraldışı")==true) {
    kelime=kokListesi[(int(random(kokListesi.length)))];
    int n=kelimeVezniOlc(kelime);
    s=vezinAdi(n);
    //println(kelime+" - "+n+" - "+s);
  }
  return kelime;
}

String vezneUygunKelimeBul(StringList list) {
  String s="kuraldışı";
  String kelime="";
  while (s.equals ("kuraldışı")==true) {
    kelime=list.get((int(random(list.size()))));
    int n=kelimeVezniOlc(kelime);
    s=vezinAdi(n);
    //println(kelime+" - "+n+" - "+s);
  }
  return kelime;
}



String vezneUygunAkrostijBul(int heceUzunlugu, char c) {
  String s="kuraldışı";
  String kelime="";
  while (s.equals ("kuraldışı")==true) {
    kelime=kokListesi[(int(random(kokListesi.length)))];
    int n=kelimeVezniOlc(kelime);
    if ( (kelimeHecele(kelime).length==heceUzunlugu) && (kelime.charAt(0)==c))
      s="k"+vezinAdi(n);
    //println(kelime+" - "+n+" - "+s);
  }
  return kelime;
}
String vezneUygunKelimeBul(int heceUzunlugu) {
  String s="kuraldışı";
  String kelime="";
  while (s.equals ("kuraldışı")==true) {
    kelime=kokListesi[(int(random(kokListesi.length)))];
    int n=kelimeVezniOlc(kelime);
    if (kelimeHecele(kelime).length==heceUzunlugu)
      s=vezinAdi(n);
    //println(kelime+" - "+n+" - "+s);
  }
  return kelime;
}

String vezneUygunKelimeBul(int heceUzunlugu, StringList list) {
  String s="kuraldışı";
  String kelime="";
  while (s.equals ("kuraldışı")==true) {
    kelime=list.get((int(random(list.size()))));
    int n=kelimeVezniOlc(kelime);
    if (kelimeHecele(kelime).length==heceUzunlugu)
      s=vezinAdi(n);
    //println(kelime+" - "+n+" - "+s);
  }
  return kelime;
}
void saveFile(String fileName, String[] lines) {
  try {
    BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileName), "ISO-8859-9"));
    try {
      for (int i=0; i<lines.length; i++)
      {
        out.write(lines[i]);
        if (i<lines.length-1) out.write('\n');
      }
      out.close();
    } 
    catch(IOException uee) {
    }
  } 
  catch(UnsupportedEncodingException uee) {
    uee.printStackTrace();
  }
  catch(FileNotFoundException uee) {
    uee.printStackTrace();
  }
}

String[] loadFile(String fileName) {

  InputStream input = createInput(fileName);
  BufferedReader reader = null;
  try
  {
    reader = new BufferedReader(new InputStreamReader(input, "ISO-8859-9")); // loadStrings() does that with "UTF-8"
  }
  catch (IOException e)
  {
    e.printStackTrace();
    exit();
  }
  String[] lines = loadStrings(reader);
  return lines;
}