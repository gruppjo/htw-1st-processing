void setup () {
  fullScreen();
  //size(400, 400);
  
}

void draw () {

  background (0, 0, 255);
  noStroke();

  
  // line interactive
  ellipse(width/2, height/2, mouseX, mouseX);
  ellipse(100,100,  mouseX * 0.3, mouseX * 0.3);
  
    
  // stroke options
  strokeWeight(5);
  stroke(0, 0, 255);
  fill(255, 0, 255);
  line(400,0, 0, 400);
  
  noStroke();
  ellipse(300, 300, mouseY* 0.5, mouseY*0.5);
}
