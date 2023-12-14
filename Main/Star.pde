Main main;
class Star {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float obstacleSpeed;
  float platformSpeed;
  float starSize = 2;

//Constructor for the star class
  Star(float x, float y, float obstacleSpeed, float platformSpeed) {
    position = new PVector(x, y);
    velocity = new PVector(-0.5, 0); // Stars move to the left
    acceleration = new PVector(-0.0005, 0.00005);
    this.obstacleSpeed = obstacleSpeed;
    this.platformSpeed = platformSpeed;
  }

//Update function for stars in the background
  void update() {
    velocity.add(acceleration);
    position.add(PVector.mult(velocity, obstacleSpeed > platformSpeed ? obstacleSpeed : platformSpeed));

// Reset the star if it goes off-screen
    if (position.x + starSize < 0) {
      position.set(width + random(50), random(-200, height));
    }
    
//When 'r' is pressed the velovity of the stars gets set back to default
    if (keyPressed) {
      if (key == 'r') {
        velocity.set(-0.5, 0);
      }
     }
   }
   
//Function to display the stars
  void display() {
    fill(255);
    noStroke();
    ellipse(position.x, position.y, starSize, starSize);
   
  }
  
}
