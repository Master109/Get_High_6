class MissileLauncher
{
  PVector wayPoint0, wayPoint1, loc, vel, missileLauncherSize;
  int shootTimer, shootTimerDeadline;
  float speed;

  MissileLauncher(PVector wayPoint0, PVector wayPoint1, PVector loc, int shootTimerDeadline, float speed)
  {
    this.wayPoint0 = wayPoint0;
    this.wayPoint1 = wayPoint1;
    this.vel = PVector.sub(player.loc, loc);
    this.loc = loc;
    this.missileLauncherSize = new PVector(25, 25);
    this.speed = speed;
    this.shootTimerDeadline = shootTimerDeadline;
  }

  void show()
  {
    PVector direction = PVector.sub(player.loc, loc);
    fill(MISSILELAUNCHER_COLOR);
    translate(loc.x, loc.y);
    rotate(direction.heading2D());
    triangle(0, missileLauncherSize.y / 3, missileLauncherSize.x, 0, 0, -(missileLauncherSize.x / 3));
    rotate(-direction.heading2D());
    translate(-loc.x, -loc.y);
  }

  void run()
  {
    shootTimer ++;
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

