void setup () {
  fullScreen();
  //size(400, 400);
  
}

void draw () {

  //background (0, 0, 255);
  //frameRate(15);
  
  // line interactive
  strokeWeight(10);
  colorMode(RGB);
  stroke(frameCount * 5 % 255, 0, 255, 180);
  println(frameCount, frameCount % 255);
  colorMode(HSB, 360, 100, 100);
  fill(150 + frameCount/4 % 100, 100, 100, 25);
  ellipse(random(0,400), height * (1 + random(0,1)), mouseX, mouseX);
}
