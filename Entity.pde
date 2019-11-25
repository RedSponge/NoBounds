import java.awt.Rectangle;

class Entity {
  protected int x, y, w, h;
  protected Rectangle asRectangle;
  public Entity(int x, int y, int w, int h) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    asRectangle = new Rectangle();
  }
  
  public void updateRectangle() {
    asRectangle.setBounds(x, y, w, h);
  }
  
  public void tick() {
  
  }
  
  public boolean collide(Entity other) {
    other.updateRectangle();
    return this.asRectangle.intersects(other.asRectangle);
  }
  
  public void render(int camX, int camY) {
    noStroke();
    fill(0);
    rect(x - camX, y - camY, w, h);
  }
}
