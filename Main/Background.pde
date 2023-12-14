class Background {
  Star[] stars;
  int numStars = 300;


//Constructor for the background class
  Background() {
    stars = new Star[numStars];
    
    //Loop to create stars from the array
    for (int i = 0; i < numStars; i++) {
      stars[i] = new Star(random(width), random(height), obstacleSpeed, platformSpeed);
    }
  }

//Function to update the stars into the background
  void update() {
    for (Star star : stars) {
      star.update();
    }
  }

//Function to display the stars into the background
  void display() {
    for (Star star : stars) {
      star.display();
    }
  }
}
