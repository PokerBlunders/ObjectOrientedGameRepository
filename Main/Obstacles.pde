 class Obstacle {
  float x, y, width, height;
  float speed = 5;

  Obstacle(float x, float y, float width, float height, float speed) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.speed = speed;
  }

  void update() {
    x -= speed;
  }

  void display() {
    fill(0);
    rect(x-2, y-2, width+4, height+4);
    fill(255, 50, 50);
    rect(x, y, width, height);
  }

  boolean isOffscreen() {
    return x + width < 0;
  }

  float getX() {
    return x;
  }

  float getY() {
    return y;
  }

  float getWidth() {
    return width;
  }

  float getHeight() {
    return height;
  }
}
