class Background {
  Star[] stars;
  int numStars = 200;

  Background() {
    stars = new Star[numStars];
    for (int i = 0; i < numStars; i++) {
      stars[i] = new Star(random(width), random(height), obstacleSpeed, platformSpeed);
    }
  }

  void update() {
    for (Star star : stars) {
      star.update();
    }
  }

  void display() {
    for (Star star : stars) {
      star.display();
    }
  }
}

class Star {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float obstacleSpeed;
  float platformSpeed;
  float starSize = 4; // Adjust this value for the desired size

  Star(float x, float y, float obstacleSpeed, float platformSpeed) {
    position = new PVector(x, y);
    velocity = new PVector(-0.5, 0); // Stars move to the left
    acceleration = new PVector(-0.0005, 0.00005); // Adjust these values for slower acceleration
    this.obstacleSpeed = obstacleSpeed;
    this.platformSpeed = platformSpeed;
  }

  void update() {
    velocity.add(acceleration);
    position.add(PVector.mult(velocity, obstacleSpeed > platformSpeed ? obstacleSpeed : platformSpeed));

    if (position.x + starSize < 0 || position.y + starSize < 0 || position.y - starSize > height) {
      // Reset the star if it goes off-screen
      position.set(width + random(50), random(height-100));
    }
  }

  void display() {
    fill(255, 0, 0);
    noStroke();
    ellipse(position.x, position.y, starSize, starSize);
  }
}
