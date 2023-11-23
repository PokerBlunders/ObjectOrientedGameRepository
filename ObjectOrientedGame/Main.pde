Player player;
int groundLevel;
ArrayList<Obstacle> obstacles;
ArrayList<Platform> platforms;
boolean gameRunning = true;
PFont Font;

void setup() {
  size(800, 400);
  frameRate(60);
  groundLevel = height - 50;
  player = new Player(100, groundLevel);
  obstacles = new ArrayList<Obstacle>();
  platforms = new ArrayList<Platform>();
  Font = createFont("Arial Bold", 60);
}

void draw() {
  background(200);

  if (gameRunning) {
  
    fill(100, 250, 100);
    rect(0, groundLevel, width, height - groundLevel);

    // Update and draw player
    player.update();
    player.display();

    // Check for obstacles and collisions
    if (random(1) < 0.01) {
      obstacles.add(new Obstacle(width, groundLevel - 15, 20, 15));
    }

    // Check for platforms
    if (random(1) < 0.01) {
      platforms.add(new Platform(width, groundLevel - int(random(20, 50)), int(random(50, 100)), 10));
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

      if (platform.isOffscreen()) {
        platforms.remove(i);
      }
    }
  }
}

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
}

void restartGame() {
  gameRunning = true;
  loop(); // Restart the game loop
  player.reset(100, groundLevel);
  obstacles.clear();
  platforms.clear();
}

void keyPressed() {
  // When the 'space' bar is pressed the player will jump
  if (key == ' ' && !player.isJumping() && gameRunning) {
    player.jump();
  }

  // When the 'R' key is pressed the game will restart
  if ((key == 'R' || key == 'r') && !gameRunning) {
    restartGame();
  }
}