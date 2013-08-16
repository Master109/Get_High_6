PFont font;

Player player;
End end;
Star star;
PVector[] missilesStartLocs;
PVector playerStartLoc;
ArrayList<Wall> walls;
ArrayList<Hazard> hazards;
ArrayList<Spring> springs;
ArrayList<Mist> mists;
ArrayList<Missile> missiles;
ArrayList<MissileLauncher> missileLaunchers;
ArrayList<float[]> bestTimes;
boolean[] keys;
boolean hasStar;
boolean beatLevelWithStar[];
boolean paused;
boolean shouldBreak;
int currentLevel;
int currentElement;
float[] minTime;
int restartTimer;

static final PVector NO_WAYPOINT = new PVector(-1, -1);

final color PLAYER_COLOR = color(0, 255, 0);
final color HAZARD_COLOR = color(255, 0, 0);
final color WALL_COLOR = color(0);
final color END_COLOR = color(0, 255, 255);
final color SPRING_COLOR = color(255, 0, 255);
final color STAR_COLOR = color(255, 255, 0);
final color MISSILELAUNCHER_COLOR = color(0, 0, 255);
final color MISSILE_COLOR = color(127.5, 0, 0);
final int FONT_SIZE = 24;
final int NUM_OF_LEVELS = 7;
final int MIST_SIZE = 5;

void setup()
{
  size(600, 600, P3D);
  smooth();
  noStroke();
  rectMode(CENTER);
  font = createFont("Arial", FONT_SIZE);
  textFont(font);
  keys = new boolean[4];
  paused = true;
  currentLevel = 1;
  currentElement = 0;
  minTime = new float[NUM_OF_LEVELS + 2];
  beatLevelWithStar = new boolean[NUM_OF_LEVELS + 2];
  for (int i = 1; i <= NUM_OF_LEVELS; i ++)
  {
    minTime[i] = 999999999;
    bestTimes.add(new float[NUM_OF_LEVELS + 2]);
    bestTimes.get(currentElement)[i] = 999999999;
    beatLevelWithStar[i] = false;
  }
  reset();
}

void reset()
{
  hasStar = false;
  walls = new ArrayList<Wall>();
  hazards = new ArrayList<Hazard>();
  springs = new ArrayList<Spring>();
  mists = new ArrayList<Mist>();
  missileLaunchers = new ArrayList<MissileLauncher>();
  missiles = new ArrayList<Missile>();
  missilesStartLocs = new PVector[6];
  if (currentLevel == 1)
  {
    playerStartLoc = new PVector(width / 2, height / 2 + 44);
    player = new Player(new PVector(playerStartLoc.x, playerStartLoc.y));
    walls.add(new Wall(new PVector(), new PVector(), new PVector(width / 2, 355), new PVector(100, 10), 0));
    walls.add(new Wall(new PVector(), new PVector(), new PVector(140, 400), new PVector(100, 10), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(200, 265), new PVector(100, 10), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(245, 355), new PVector(10, 10), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2 - 75, height), new PVector(1000, 10), 0));
    star = new Star(new PVector(), new PVector(), new PVector(215, 250), new PVector(), 0);
    end = new End(new PVector(), new PVector(), new PVector(140, 390), new PVector(), 0);
  }
  else if (currentLevel == 2)
  {
    playerStartLoc = new PVector(width / 2, height / 2 + 25);
    player = new Player(new PVector(playerStartLoc.x, playerStartLoc.y));
    walls.add(new Wall(new PVector(), new PVector(), new PVector(width / 2, 400), new PVector(100, 100), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(200, height / 2), new PVector(10, 999999999), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(400, height / 2), new PVector(10, 999999999), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(390, height / 2 - 570), new PVector(15, 15), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(390, height / 2 - 430), new PVector(15, 15), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2, height), new PVector(999999999, 10), 0));
    springs.add(new Spring(new PVector(), new PVector(), new PVector(width / 2, height / 2), new PVector(100, 100), new PVector(0, -1), 0.0));
    springs.add(new Spring(new PVector(), new PVector(), new PVector(width / 2, height / 2 - 450), new PVector(100, 100), new PVector(0, -1), 0));
    star = new Star(new PVector(), new PVector(), new PVector(210, height / 2 - 1275), new PVector(), 0);
    end = new End(new PVector(), new PVector(), new PVector(390, height / 2 - 500), new PVector(), 0);
  }
  else if (currentLevel == 3)
  {
    playerStartLoc = new PVector(width / 2, height / 2 + 45);
    player = new Player(new PVector(playerStartLoc.x, playerStartLoc.y));
    walls.add(new Wall(NO_WAYPOINT, new PVector(1400, 400), new PVector(width / 2 - 100, 400), new PVector(115, 10), 2.5));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2 + 100, 390), new PVector(10, 10), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2 + 300, 390), new PVector(50, 10), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2 + 500, 390), new PVector(100, 10), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2 + 700, 390), new PVector(150, 10), 0));
    hazards.add(new Hazard(new PVector(width / 2 + 775, 390), new PVector(width / 2 + 860, 390), new PVector(width / 2 + 715, 390), new PVector(10, 10), 2));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2 + 935, 390), new PVector(150, 10), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2 + 525, height), new PVector(2000, 10), 0));
    star = new Star(new PVector(), new PVector(), new PVector(width / 2 + 785, 390), new PVector(), 0);
    end = new End(new PVector(), new PVector(), new PVector(1400, 390), new PVector(), 0);
  }
  else if (currentLevel == 4)
  {
    playerStartLoc = new PVector(width / 2, 419);
    player = new Player(new PVector(playerStartLoc.x, playerStartLoc.y));
    walls.add(new Wall(new PVector(), new PVector(), new PVector(width / 2, 430), new PVector(10, 10), 0));
    walls.add(new Wall(new PVector(), new PVector(), new PVector(width / 2, 350), new PVector(10, 10), 0));
    walls.add(new Wall(new PVector(), new PVector(), new PVector(width / 2 + 550, 270), new PVector(800, 10), 0));
    hazards.add(new Hazard(new PVector(width / 2 - 100, 390), new PVector(width / 2 + 100, 390), new PVector(width / 2, 390), new PVector(155, 10), 4));
    hazards.add(new Hazard(new PVector(width / 2 + 100, 150), new PVector(width / 2 + 100, 350), new PVector(width / 2 + 100, 200), new PVector(10, 155), 4));
    hazards.add(new Hazard(new PVector(width / 2 + 250, 250), new PVector(width / 2 + 350, 250), new PVector(width / 2 + 250, 250), new PVector(10, 50), 3));
    hazards.add(new Hazard(new PVector(width / 2 + 350, 250), new PVector(width / 2 + 450, 250), new PVector(width / 2 + 350, 250), new PVector(10, 50), 3));
    hazards.add(new Hazard(new PVector(width / 2 + 450, 250), new PVector(width / 2 + 550, 250), new PVector(width / 2 + 450, 250), new PVector(10, 50), 3));
    hazards.add(new Hazard(new PVector(width / 2 + 550, 250), new PVector(width / 2 + 650, 250), new PVector(width / 2 + 550, 250), new PVector(10, 50), 3));
    hazards.add(new Hazard(new PVector(width / 2 + 650, 250), new PVector(width / 2 + 750, 250), new PVector(width / 2 + 650, 250), new PVector(10, 50), 3));
    hazards.add(new Hazard(new PVector(width / 2 + 750, 250), new PVector(width / 2 + 850, 250), new PVector(width / 2 + 750, 250), new PVector(10, 50), 3));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2 + 525, height), new PVector(2000, 10), 0));
    star = new Star(new PVector(width / 2 + 450, 220), new PVector(width / 2 + 550, 220), new PVector(width / 2 + 450, 220), new PVector(), 3);
    end = new End(new PVector(), new PVector(), new PVector(width / 2 + 875, 260), new PVector(), 0);
  }
  else if (currentLevel == 5)
  {
    playerStartLoc = new PVector(width / 2, height / 2);
    player = new Player(new PVector(playerStartLoc.x, playerStartLoc.y));
    walls.add(new Wall(NO_WAYPOINT, new PVector(width / 2, -275), new PVector(width / 2, 430), new PVector(100, 10), 1));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2, height), new PVector(2000, 10), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2 + 15, -100), new PVector(150, 5), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2 - 15, 25), new PVector(150, 5), 0));
    hazards.add(new Hazard(new PVector(width / 2 - 50, 200), new PVector(width / 2 + 50, 200), new PVector(width / 2, 200), new PVector(10, 100), 3));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2 + 60, 200), new PVector(10, 100), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2 - 60, 200), new PVector(10, 100), 0));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2, -185), new PVector(50, 10), 0));
    star = new Star(new PVector(), new PVector(), new PVector(width / 2 - 70, 225), new PVector(), 0);
    end = new End(new PVector(), new PVector(), new PVector(width / 2, -195), new PVector(), 0);
  }
  else if (currentLevel == 6)
  {
    playerStartLoc = new PVector(width / 2 - 22.5, height / 2);
    player = new Player(new PVector(playerStartLoc.x, playerStartLoc.y));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2, height + 100), new PVector(2000, 10), 0));
    missilesStartLocs[0] = new PVector(width / 2 - 5, height / 2 - 100);
    missileLaunchers.add(new MissileLauncher(new PVector(), new PVector(), new PVector(missilesStartLocs[0].x, missilesStartLocs[0].y), 80, 0));
    missilesStartLocs[1] = new PVector(width / 2 - 125, height / 2 - 215);
    missileLaunchers.add(new MissileLauncher(new PVector(), new PVector(), new PVector(missilesStartLocs[1].x, missilesStartLocs[1].y), 110, 0));
    missilesStartLocs[2] = new PVector(width / 2 + 85, height / 2 - 250);
    missileLaunchers.add(new MissileLauncher(new PVector(), new PVector(), new PVector(missilesStartLocs[2].x, missilesStartLocs[2].y), 135, 0));
    missilesStartLocs[3] = new PVector(width / 2 - 150, height / 2 - 70);
    missileLaunchers.add(new MissileLauncher(new PVector(), new PVector(), new PVector(missilesStartLocs[3].x, missilesStartLocs[3].y), 120, 0));
    walls.add(new Wall(new PVector(), new PVector(), new PVector(width / 2 - 25, 410), new PVector(150, 20), 0));
    walls.add(new Wall(NO_WAYPOINT, new PVector(width / 2 + 130, 535), new PVector(width / 2 + 145, 250), new PVector(5, 300), .25));
    walls.add(new Wall(new PVector(), new PVector(), new PVector(width / 2 + 260, 410), new PVector(50, 20), 0));
    star = new Star(new PVector(), new PVector(), new PVector(width / 2 - 5, height / 2 - 80), new PVector(), 0);
    end = new End(new PVector(), new PVector(), new PVector(width / 2 + 250, 395), new PVector(), 0);
  }
  else if (currentLevel == 7)
  {
    playerStartLoc = new PVector(width / 2 + 10, height / 2);
    player = new Player(new PVector(playerStartLoc.x, playerStartLoc.y));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2, height), new PVector(99999, 10), 0));
    hazards.add(new Hazard(new PVector(width / 2 - 55, height / 2 - 50), new PVector(width / 2 - 150, height / 2 - 50), new PVector(width / 2 - 55, height / 2 - 50), new PVector(10, 10), 2.5));
    hazards.add(new Hazard(new PVector(width / 2 - 250, height / 2 - 50), new PVector(width / 2 - 155, height / 2 - 50), new PVector(width / 2 - 250, height / 2 - 50), new PVector(10, 10), 2.5));
    hazards.add(new Hazard(new PVector(width / 2 - 255, height / 2 - 50), new PVector(width / 2 - 350, height / 2 - 50), new PVector(width / 2 - 255, height / 2 - 50), new PVector(10, 10), 2.5));
    hazards.add(new Hazard(new PVector(width / 2 - 450, height / 2 - 50), new PVector(width / 2 - 355, height / 2 - 50), new PVector(width / 2 - 450, height / 2 - 50), new PVector(10, 10), 2.5));
    hazards.add(new Hazard(new PVector(width / 2 - 455, height / 2 - 50), new PVector(width / 2 - 550, height / 2 - 50), new PVector(width / 2 - 455, height / 2 - 50), new PVector(10, 10), 2.5));
    hazards.add(new Hazard(new PVector(width / 2 - 650, height / 2 - 50), new PVector(width / 2 - 555, height / 2 - 50), new PVector(width / 2 - 650, height / 2 - 50), new PVector(10, 10), 2.5));
    hazards.add(new Hazard(new PVector(), new PVector(), new PVector(width / 2, height / 2), new PVector(10, 10), 0));
    missilesStartLocs[5] = new PVector(width / 2 + 40, height / 2);
    //missileLaunchers.add(new MissileLauncher(new PVector(), new PVector(), new PVector(missilesStartLocs[5].x, missilesStartLocs[5].y), 60, 0));
    walls.add(new Wall(new PVector(), new PVector(), new PVector(width / 2 - 995, height / 2 + 10), new PVector(2020, 10), 0));
    walls.add(new Wall(new PVector(), new PVector(), new PVector(width / 2 + 780, height / 2 + 10), new PVector(500, 10), 0));
    springs.add(new Spring(new PVector(), new PVector(), new PVector(width / 2 + 780, height / 2 - 8), new PVector(500, 10), new PVector(-.225, 0), 0));
    springs.add(new Spring(new PVector(), new PVector(), new PVector(width / 2 - 995, height / 2 - 8), new PVector(1980, 10), new PVector(.225, 0), 0));
    star = new Star(NO_WAYPOINT, new PVector(width / 2 + 1030, height / 2), new PVector(width / 2 + 283, height / 2), new PVector(), 1);
  }
  currentElement ++;
}

void draw()
{
  restartTimer ++;
  background(127.5);
  if (currentLevel > NUM_OF_LEVELS)
  {
    fill(255);
    textAlign(CENTER, CENTER);
    text("CONGRATZ!", player.loc.x, player.loc.y);
    if (restartTimer >= 180)
    {
      currentLevel = NUM_OF_LEVELS;
      restartTimer = 0;
      reset();
    }
  }
  else
  {
    if (paused)
    {
      for (Hazard h : hazards)
        h.show();
      for (MissileLauncher mL : missileLaunchers)
        mL.show();
      for (Missile m : missiles)
      {
        if (m.exists)
          m.show();
      }
      for (Spring s : springs)
        s.show();
      for (Wall w : walls)
        w.show();
      if (!hasStar)
        star.show();
      end.show();
      camera(player.loc.x, player.loc.y, height / 2 / tan(PI * 30 / 180) * .9, player.loc.x, player.loc.y, 0, 0, 1, 0);
      fill(255);
      textAlign(LEFT, TOP);
      text("Best Completion Times:", player.loc.x - (width / 2) + 30, player.loc.y - (height / 2) + 30);
      for (int i = 1; i <= NUM_OF_LEVELS; i ++)
      {
        if (minTime[i] == 999999999)
          text("Level " + i + ": Not complete", player.loc.x - (width / 2) + 30, player.loc.y - (height / 2) + (FONT_SIZE * i) + 30);
        else
          text("Level " + i + ": " + minTime[i], player.loc.x - (width / 2) + 30, player.loc.y - (height / 2) + (FONT_SIZE * i) + 30);
      }
      textAlign(RIGHT, TOP);
      text("Dot Collected:", player.loc.x + (width / 2) - 30, player.loc.y - (height / 2) + 30);
      for (int i = 1; i <= NUM_OF_LEVELS; i ++)
      {
        if (beatLevelWithStar[i])
          text("Level " + i + ": True", player.loc.x + (width / 2) - 30, player.loc.y - (height / 2) + (FONT_SIZE * i) + 30);
        else
          text("Level " + i + ": False", player.loc.x + (width / 2) - 30, player.loc.y - (height / 2) + (FONT_SIZE * i) + 30);
      }
    }
    else 
    {
      for (Hazard h : hazards)
      {
        h.run();
        h.show();
      }
      for (MissileLauncher mL : missileLaunchers)
      {
        mL.run();
        mL.show();
      }
      for (int i = 0; i <= missileLaunchers.size() - 1; i ++)
      {
        MissileLauncher mL = missileLaunchers.get(i);
        if (mL.shootTimer >= mL.shootTimerDeadline)
        {
          mL.shootTimer = 0;
          missiles.add(new Missile(new PVector(mL.loc.x, mL.loc.y)));
        }
      }
      for (Missile m : missiles)
      {
        if (!m.exists)
        {
          missiles.remove(m);
          break;
        }
      }
      for (Missile m : missiles)
      {
        if (m.exists)
        {
          m.run();
          m.show();
        }
      }
      for (Spring s : springs)
      {
        s.run();
        s.show();
      }
      for (Wall w : walls)
      {
        w.run();
        w.show();
      }
      if (!hasStar)
      {
        star.run();
        star.show();
      }
      end.run();
      end.show();
      player.run();
      camera(player.loc.x, player.loc.y, height / 2 / tan(PI * 30 / 180) * .9, player.loc.x, player.loc.y, 0, 0, 1, 0);
      float minDistToMissile = 9999999;
      for (Wall w : walls)
      {
        for (int x = int(w.loc.x - (w.wallSize.x / 2) - (player.loc.x - (width / 2))); x <= int(w.loc.x + (w.wallSize.x / 2) - (player.loc.x - (width / 2))); x ++)
        {
          for (int y = int(w.loc.y - (w.wallSize.y / 2) - (player.loc.y - (height / 2))); y <= int(w.loc.y + (w.wallSize.y / 2) - (player.loc.y - (height / 2))); y ++)
          {
            if (get(x, y) == MISSILE_COLOR)
            {
              for (Missile m : missiles)
              {
                if (w.loc.dist(m.loc) < minDistToMissile)
                  minDistToMissile = w.loc.dist(m.loc);
              }
              for (Missile m : missiles)
              {
                if (w.loc.dist(m.loc) == minDistToMissile)
                  m.exists = false;
              }
            }
          }
        }
      }
      minDistToMissile = 9999999;
      for (Spring s : springs)
      {
        for (int x = int(s.loc.x - (s.springSize.x / 2) - (player.loc.x - (width / 2))); x <= int(s.loc.x + (s.springSize.x / 2) - (player.loc.x - (width / 2))); x ++)
        {
          for (int y = int(s.loc.y - (s.springSize.y / 2) - (player.loc.y - (height / 2))); y <= int(s.loc.y + (s.wallSize.y / 2) - (player.loc.y - (height / 2))); y ++)
          {
            if (get(x, y) == MISSILE_COLOR)
            {
              for (Missile m : missiles)
              {
                if (s.loc.dist(m.loc) < minDistToMissile)
                  minDistToMissile = s.loc.dist(m.loc);
              }
              for (Missile m : missiles)
              {
                if (s.loc.dist(m.loc) == minDistToMissile)
                  m.vel.add(s.springVel);
              }
            }
          }
        }
      }
      bestTimes.get(currentElement)[currentLevel] += 1 / frameRate;
      fill(255);
      textAlign(LEFT, TOP);
      text(bestTimes.get(currentElement)[currentLevel], player.loc.x - (width / 2) + 25, player.loc.y - (height / 2) + 30);
    }
    player.show();
  }
  for (Spring s : springs)
  {
    if (s.mistNumCurrent < s.springSize.x * s.springSize.y / 75)
      mists.add(new Mist(PVector.add(s.springVel, s.vel), new PVector(random(s.loc.x - (s.springSize.x / 2) + (MIST_SIZE / 2), s.loc.x + (s.springSize.x / 2) - (MIST_SIZE / 2)), random(s.loc.y - (s.springSize.y / 2) + (MIST_SIZE / 2), s.loc.y + (s.springSize.y / 2) - (MIST_SIZE / 2)))));
    s.mistNumCurrent = 0;
    for (Mist m : mists)
    {
      if (m.exists && m.loc.x - (MIST_SIZE / 2) > s.loc.x + (s.springSize.x / 2) && m.loc.x + (MIST_SIZE / 2) < s.loc.x - (s.springSize.x / 2) && m.loc.y - (MIST_SIZE / 2) > s.loc.y + (s.springSize.y / 2) && m.loc.y + (MIST_SIZE / 2) < s.loc.y - (s.springSize.y / 2))
        s.mistNumCurrent ++;
    }
  }
  for (int i = 0; i <= mists.size() - 1; i ++)
  {
    Mist m = mists.get(i);
    if (!m.exists)
      mists.remove(i);
  }
  for (Mist m : mists)
  {
    if (m.exists)
    {
      m.run();
      m.show();
      if (get(int(m.loc.x - (MIST_SIZE / 2) - (player.loc.x - (width / 2))), int(m.loc.y - (MIST_SIZE / 2) - (player.loc.y - (height / 2)))) != SPRING_COLOR)
        m.exists = false;
    }
  }
}

void keyPressed()
{
  if (keyCode == LEFT)
    keys[0] = true;
  else if (keyCode == RIGHT)
    keys[1] = true;
  else if (keyCode == UP)
    keys[2] = true;
  else if (key == 'r' && !paused)
    reset();
  else if (key == '1')
  {
    currentLevel = 1;
    reset();
  }
  else if (key == '2')
  {
    currentLevel = 2;
    reset();
  }
  else if (key == '3')
  {
    currentLevel = 3;
    reset();
  }
  else if (key == '4')
  {
    currentLevel = 4;
    reset();
  }
  else if (key == '5')
  {
    currentLevel = 5;
    reset();
  }
  else if (key == '6')
  {
    currentLevel = 6;
    reset();
  }
  else if (key == '7')
  {
    currentLevel = 7;
    reset();
  }
  else if (key == 'p')
    paused = !paused;
}

void keyReleased()
{
  if (keyCode == LEFT)
    keys[0] = false;
  else if (keyCode == RIGHT)
    keys[1] = false;
  else if (keyCode == UP)
    keys[2] = false;
}

