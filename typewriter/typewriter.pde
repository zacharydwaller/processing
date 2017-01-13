// Typewriter message

PFont f;
String message = "Hello my dude, how are you today?\n\nI'm doing great how are you?";
String partMessage = "";
int index = 0;

int DELAY_MIN = 50, DELAY_MAX = 200;
int delay = floor(random(DELAY_MIN, DELAY_MAX));
int prevTime = 0;

void setup() {
  size(800, 800);
  background(0);
  
  PFont f = createFont("Arial", 16, true);
  textAlign(CENTER);
  textFont(f, 36);
  fill(255);
}

void draw()
{
  clear();
  translate(width/2, 100);
  
  if((index < message.length()) && (millis() >= prevTime + delay))
  {
    partMessage = partMessage + message.charAt(index);
    
    index++;
    delay = floor(random(DELAY_MIN, DELAY_MAX));
    prevTime = millis();
  }
  
  text(partMessage, 0,0);
}