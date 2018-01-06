// Bullet Class

class Bullet extends GameObject
{
  int size = 5;
  
  float velScalar = 600;  
  PVector velocity;
  
  Bullet(GameManager newGM, PVector newPos, float theta, PVector shipVelocity)
  {
    gameManager = newGM; //<>//
    pos = new PVector();
    pos.x = newPos.x;
    pos.y = newPos.y;
    
    velocity = new PVector();
    velocity.x = (cos(theta) * velScalar) + shipVelocity.x;
    velocity.y = (sin(theta) * velScalar) + shipVelocity.y;
  }
  
  void update()
  {
    if(isDead) return;
    
    pos.x += velocity.x * gameManager.deltaTime;
    pos.y += velocity.y * gameManager.deltaTime;
    
    if(pos.x > width || pos.x < 0 
       || pos.y > height || pos.y < 0)
    {
      gameManager.despawnObject(this);
    }
    
    hitTest();
  }
  
  void render()
  {
    stroke(255);
    fill(255);
    ellipse(pos.x, pos.y, size, size);
  }
  
  // Test hits with asteroid
  void hitTest()
  {
    for(Asteroid asteroid : gameManager.asteroids)
    {
      if(pos.dist(asteroid.pos) < asteroid.size)
      {
        asteroid.kill();
        gameManager.despawnObject(this);
        isDead = true;
        pos.x = -1000;
        pos.y = -1000;
        break;
      }
    }
  }
}