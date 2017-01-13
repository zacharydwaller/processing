// Input Handling Classes

class Controller
{
  private final int default_quit  = ESC; 
  private final int default_up    = 'w';
  private final int default_down  = 's';
  private final int default_left  = 'a';
  private final int default_right = 'd';
  private final int default_fire  = ' ';
  
  private Input quit;
  private Input up;
  private Input down;
  private Input left;
  private Input right;
  private Input fire;
  
  private HashMap<Integer, Input> inputs;
  
  Controller()
  {
    quit  = new Input();
    up    = new Input();
    down  = new Input();
    left  = new Input();
    right = new Input();
    fire  = new Input();
    
    inputs = new HashMap();

    mapKey(default_quit, quit);
    mapKey(default_up, up);
    mapKey(default_down, down);
    mapKey(default_left, left);
    mapKey(default_right, right);
    mapKey(default_fire, fire);
    
    mapKey(UP, up);
    mapKey(DOWN, down);
    mapKey(LEFT, left);
    mapKey(RIGHT, right);
  }
  
  public void mapKey(int newKey, Input newInput)
  {
   inputs.put(newKey, newInput); 
  }
  
  public void unmapKey(int oldKey)
  {
    inputs.remove(oldKey);
  }
  
  public void pressKey(int keypress)
  {
    if(keypress == CODED) keypress = keyCode;
    
    if(inputs.containsKey(keypress))
    {
     inputs.get(keypress).keyDown();
    }
  }
  
  public void releaseKey(int keypress)
  {
   if(keypress == CODED) keypress = keyCode;
    
   if(inputs.containsKey(keypress))
   {
    inputs.get(keypress).keyUp(); 
   }
  }
}

class Input
{
 private boolean isDown = false;
 
 public boolean isDown()
 {
  return isDown; 
 }
 
 void keyDown()
 {
  isDown = true; 
 }
 
 void keyUp()
 {
   isDown = false;
 }
}


// Processing functions
void keyPressed()
{
 controller.pressKey(key);
}

void keyReleased()
{
 controller.releaseKey(key);
}