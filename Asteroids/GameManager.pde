// Game Manager

class GameManager
{
 // Have to have three GO threads because Processing
 // has some weird hidden threading that keeps creating
 // race conditions in gameObjects otherwise
 ArrayList<GameObject> gameObjects;
 ArrayList<GameObject> newObjs;
 ArrayList<GameObject> destroyedObjs;
 
 Ship playerShip;
 ArrayList<Asteroid> asteroids;
 
 // Time-keeping
 int prevTime = 0;
 float deltaTime = 0;
 
 GameManager()
 {
   gameObjects = new ArrayList();
   newObjs = new ArrayList();
   destroyedObjs = new ArrayList();
 }
 
 void startGame()
 {
   playerShip = new Ship(this, new PVector(width/2, height/2));
   spawnObject(playerShip);
   
   asteroids = new ArrayList();
   for(int i = 0; i < 5; i++)
   {
     Asteroid tmp = new Asteroid(new PVector(random(0, width), random(0, height)));
     asteroids.add(tmp);
     spawnObject(tmp);
   }
 }
 
 void update()
 {
  if(controller.quit.isDown()) exit();
   
  deltaTime = (millis() - prevTime) / 1000.0;
  prevTime = millis();
  
  for(GameObject newObj : newObjs)
  {
   if(destroyedObjs.contains(newObj))
   {
    destroyedObjs.remove(newObj);
   }
   else
   {   
    gameObjects.add(newObj); 
   }
  }
  newObjs.clear();
  
  for(GameObject dObj : destroyedObjs)
  {
   gameObjects.remove(dObj);
  }
  destroyedObjs.clear();
  
  for(GameObject gameObj : gameObjects)
  {
    gameObj.update();
    gameObj.render();
  }
 }
 
 void spawnObject(GameObject obj)
 {
   newObjs.add(obj);
 }
 
 void despawnObject(GameObject obj)
 {
   destroyedObjs.add(obj);
 }
}