// spaceWidth ilk karakterin widthi ile ayni 
// lineSpacing ilk karakterin heighti capri 3 
// letterSpacing ilk karakterin widthi bolu 4.2

//



Serial serial;
GcodeSerial gcs;


int creatingPoem=0;
int waitingForInput=1;
int writingPoem=2;
int finishedWriting=3;

int state=finishedWriting;
Poem poem=new Poem();



String saveFolder="amber";

String archive="letters"; //Letter G-Codes
String lowerText="abcçdefgğhıijklmnoöprsştuüvyzxwq"; 
String upperText="ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZXWQ"; 
String numberText="0123456789";
String otherText="+&/\\()[]{}'_#%=@~;:><*-,!\"?âÂ.•…";
String theText=lowerText+upperText+numberText+otherText;
String specialText="()";

String baseHigher="'\"";
String baseHigh="+#=~*-";
String baseLow="çşÇŞQ";
String baseLower="fgğjpyq";
String[] base = {
  baseHigher, baseHigh, baseLow, baseLower
};

float baseHigherInt=-0.99;
float baseHighInt=-0.2;
float baseLowInt=0.3;
float baseLowerInt=0.6;
float[] baseInt= {
  baseHigherInt, baseHighInt, baseLowInt, baseLowerInt
};


String gcodePrefix="G1";
int feedRate=25000;
int safeMargin=8;
float letterSpacing=0;
float spaceWidth=0;
float lineSpacing=0;
int zUP=69;
int zDOWN=58;



String sesliHarfler          = "aeıioöuüAEIİOÖUÜ";
String sessizHarfler         = "bcçdfgğhjklmnprsştvyzBCÇDFGĞHJKLMNPRSŞTVYZ";
String kucukSesliHarfler     = "aeıioöuü";
String kucukSessizHarfler    = "bcçdfgğhjklmnprsştvyz";
String buyukSesliHarfler     = "AEIİOÖUÜ";
String buyukSessizHarfler    = "BCÇDFGĞHJKLMNPRSŞTVYZ";
String yabanciHarfler        = "qwx";
String sayilar               = "01234567890";
String noktalamaIsaretleri   = ".,:;'?!'-+%&/\\()[]{}$€£¥#*><\"";
                             
String kucukHarfler          = "abcçdefgğhıijklmnoöprsştuüvyz";
String buyukHarfler          = "ABCÇDEFGĞHIİJKLMNOÖPRSŞTUÜVYZ";

String ozelTurkceHarfler     = "îâû";

String[] kokListesi;


void loadBigVariables() {
  kokListesi=loadFile("posta-reverse-3-gram.txt");

}

import java.io.*;
import java.nio.channels.FileChannel;
import java.nio.ByteBuffer;
import java.lang.Character;
String kafiye1="";
String kafiye2="";
StringList kafiyelik1=new StringList();
StringList kafiyelik2=new StringList();
StringList siir=new StringList();
int dizeSayisi=8;
int heceSayisi=0;
int kaf=2;
int[] heceUzunluklari ;
IntList heceUzunluklariList= new IntList();

int beyit=4;
