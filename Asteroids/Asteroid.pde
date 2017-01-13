// Asteroid Class

class Asteroid extends GameObject
{
  // When asteroid is destroyed
    // if iteration < maxIteration
      // create 3 smaller asteroids(iteration + 1)
  final int maxIteration = 3;
  int iteration;
  
  final float minSpeed = 10;
  final float maxSpeed = 50;
  float speed;
  
  PVector velocity;
  
  final float minSize = 45;
  final float maxSize = 60;
  float size; // Radius
  
  final float minRotSpeed = TWO_PI / 40.0;
  final float maxRotSpeed = TWO_PI / 20.0;
  float rotSpeed;
  
  PShape shape;
  
  Asteroid(PVector newPos)
  {
   this(1, newPos);
  }
  
  Asteroid(int newIteration, PVector newPos)
  {
    pos = new PVector(newPos.x, newPos.y);
    
    iteration = newIteration;
    
    speed = random(minSpeed * iteration, maxSpeed * iteration);
    velocity = PVector.random2D();
    velocity.setMag(speed);
    
    size = random(minSize / iteration, maxSize / iteration);
    
    rotSpeed = random(minRotSpeed, maxRotSpeed);
    
    constructShape();
  }
  
  void update()
  {
   if(isDead) return;
   
   pos.x += velocity.x * gameManager.deltaTime;
   pos.y += velocity.y * gameManager.deltaTime;
   
   if(pos.x < 0 - size) pos.x = width + size;
   if(pos.x > width + size) pos.x = 0 - size;
   if(pos.y < 0 - size) pos.y = height + size;
   if(pos.y > height + size) pos.y = 0 - size;
   
   shape.rotate(rotSpeed * gameManager.deltaTime);
   
   hitTest();
  }
  
  void render()
  {
    stroke(255);
    noFill();
    shape(shape, pos.x, pos.y);
  }
  
  void kill()
  {
   if(iteration < maxIteration)
   {
     int numChildren = ceil(random(0, 4));
     for(int i = 0; i < numChildren; i++) //<>//
     {
      Asteroid tmp = new Asteroid(iteration + 1, pos);
      gameManager.asteroids.add(tmp);
      gameManager.spawnObject(tmp);
     }
   }
   isDead = true;
   pos.x = -1000;
   pos.y = -1000;
   gameManager.asteroids.remove(this);
   gameManager.despawnObject(this);
  }
  
  // Test hits with player
  void hitTest()
  {
    if(pos.dist(gameManager.playerShip.pos) < size)
    {
      gameManager.playerShip.kill();
    }
  }
  
  // Make a jagged circle
  void constructShape()
  {
    int jaggedness = 15 / iteration;
    int numPoints = 10;
    float newSize = 0;
    
    shape = createShape();
    shape.beginShape();
    for(int i = 0; i < numPoints; i++)
    {
      int vertX, vertY;
      vertX = floor(cos(i * TWO_PI / numPoints) * size + random(-jaggedness, jaggedness));
      vertY = floor(sin(i * TWO_PI / numPoints) * size + random(-jaggedness, jaggedness));
      shape.vertex(vertX, vertY);
        
      newSize += pos.dist(new PVector(pos.x + vertX, pos.y + vertY)) * (1.0 / numPoints);
    }
    shape.endShape(CLOSE);
    
    shape.setStroke(255);
    shape.setFill(false);
    
    size = newSize;
  }
}