void intGPIO() {
  if (linuxMode) {

    String[] s= {
      "3"
    };
    saveStrings("/sys/class/gpio/export", s);
  }
}

void intArduino() {
  String[] ports = Serial.list();
  for (int i=0; i<ports.length; ++i) {
    println("Port " + i + ": " + ports[i]);
  }
  String portName = ports[ports.length - 1];
  println("Using port " + portName);

  gcs = new GcodeSerial(portName, 115200);

  gcs.sendLine("$1 X10 Y9 Z15");
  while (!gcs.waitForNextResponse ().equalsIgnoreCase("ok"));

  gcs.sendLine("$2 X11 Y3 Z");
  while (!gcs.waitForNextResponse ().equalsIgnoreCase("ok"));

  gcs.sendLine("$3 X17 Y13 Z");
  while (!gcs.waitForNextResponse ().equalsIgnoreCase("ok"));

  gcs.sendLine("$4 X16 Y12 Z");
  while (!gcs.waitForNextResponse ().equalsIgnoreCase("ok"));

  //  gcs.sendLine("$6 X174.9781 Y174.9781 Z174.9781");
  gcs.sendLine("$6 X174.9781 Y174.9781 Z174.9781");
  gcs.waitForNextResponse();

  gcs.sendLine("G90");
  gcs.waitForNextResponse();

  gcs.sendLine("G21");
  gcs.waitForNextResponse();

  // gcs.sendLine("F2500.0");
  // gcs.waitForNextResponse();
}

void autoHome () {
  gcs.sendLine("G0 Z80 ");
  gcs.waitForNextResponse();

  gcs.sendLine("G92 X0 Y0");
  gcs.waitForNextResponse(); 
  gcs.sendLine("G0 Z80 F50000.0");
  gcs.waitForNextResponse();
  gcs.sendLine("G1 X-600 Y600  F50000.0");
  gcs.waitForNextResponse();

  gcs.sendLine("G92 X0 Y0");
  gcs.waitForNextResponse();


  //burada şiirin uzunluğunu hesaplayıp şiirin pozisyonunu kağıdın merkeze alındığını varsayarak ayarlamalı
}

void getReadyToWrite(int x, int y) {
  //  gcs.sendLine("G1 X200 Y-100 Z80 F50000.0");
  //type of x&y are mm
  String s="G1 X"+x+" Y"+y+" Z80 F50000.0";
  println("Going to : "+s);
  gcs.sendLine(s);
  gcs.waitForNextResponse();
  gcs.sendLine("G92 X0 Y0");
  gcs.waitForNextResponse();
}

void send(String s) {
  gcs.sendLine(s);
  gcs.waitForNextResponse();
}



void writePoem() {
  for (int i = 0; i < poem.gCode.length; i++) {
    if (poem.gCode[i].charAt(0)!='(')
      send(poem.gCode[i]);
    if (i==poem.gCode.length-1)
      state=finishedWriting;
  }
}

