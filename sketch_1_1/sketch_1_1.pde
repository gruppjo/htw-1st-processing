void setup () {
  //fullScreen();
  size(400, 400);
  
}

void draw () {

  background (255, 255, 0);
  
  // stroke options
  strokeWeight(5);
  stroke(0, 0, 255);
  fill(255, 0, 255);
  
  // line interactive
  ellipse(200, 200, 300, 300);
  ellipse(100,100, 100,100);
  line(400,0, 0, 400);
  ellipse(300, 300, 100, 100);
}
