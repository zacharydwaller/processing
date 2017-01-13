// Asteroids Main

GameManager gameManager;
Controller controller;

void setup()
{
  size(800, 800);
  background(0);
  //frameRate(15);
  
  controller = new Controller();
  gameManager = new GameManager();
  gameManager.startGame();
}

void draw()
{
    clear();
    gameManager.update();
}