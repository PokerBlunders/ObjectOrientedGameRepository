Main main;
class Star {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float obstacleSpeed;
  float platformSpeed;
  float starSize = 2; // Adjust this value for the desired size

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

    if (position.x + starSize < 0) {
      // Reset the star if it goes off-screen
      position.set(width + random(50), random(-200, height-50));
    }
    
    if (keyPressed) {
      if (key == 'r') {
        velocity.set(-0.5, 0);
      }
     }
   }
   

  void display() {
    fill(255);
    noStroke();
    ellipse(position.x, position.y, starSize, starSize);
   
  }
  
}
