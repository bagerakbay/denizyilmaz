String kokBul(String kelime) {
  //Patlayanlar
  //resmin re ediyorum edi avutmuyor av sana san yaklaştırıyor ya
  //http://tr.wikipedia.org/wiki/%C3%9Cns%C3%BCz_yumu%C5%9Famas%C4%B1
  //http://zembereknlp.blogspot.com.tr/2007/02/zemberek-nasl-alr-1szlk-ve-kk-aac.html
  
  kelime=lowerCase(kelime);
  String kok="--";
  //println(kokListesi[0]);
  if (isinArray(kelime, kokListesi)==true) return kelime;

  String yedek=kelime;
  while (yedek.length()>0) {
    yedek=yedek.substring(0, yedek.length()-1);
    if (isinArray(yedek, kokListesi)==true) return yedek;
  }

  return kok;
}

String[] kelimeHecele(String kelime) {
  //Verilen kelimeyi heceler

  //************************************** NEEDS DEVELOPMENT LATER
  //Özel durumlar 
  // rakam
  // noktalama işareti
  // boş string
  // Kısaltma 

  //farketmez krallık gibi üç sessiz durumlarında şu an için iki sessizi ilk heceye atıyor
  // Bu bir hata ama kök analizi lazım şu an için yapmıyorum

  //büyük küçük harf yok şu an sadece küçük yapıyor, önce ufaltıp sonra eski haline getirmek lazım.
  //************************************** NEEDS DEVELOPMENT LATER


  //Bir kelimedeki sesli harf sayısı o kelimedeki hece sayısıdır.
  int heceSayisi=countOf(kelime, sesliHarfler);

  //Bos ise hata dondur
  String[] bos= {
    "Boş veya sesli harf içermeyen kelime hecelenemiyor"
  };
  if (heceSayisi==0) return bos;

  String[] heceler= new String[heceSayisi];
  Boolean[] buyuklukDurumu = new Boolean[kelime.length()];
  int[] sesliPozisyon= new int[heceSayisi];

  //Once seslileri hecelere yerleştirelim
  int heceNo=0;
  int position=0;
  while (position<kelime.length ()) {
    if (countOf(""+kelime.charAt(position), sesliHarfler)>0) {
      heceler[heceNo]=""+kelime.charAt(position);
      sesliPozisyon[heceNo]=position;
      //println(position);
      heceNo++;
    } 
    position++;
  }


  //Şimdi sessizzleri hecelere yerleştirelim

  //ilk sesliden onceki sessizler ilk heceye
  if (sesliPozisyon[0]==1) heceler[0]=kelime.charAt(0)+heceler[0];
  if (sesliPozisyon[0]==2) heceler[0]=kelime.charAt(0)+""+kelime.charAt(1)+heceler[0];

  //son seslide sonraki sesssiz son heceye
  if (sesliPozisyon[heceSayisi-1]==kelime.length()-2) heceler[heceSayisi-1]=heceler[heceSayisi-1]+kelime.charAt(kelime.length()-1);
  if (sesliPozisyon[heceSayisi-1]==kelime.length()-3) heceler[heceSayisi-1]=heceler[heceSayisi-1]+kelime.charAt(kelime.length()-2)+kelime.charAt(kelime.length()-1);

  //aradakileri dagitalim 

  for (int i=1; i<heceSayisi; i++)
  {
    if (sesliPozisyon[i]-sesliPozisyon[i-1]==2) {
      heceler[i]=kelime.charAt(sesliPozisyon[i]-1)+heceler[i];
    }
    if (sesliPozisyon[i]-sesliPozisyon[i-1]==3) {
      heceler[i-1]=heceler[i-1]+kelime.charAt(sesliPozisyon[i]-2);
      heceler[i]=kelime.charAt(sesliPozisyon[i]-1)+heceler[i];
    }
    if (sesliPozisyon[i]-sesliPozisyon[i-1]==4) {
      //Kelime kökleri eklenince bursaı daha karmaşık olacak
      //************************************** NEEDS DEVELOPMENT LATER
      heceler[i-1]=heceler[i-1]+kelime.charAt(sesliPozisyon[i]-3)+""+kelime.charAt(sesliPozisyon[i]-2);
      heceler[i]=kelime.charAt(sesliPozisyon[i]-1)+heceler[i];
    }
    if (sesliPozisyon[i]-sesliPozisyon[i-1]==5) {
      //Kelime kökleri eklenince bursaı daha karmaşık olacak
      //************************************** NEEDS DEVELOPMENT LATER
      heceler[i-1]=heceler[i-1]+kelime.charAt(sesliPozisyon[i]-4)+""+kelime.charAt(sesliPozisyon[i]-3);
      heceler[i]=kelime.charAt(sesliPozisyon[i]-2)+""+kelime.charAt(sesliPozisyon[i]-1)+heceler[i];
    }
  }

  return heceler;
}

int countOf(String s, String c) {
  //İlk stringin içinde ikinci stringin içindeki karakterlerden kaç tane olduğunu bulur
  // Örnek
  // "nuriler" ,"aeıioöuü"
  // nuriler kelimesindeki sesli harf sayısı = 3;  
  int count=0;

  for (int m=0; m < s.length (); m++) {
    for (int n=0; n < c.length (); n++) {
      if (s.charAt(m)==c.charAt(n)) count++;
    }
  }
  return count;
}


boolean isinArray(char s, char[] a) {
  boolean value = false;
  for (int i=0; i<a.length; i++) {
    if (s==a[i]) value=true;
  }
  return value ;
}

boolean isinArray(String s, String[] a) {
  boolean value = false;
  for (int i=0; i<a.length; i++) {
    if (s.equals(a[i])==true) value=true;
  }
  return value ;
}

char upperCase(char s) {
  return Character.toUpperCase(s) ;
}

char lowerCase(char s) {
  return Character.toLowerCase(s) ;
}

String upperCase(String s) {
  return s.toUpperCase() ;
}

String lowerCase(String s) {
  return s.toLowerCase() ;
}

String upperCaseFirstChar(String s) {
  return (upperCase(s.charAt(0))+s.substring(1, s.length()));
}

String replace(String s, String t, String r) {

  int i = r.indexOf(s);
  r=r.substring(0, i)+t+r.substring(i+s.length(), r.length());

  return r;
}

String replace(String s, char t, String r) {

  int i = r.indexOf(s);
  r=r.substring(0, i)+t+r.substring(i+s.length(), r.length());

  return r;
}

String turkceKarakter(String s) {

  String trChar="ÇĞİÖŞÜçğıöşü ";
  String enChar="cgiosucgiosu_";
  for (int i=0; i<trChar.length (); i++) {
    String tr=trChar.substring(i, i+1)+"";
    String en=enChar.substring(i, i+1)+"";
    while (s.indexOf (tr)>-1) {
      s=replace(tr, en, s);
    }
  }
  return s;
}


