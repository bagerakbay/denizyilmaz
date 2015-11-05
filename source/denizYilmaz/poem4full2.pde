import processing.serial.*;

boolean linuxMode=true;

void setup() {

  intArduino();
  intGPIO();


  //  poem.text = createPoem();
  //  poem.fileName=setPoemFileName(poem.text);
  //  savePoemTXT(poem.fileName, poem.text);
  //  poem.gCode= poemToGCode(poem.text);
  //  savePoemGcode(poem.fileName, poem.gCode);
  //  writePoem(poem.gCode);
  //  autoHome();
}

void draw() {
  println("STATE : "+ state);

  if (state==finishedWriting) {

    autoHome();


    state=creatingPoem;
  }

  if (state==creatingPoem) {
    poem.text = createPoem();    
    poem.fileName=setPoemFileName(poem.text);
    savePoemTXT(poem.fileName, poem.text);
    poem.gCode= poemToGCode(poem.text);
    poem.calculateSize();
    savePoemGcode(poem.fileName, poem.gCode); 
    
    state=waitingForInput;
  }

  if (state==waitingForInput) {

    if (linuxMode) {
      String[] s=loadStrings("/sys/class/gpio/gpio3/value");
      //println(s[0]);
      if (s[0].charAt(0)=='1') {
        getReadyToWrite(poem.w, poem.h);
        state=writingPoem;
        writePoem();
      }
    } 

    if (!linuxMode) {
      if (keyPressed==true) {
        getReadyToWrite(poem.w, poem.h);
        state=writingPoem;
        writePoem();
      }
    }
  }


  if (state==writingPoem) {
  }
}



class Poem { 
  String text, fileName;
  String[] gCode ;
  int w, h;
  Poem () {  
    text="";
    fileName="";
    w=0;
    h=0;
  }

  void calculateSize() {
    String s=gCode[gCode.length-2];
    int iw=s.indexOf("X");
    s=s.substring(iw+1, s.length());
    int is=s.indexOf(".");
    s=s.substring(0, is);
    println("x: "+s);
    w=parseInt(s);

    s=gCode[gCode.length-2];
    int ih=s.indexOf("Y");
    s=s.substring(ih+1, s.length());
    is=s.indexOf(".");
    s=s.substring(0, is);
    println("y: "+s);
    h=parseInt(s);
    //x320 Y-390
    //320-(w/2) -390+(y/2)
    w=320-(w/2);
    h=-390-(h/2); 

    println("x: "+w+"   --   y: "+h);
  }
}

String createPoem() {

  String s="BOŞ BEKLEYİŞ\n\nÇaresiz bir gecede sessizlik içinde\nHer zamanki gibi resmin elimde\nUmmana dalan bakışlarım gözlerinde\nLanet ediyorum sensiz geçen her güne\n\nArtık hiçbir şey beni avutmuyor\nNe voltalarım sana yaklaştırıyor\nNe de sen bana yaklaşıyorsun\nBaktığım resmin de konuşmuyor artık\n\nYine akşam oldu bugün de gelmedin\nDüşündüm kendimce \'sevse gelirdi\' diye\nBiliyorum bir daha gelmeyecek fikrimce\nBir fısıltı kulağımda \'boşa bekleme\' diye\n";

  boolean check=true;
  while (check==true) {
    try {
      check=false;
      s = biSiirYazsanaDeniz();
    } 
    catch (Exception e) {
      e.printStackTrace();
      check=true;
    }
  }
  //  int r = int(random(3));  
  //  if (r==0) s="     DDD\n\nÇaresiz\n";
  //  if (r==1) s="CCC\n\nÇaresiz\n";
  //  if (r==2) s="  AAA\n\nÇaresiz\n";
  return s;
}

void savePoemGcode(String poemFileName, String[] s) {
  //saveStrings(sketchPath()+"\\"+poemFileName+"_gCode", s);
   saveStrings("/home/pi/sketchbook/poem4full/"+poemFileName+"_gCode", s);
}

String setPoemFileName(String t) {
  println(t);
  int x=t.indexOf(char(10));
  // println("text="+t);
  t=t.substring(0, x);
  t=t+".txt";
  t=turkceKarakter(t);
  t=lowerCase(t);
  return t;
}

void savePoemTXT(String f, String t) {
  String[] list = {
    t
  };
  saveStrings(f, list);
}