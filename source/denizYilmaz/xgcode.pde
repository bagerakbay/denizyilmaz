String[] poemToGCode(String text) {


//String path = sketchPath()+"\\"+archive;
String path = "/home/pi/sketchbook/poem4full/"+archive;

  File dataFolder = new File(path); 
  String[] fileList = dataFolder.list(); 
  //println(fileList.length); 
  int fileCount=fileList.length-1;
  int repeat=fileCount/(theText.length());
  Letter[] letters = new Letter[theText.length()];

  Letter tempLetter = new Letter(""+0, 1);
  spaceWidth=tempLetter.gcodes[0].w;
  letterSpacing=tempLetter.gcodes[0].w/(3.4);

  lineSpacing=tempLetter.gcodes[0].h*4;

  for (int i=0; i<theText.length (); i++) {
    letters[i] = new Letter(""+i, repeat);
  }
 // println("Char :     "+letters[0].self);
 // println("UpperCase :     "+letters[0].selfCase);
 // println("Sample Count :     "+letters[0].r);
 // println("1st W/H :     "+letters[0].gcodes[0].w+", "+letters[0].gcodes[0].h);
 // println("2nd W/H :     "+letters[0].gcodes[1].w+", "+letters[0].gcodes[1].h);
  //  println(letters[0].gcodes[0].gcodeLines[79].text);

  StringList bigCode = new StringList();
  //  bigCode.append("G21 G90"); //mm vs ayarları
  //  bigCode.append("F"+feedRate); // feedrate
  //  bigCode.append("G0 Z"+safeMargin); // kafayı kaldırmaca
  bigCode.append("G0 X0 Y0"); // 0,0 a gitmece , buna gerek yok sanirim.

  float currentX=0, currentY=0;
  for (int i=0; i<text.length (); i++) {

    String s=""+text.charAt(i);
    int index = theText.indexOf(s);
    //  println(s+" "+ index+" "+int(text.charAt(i)));

    if (index>-1) {
      if (specialText.indexOf(s)==-1)
        bigCode.append("( ---- "+s+" ----)");
      else
        bigCode.append("( ---- parantez ----)");

      int rast = int(random(letters[index].r));


      for (int k=0; k<letters[index].gcodes[rast].gcodeLines.length; k++) {
        GcodeLine tempGcode = new GcodeLine(letters[index].gcodes[rast].gcodeLines[k].x, letters[index].gcodes[rast].gcodeLines[k].y, letters[index].gcodes[rast].gcodeLines[k].z);

        tempGcode.x+=currentX;
        tempGcode.y+=currentY;
        tempGcode.createText();
        if (k==0)
          tempGcode.createText("G0");

        bigCode.append(tempGcode.text);
      }

      currentX+=letters[index].gcodes[rast].w;
      currentX+=letterSpacing;
    } else {
      int c=int(text.charAt(i));

      if (c==32) {
        bigCode.append("( ---- space ----)");
      //  println("space");
        currentX+=spaceWidth;
      }
      if (c==10) 
      {
        bigCode.append("( ---- line feed ----)");
        currentX=0+random(-spaceWidth/2, spaceWidth/2);
        currentY+=random(lineSpacing*-0.9, lineSpacing*-1.1);
      }
    }
  }

  String[] datas = bigCode.array();

  return datas;
}



class Letter {
  String self;
  boolean selfCase=false ; //lower
  Gcode[] gcodes;
  int r;
  Letter(String filenameBase, int repeat) {
    r=repeat;
    self=filenameBase;

    gcodes = new Gcode[r];
    for ( int i=0; i<r; i++ ) {
    //String lines[] = loadStrings(sketchPath()+"\\"+archive+"\\"+filenameBase+"_"+i+".txt");
      String lines[] = loadStrings("/home/pi/sketchbook/poem4full/"+archive+"/"+filenameBase+"_"+i+".txt");
      
      //println("Loading "+sketchPath+"\\"+archive+"\\"+filenameBase+"_"+i+".txt");

      //println("-"+theText.charAt(int(self)));
      float tempShifty=0;
      for (int m=0; m<base.length; m++) {
        if (base[m].indexOf(theText.charAt(int(self)))>-1)
        {
          tempShifty=lineSpacing*baseInt[m]*-0.4;
          //println("-"+theText.charAt(int(self))+"  :              "+tempShifty);
        }
      }

      gcodes[i] = new Gcode(lines, tempShifty);
    }
  }
}

class Gcode {

  int lineCount;
  float w, h;
  GcodeLine[] gcodeLines;
  String[] text;
  Gcode(String[] s, float tempShifty) {
    lineCount=s.length-1;
    String[] sFirst = split(s[0], ' ');
    w=float(sFirst[1]);
    h=float(sFirst[3].substring(0, sFirst[3].length()-1));

    gcodeLines= new GcodeLine[lineCount];

    for ( int i=1; i<lineCount+1; i++ ) {
      String sLine=s[i];
      String[] list = split(s[i], ' ');
      String sx=list[1].substring(1, list[1].length());
      String sy=list[2].substring(1, list[2].length());
      String sz=list[3].substring(1, list[3].length());
      float x=(float(sx)); // yaziyi %40 a ufaltiyor
      float y=(float(sy)+tempShifty) ; // yaziyi %40 a ufaltiyor
      float z=float(sz);
      if (z<0) z=zDOWN;//-0.5; //zyi sabitliyor
      else z=zUP;
      gcodeLines[i-1]=new GcodeLine(x, y, z);
    }
  }
}
class GcodeLine {
  float x, y, z;
  String text;
  GcodeLine (float _x, float _y, float _z) {

    x=_x;
    y=_y;
    z=_z;
    createText();
  }
  GcodeLine (float _x, float _y, float _z, String s) {

    x=_x;
    y=_y;
    z=_z;
    createText(s);
  }
  void createText() {
    text=gcodePrefix+" X"+int(1000*(x))/1000.+" Y"+int(1000*(y))/1000.+" Z"+int(1000*(z))/1000.+" F"+int(1000*feedRate)/1000.;
  }
  void createText(String specialPrefix) {
    text=specialPrefix+" X"+int(1000*(x))/1000.+" Y"+int(1000*(y))/1000.+" Z"+int(1000*(z))/1000.;
  }
}