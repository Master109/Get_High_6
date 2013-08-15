class Missile
{
  PVector vel, loc, missileSize;
  float speed, curvatureLimit;
  boolean exists;

  Missile(PVector loc)
  { 
    this.vel = PVector.sub(player.loc, loc);
    this.loc = loc;
    this.missileSize = new PVector(15, 15);
    this.speed = 4.75;
    this.curvatureLimit = .525;
    this.exists = true;
  }

  void show()
  {
    PVector direction = PVector.sub(player.loc, loc);
    fill(MISSILE_COLOR);
    translate(loc.x, loc.y);
    rotate(vel.heading2D());
    triangle(0, missileSize.y / 3, missileSize.x, 0, 0, -(missileSize.x / 3));
    rotate(-vel.heading2D());
    translate(-loc.x, -loc.y);
  }

  void run()
  {
    PVector direction = PVector.sub(player.loc, loc);
    direction.limit(curvatureLimit);
    vel.add(direction);
    vel.setMag(speed);
    loc.add(vel);
  }
}

