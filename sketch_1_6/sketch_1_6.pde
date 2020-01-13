void setup () {
  fullScreen();
  //size(400, 400);
  
}

void draw () {

  //background (0, 0, 255);
  frameRate(15);
  
  // line interactive
  strokeWeight(10);
  stroke(frameCount * 5 % 255, 0, 255, 180);
  println(frameCount, frameCount % 255);
  fill(150 + frameCount % 155, 150 + frameCount % 155,(frameCount % 255) + 50, 15);
  ellipse(random(0,400), height * (1 + random(0,1)), mouseX, mouseX);
}
