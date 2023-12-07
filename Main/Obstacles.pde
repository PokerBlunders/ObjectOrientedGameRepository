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
    fill(0, 0, 255);
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
