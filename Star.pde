class Star extends Hazard
{
  PVector wayPoint0, wayPoint1, vel, loc, starSize;
  float speed;

  Star(PVector wayPoint0, PVector wayPoint1, PVector loc, PVector starSize, float speed)
  {
    super(wayPoint0, wayPoint1, loc, starSize, speed);
    this.wayPoint0 = wayPoint0;
    this.wayPoint1 = wayPoint1;
    this.vel = new PVector();
    this.loc = loc;
    this.starSize = new PVector(10, 10);
    this.speed = speed;
  }

  void show()
  {
    fill(STAR_COLOR);
    ellipse(loc.x, loc.y, starSize.x, starSize.y);
  }

  void run()
  {
    if (loc.dist(wayPoint0) <= speed || vel.equals(new PVector()))
      vel.add(PVector.sub(wayPoint1, loc));
    if (loc.dist(wayPoint1) <= speed)
    {
      if (!wayPoint0.equals(NO_WAYPOINT))
        vel.add(PVector.sub(wayPoint0, loc)); 
      else
        vel.set(0, 0, 0);
    }
    vel.setMag(speed);
    loc.add(vel);
  }
}

