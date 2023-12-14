Player player;
Background background;
int groundLevel;
int jumpCount = 0;
ArrayList<Obstacle> obstacles;
ArrayList<Platform> platforms;
boolean gameRunning = false;
PFont Font;
float obstacleSpeed = 5; // Initial speed
float platformSpeed = 5; // Initial speed
float speedMultiplier = 1.0002; // Speed multiplier
int distanceTraveled = 0;
int finalScore;
PImage galexy;

void setup() {
  size(800, 400);
  frameRate(60);
  groundLevel = height - 50;
  player = new Player(100, groundLevel);
  obstacles = new ArrayList<Obstacle>();
  platforms = new ArrayList<Platform>();
  background = new Background();
  Font = createFont("Arial Bold", 60);
  galexy = loadImage("galexy.png");
}

void draw() {
  background(0);
  image(galexy, 0, 0);

  if (gameRunning) {
    
    background.update();
    drawBackground();
  
    fill(100, 250, 100);
    rect(0, groundLevel, width, height - groundLevel);

    // Update and draw player
    player.update();
    player.display();

    // Respawn new obstacles with a random()
    if (random(1) < 0.02) {
      obstacles.add(new Obstacle(width, groundLevel- int(random(15,350)), 20, int(random(20,100)), obstacleSpeed));
    }

    // Respawn new platforms with a random()
    if (random(1) < 0.01) {
      platforms.add(new Platform(width, groundLevel - int(random(20, 230)), int(random(50, 100)), 10, platformSpeed));
    }

    // Move and draw obstacles
    for (int i = obstacles.size() - 1; i >= 0; i--) {
      Obstacle obs = obstacles.get(i);
      obs.update();
      obs.display();

      // Check for collision
      if (player.checkCollision(obs)) {
        gameOver();
        return;
      }
      
      // Remove the obstacles when they are off screen
      if (obs.isOffscreen()) {
        obstacles.remove(i);
      }
    }

    // Move and draw platforms
    for (int i = platforms.size() - 1; i >= 0; i--) {
      Platform platform = platforms.get(i);
      platform.display();

      // Check for collision with platform
      if (player.checkCollision(platform)) {
        player.handlePlatformCollision(platform);
      }

      // Remove the platforms when they are off screen
      if (platform.isOffscreen()) {
        platforms.remove(i);
      }
    }
    // Increase speed of obstacles and platforms over time.
    obstacleSpeed *= speedMultiplier;
    platformSpeed *= speedMultiplier;
    
    // Update distance traveled
    distanceTraveled += (0.2 * obstacleSpeed);
    
    // Display distance traveled on the top right
  textSize(16);
  fill(255);
  textAlign(RIGHT, TOP);
  text("Distance: " + nf(distanceTraveled, 0, 0), width - 10, 10);
  
  } else {
    drawStartScreen();
  }
  
}

void drawStartScreen() {
  background(0); // Set the background color
  image(galexy, 0, 0);

  // Draw the start button
  fill(255); // White color
  rectMode(CENTER);
  rect(width / 2, height / 2, 150, 50, 20); // Adjust the size of the start button

  // Draw text on the start button
  fill(0); // Black color
  textSize(20);
  textAlign(CENTER, CENTER);
  text("Start", width / 2, height / 2);

  // Check if the mouse is over the start button
  if (mouseX > width / 2 - 75 && mouseX < width / 2 + 75 && mouseY > height / 2 - 25 && mouseY < height / 2 + 25) {
    fill(0); // highlighting when the mouse is over the button
    rect(width / 2, height / 2, 150, 50, 20);
    fill(255); // White color
    text("Start", width / 2, height / 2);
    
    rectMode(CORNER);

    // Check if the mouse is pressed
    if (mousePressed) {
      gameRunning = true; // Start the game when the button is clicked
    }
  }
  
  fill(0);
  textSize(60);
  textFont(Font);
  text("Cosmic Runner", width / 2+3, height / 3+5);
  
  fill(255);
  text("Cosmic Runner", width / 2, height / 3);
  
  fill(255, 154, 162);
  text("C", width / 2-200, height / 3);
  
  fill(255, 183, 178);
  text("o", width / 2-161, height / 3);
  
  fill(255, 218, 193);
  text("s", width / 2-125, height / 3);
  
  fill(226, 240, 203);
  text("m", width / 2-82, height / 3);
  
  fill(181, 234, 215);
  text("i", width / 2-47, height / 3);
  
  fill(199, 206, 234);
  text("c", width / 2-22, height / 3);
  
  fill(0);
  textSize(15);
  text("Made by: Nathan Tatti", width / 2+2, height / 2 + 53);

  fill(255);
  text("Made by: Nathan Tatti", width / 2, height / 2 + 50);
}


// Draws background
void drawBackground() {
  background.display();
}

//Function for the game over state
void gameOver() {
  gameRunning = false;
  obstacles.clear(); // Clears all obstacles currently displayed
  platforms.clear(); // Clears all platforms currently displayed
  noLoop(); // Stop the loop
  fill(0);
  rect(0,0,800,400);
  textAlign(CENTER, CENTER);
  textFont(Font);
  
  // Display "GAME OVER" in the middle of the screen in red
  fill(255, 0, 0);
  text("GAME OVER", width/2, height/2 - 50);
  
  finalScore = distanceTraveled;
    textSize(30);
    fill(255);
    text("Distance Travelled: " + nf(finalScore, 0, 0), width/2, height/2);
  
  // Set text properties for "Press" to white
  textSize(20);
  fill(255);
  text("Press ", width/2 - 52, height/2 + 50); // Display "Press " in black
  
  // Set text properties for "R" to yellow
  fill(255,255,0); 
  text("R", width/2 + -16, height/2 + 50); // Adjust the position as needed
  
  // Set text properties for "to Reset" to white
  fill(255); // Set text color back to black
  text(" to Reset", width/2 + 32, height/2 + 50); // Adjust the position as needed
  
  //Resets obstacle and platform speeds back to default
  obstacleSpeed = 5;
  platformSpeed = 5;
  
}

// Function to restart the game
void restartGame() {
  gameRunning = true;
  loop(); // Restart the game loop
  player.reset(100, groundLevel);
  obstacles.clear();
  platforms.clear();
  distanceTraveled = 0;
  
}

void keyPressed() {
  // When the 'space' bar is pressed the player will jump
  switch(key) {
    case ' ':
      if (jumpCount < 2) {
        player.jump();
        jumpCount++;
      }
       if (player.jumping){
          jumpCount = 0;
      }
      break;

  // When the 'r' key is pressed the game will restart
    case 'r':
      if (!gameRunning) {
        restartGame();
      }
      break;
  }
  
}
