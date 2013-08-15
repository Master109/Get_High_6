class Mist
{
  PVector vel1, vel2, loc;
  boolean exists;

  Mist(PVector vel1, PVector loc)
  {
    this.vel1 = vel1;
    this.vel2 = new PVector();
    this.loc = loc;
    this.exists = true;
  }

  void show()
  {
    strokeWeight(MIST_SIZE);
    stroke(127.5);
    point(loc.x, loc.y);
    noStroke();
  }

  void run()
  {
    vel2.add(vel1);
    loc.add(vel2);
  }
}

