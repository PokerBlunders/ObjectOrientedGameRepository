class Background {
  Star[] stars;
  int numStars = 300;

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
