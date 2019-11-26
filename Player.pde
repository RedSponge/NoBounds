class Player extends Entity {
  
  int vx, vy;
  int noJumpBound;
  int noCollision;
  int passThrough;
  boolean onGround;
  
  public Player() {
    super(width / 2 - 10, height, 20, 20);
    vx = 0;
    vy = 0;
  }
  
  public void tick() {
    if(keys[UP] && !lastKeys[UP] && (onGround || noJumpBound > 0)) jump();
    
    vx = (keys[RIGHT] ? 1 : 0) - (keys[LEFT] ? 1 : 0);
    vy++;
    if(vy > 9) vy = 9;
    
    ArrayList<Platform> plat = world.platforms;
    x += vx * 5;
    boolean badX = false, badY = false;
    for(Platform p : plat) {
      updateRectangle();
      //println(asRectangle, p.asRectangle);
      if(collide(p)) {
        badX = true;
        break;
      }
    }
    if(badX) {
      x -= vx * 5;
    }
    
    onGround = false;
    y += vy;
    for(Platform p : plat) {
      updateRectangle();
      //println(asRectangle, p.asRectangle);
      if(collide(p)) {
        if(vy > 0) {
          onGround = true;
          y = p.y - p.h * 2;
          vy = 0;
        } else {
          if(noCollision <= 0) {
            y = p.y + p.h;
            vy = 0;
          }
        }
        break;
      }
    }
    
    
    if(y > height - w) {
      y = height - w;
      onGround = true;
    }
    checkPowerups();
    noJumpBound--;
    noCollision--;
    passThrough--;
    
    if(passThrough > 0) {
      if(x > width) x = 0;
      if(x + w < 0) x = width - w;
    }
  }
  
  public void checkPowerups() {
    updateRectangle();
    ArrayList<Powerup> removed = new ArrayList<Powerup>();
    for(Powerup p : world.powerups) {
      if(collide(p)) {
        removed.add(p);
        switch(p.type) {
          case INFINIJUMP:
            noJumpBound = 200;
            break;
          case NOCOL:
            noCollision = 500;
            break;
          case PASSTHROUGH:
            passThrough = 500;
            break;
        }
      }
    }
    for(Powerup p : removed) {
      world.powerups.remove(p);
    }
  }
  
  public void jump() {
    println("HI");
    vy = -20;
  }
  
  void render(int camX, int camY) {
    noStroke();
    int r = 0;
    int g = 0;
    int b = 0;
    if(noJumpBound > 0) {
      r += 100;
      g += 100;
    }
    if(noCollision > 0) {
      g += 100;
      b += 100;
    }
    if(passThrough > 0) {
      r += 100;
      b += 100;
    }
    fill(r, g, b);
    rect(x - camX, y - camY, w, h);
    if(passThrough > 0) {
      if(x + w > width) {
        rect(x - camX - width, y - camY, w, h);
      } else if(x < 0) {
        rect(x - camX + width, y - camY, w, h);
      }
    }
  }
}
