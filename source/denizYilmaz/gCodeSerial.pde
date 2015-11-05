public class GcodeSerial extends PApplet {
  private static final int RESPONSE_TRYAGAIN_DELAY = 10;
  
  private String readBuffer;
  private Serial port;
  
  public GcodeSerial(String portName, int baud) {
    readBuffer = "";
    println("Initializing GcodeSerial for port " + portName + " at " + baud + " baud");
    port = new Serial(this, portName, baud);
    println("done");
  }
  
  public void serialEvent(Serial s) {
    while (s.available() > 0) {
      char c = s.readChar();
      readBuffer += c;
    }
  }

  public void sendLine(String line) {
    println("->" + line);
    port.write(line + "\n");
  }

  public String getNextResponse() {
    String nextResponse = "";
    for (int i=0; i < readBuffer.length(); ++i) {
      if (readBuffer.charAt(i) == '\r') continue;
      if (readBuffer.charAt(i) == '\n') {
        readBuffer = readBuffer.substring(i + 1);
        println("<-" + nextResponse);
        return nextResponse;
      }
      nextResponse += readBuffer.charAt(i);
    }

    return null;
  }

  public String waitForNextResponse() {
    String response = getNextResponse();
    while (response == null) {
      delay(RESPONSE_TRYAGAIN_DELAY);
      response = getNextResponse();
    }
    return response;
  }
}
