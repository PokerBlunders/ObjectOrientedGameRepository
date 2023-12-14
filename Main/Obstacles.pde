 class Obstacle {
  float x, y, width, height;
  float speed = 5;


//Constructor for the obstacles class
  Obstacle(float x, float y, float width, float height, float speed) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.speed = speed;
  }

//Function to update the obstacles
  void update() {
    x -= speed;
  }

//Function to display the obstacles
  void display() {
    fill(0);
    rect(x-2, y-2, width+4, height+4);
    fill(255, 50, 50);
    rect(x, y, width, height);
  }

//Used to reset obstacles when they are offscreen
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
