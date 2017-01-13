// Player Ship Class

class Ship extends GameObject
{
  PShape shape;
  int size = 30;

  PVector velocity;
  float theta;
  float rotSpeed = PI * 1.50;

  float dragCoeff = 0.5;
  float acceleration = 10;
  float maxSpeed = 20;

  boolean hasFired = false;
  int prevFire = 0;
  int fireDelay = 250;

  Ship(GameManager newGM, PVector newPos)
  {
    gameManager = newGM;

    pos = newPos;

    velocity = new PVector(0, 0);
    theta = -HALF_PI;

    shape = createShape(TRIANGLE, 0, -size, -(size/2), (size/2), (size/2), (size/2));
    shape.setFill(false);
    shape.setStroke(255);
  }

  void update()
  {
    boolean shipThrust = doInput();

    // Apply drag only if player not thrusting ship
    if (!shipThrust) applyDrag();

    pos.x = (pos.x + velocity.x) % width;
    pos.y = (pos.y + velocity.y) % height;

    if (pos.x < 0) pos.x = width;
    if (pos.y < 0) pos.y = height;
  }

  void render()
  {
    stroke(255);
    noFill();
    shape(shape, pos.x, pos.y);
  }

  void fire()
  {
    PVector bulletPos = new PVector();
    bulletPos.x = pos.x + (cos(theta) * size);
    bulletPos.y = pos.y + (sin(theta) * size);

    Bullet bullet = new Bullet(gameManager, bulletPos, theta);
    gameManager.spawnObject(bullet);

    hasFired = true;
    prevFire = millis();
  }

  void kill()
  {
    pos.x = width / 2;
    pos.y = height / 2;
    velocity.x = 0;
    velocity .y = 0;
    theta = -PI/2.0;
    shape.resetMatrix();
  }

  // Returns true if ship thrust was engaged
  boolean doInput()
  {
    boolean result = false;

    if (controller.up.isDown())
    {
      velocity.x += cos(theta) * acceleration * gameManager.deltaTime;
      velocity.y += sin(theta) * acceleration * gameManager.deltaTime;

      result = true;
    }
    if (controller.down.isDown())
    {
      velocity.x -= cos(theta) * acceleration * gameManager.deltaTime;
      velocity.y -= sin(theta) * acceleration * gameManager.deltaTime;

      result = true;
    }

    if (controller.left.isDown())
    {
      theta += -rotSpeed * gameManager.deltaTime;
      shape.rotate(-rotSpeed * gameManager.deltaTime);
    }
    if (controller.right.isDown())
    {
      theta += rotSpeed * gameManager.deltaTime;
      shape.rotate(rotSpeed * gameManager.deltaTime);
    }

    if (controller.fire.isDown())
    {
      if (!hasFired || millis() >= prevFire + fireDelay)
      {
        fire();
      }
    } else
    {
      hasFired = false;
    }

    // Clamp velocity's magnitude
    velocity.limit(maxSpeed);

    return result;
  }

  void applyDrag()
  {
    float drag = dragCoeff * ((5 + velocity.magSq()) / 2.0);

    // Apply drag to velocity
    velocity.setMag(velocity.mag() - (drag * gameManager.deltaTime));
    if (velocity.magSq() < 0) velocity.setMag(0);
  }
}