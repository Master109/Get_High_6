class End extends Wall
{
  PVector loc, endSize;

  End(PVector wayPoint0, PVector wayPoint1, PVector loc, PVector endSize, float speed)
  {
    super(wayPoint0, wayPoint1, loc, endSize, speed);
    this.loc = loc;
    this.endSize = new PVector(10, 10);
  }

  void show()
  {
    fill(END_COLOR);
    rect(loc.x, loc.y, endSize.x, endSize.y);
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

