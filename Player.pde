class Player
{
  PVector walkingVel, loc, vel, playerSize;
  float gravity, friction, speed;
  boolean grounded;

  Player(PVector loc)
  {
    this.walkingVel = new PVector();
    this.loc = loc;
    this.vel = new PVector();
    this.playerSize = new PVector(10, 10);
    this.gravity = .25;
    this.friction = 1;
    this.speed = 4;
    this.grounded = false;
  }

  void show()
  {
    fill(PLAYER_COLOR);
    rect(loc.x, loc.y, playerSize.x, playerSize.y);
  }

  void run()
  {
    boolean goingAgainstHorizontalSpring = false;
    shouldBreak = false;
    float minDistToSpring = 9999999;
    for (int x = int(width / 2 - (playerSize.x / 2)); x <= int(width / 2 + (playerSize.x / 2)); x ++)
    {
      for (int y = int(height / 2 - (playerSize.y / 2)); y <= int(height / 2 + (playerSize.y / 2)); y ++)
      {
        if (get(x, y) == WALL_COLOR)
        {
          loc.sub(vel);
          vel.set(0, 0, 0);
        }
        if (get(x, y) == HAZARD_COLOR || get(x, y) == MISSILE_COLOR)
        {
          hasStar = false;
          reset();
        }
        if (get(x, y) == END_COLOR)
        {
          if (bestTimes[currentElement][currentLevel] < minTime[currentLevel])
            minTime[currentLevel] = bestTimes[currentElement][currentLevel];
          if (hasStar)
            beatLevelWithStar[currentLevel] = true;
          currentLevel ++;
          shouldBreak = true;
          reset();
          break;
        }
        if (get(x, y) == STAR_COLOR)
          hasStar = true;
        if (get(x, y) == SPRING_COLOR)
        {
          for (Spring s : springs)
          {
            if (loc.dist(s.loc) < minDistToSpring)
              minDistToSpring = loc.dist(s.loc);
          }
          for (Spring s : springs)
          {
            if (get(int(loc.x + (vel.x + s.springVel.x)), int(loc.y + (vel.y + s.springVel.y))) != WALL_COLOR && loc.dist(s.loc) == minDistToSpring)
            {
              vel.add(s.springVel);
              if (s.springVel.x != 0)
                goingAgainstHorizontalSpring = true;
            }
          }
          shouldBreak = true;
          break;
        }
      }
      if (shouldBreak)
        break;
    }
    int rightCollisions = 0;
    int leftCollisions = 0;
    grounded = false;
    shouldBreak = false;
    float minDistToWall = 9999999;
    for (int y = int(height / 2 - (playerSize.y / 2)); y <= int(height / 2 + (playerSize.y / 2)); y ++)
    {
      if (get(int(width / 2 + (playerSize.x / 2) + 5), y) == WALL_COLOR || get(int(width / 2 - (playerSize.x / 2) - 5), y) == WALL_COLOR)
      {
        for (Wall w : walls)
        {
          if (dist(player.loc.x, player.loc.y, w.loc.x, w.loc.y) <= minDistToWall)
            minDistToWall = dist(player.loc.x, player.loc.y, w.loc.x, w.loc.y);
        }

        for (Wall w : walls)
        {
          if (dist (loc.x, loc.y, w.loc.x, w.loc.y) == minDistToWall)
          {
            loc.x += w.vel.x;
            if (w.vel.x > 0)
              leftCollisions ++; 
            else if (w.vel.x < 0)
              rightCollisions ++;
            shouldBreak = true;
            break;
          }
        }
      }
      if (shouldBreak)
        break;
    }
    shouldBreak = false;
    minDistToWall = 9999999;
    for (int x = int(width / 2 - (playerSize.x / 2)); x <= int(width / 2 + (playerSize.x / 2)); x ++)
    {
      if (get(x, int(height / 2 + (playerSize.y / 2) + 5)) == WALL_COLOR || get(x, int(height / 2 - (playerSize.y / 2) - 5)) == WALL_COLOR)
      {
        for (Wall w : walls)
        {
          if (dist(player.loc.x, player.loc.y, w.loc.x, w.loc.y) <= minDistToWall)
            minDistToWall = dist(player.loc.x, player.loc.y, w.loc.x, w.loc.y);
        }
        for (Wall w : walls)
        {
          if (dist(loc.x, loc.y, w.loc.x, w.loc.y) == minDistToWall)
          {
            loc.y += w.vel.y;
            shouldBreak = true;
            break;
          }
        }
      }
      if (shouldBreak)
        break;
    }
    for (int y = int(height / 2 - (playerSize.y / 2)); y <= int(height / 2 + (playerSize.y / 2)); y ++)
    {
      if (get(int(width / 2 + playerSize.x), y) == WALL_COLOR)
        rightCollisions ++;
      if (get(int(width / 2 - playerSize.x), y) == WALL_COLOR)
        leftCollisions ++;
    }
    for (int x = int(width / 2 - (playerSize.x / 2)); x <= int(width / 2 + (playerSize.x / 2)); x ++)
    {
      if (get(x, int(height / 2 + (playerSize.y / 2) + 1)) == WALL_COLOR)
        grounded = true;
    }
    walkingVel = new PVector();
    if (goingAgainstHorizontalSpring || vel.x <= walkingVel.x)
    {
      friction = 1;
    }
    else
    {
      friction = .93;
    }
    if (keys[0] && leftCollisions == 0)
      walkingVel.x -= 100;
    if (keys[1] && rightCollisions == 0)
      walkingVel.x += 100;
    walkingVel.limit(speed);     
    if (keys[2] && grounded)
      vel.y -= 7;
    if (!grounded)
      vel.y += gravity;
    vel.x *= friction;
    loc.add(vel);
    loc.add(walkingVel);
    walkingVel.add(vel);
  }
}

