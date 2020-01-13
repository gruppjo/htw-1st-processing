void setup () {
  fullScreen();
  //size(400, 400);
  
}

void draw () {

  //background (0, 0, 255);
  
  // line interactive
  strokeWeight(10);
  stroke(0, 0, 255);
  fill((frameCount / 60) % 255,255,255,5);
  ellipse(random(0,400), height/2, mouseX, mouseX);
}
