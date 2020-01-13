void setup () {
  fullScreen();
  // size(400, 400);
  
  // werden hier nur ein mal gezeichnet und unten dann ueberzeichnet
  strokeWeight(5);
  point(300, 300);
  point(200, 0);
}

void draw () {
  // background / reset
  // background (255);
  
  // stroke options
  strokeWeight(5);
  //stroke(mouseX % 255, 100, 100);
  stroke(mouseX % 255, 0, 100);
  
  // point
  //point(200, 200);
  //point(600, 0);
  
  // point interactive
  point (mouseX, mouseY);
  
  // line
  //line(200, 50, 400, 350);
  
  // output
  //println(mouseX, mouseY);
 
  // line interactive
  //line(50, 250, mouseX, mouseY);
  //line(mouseX, mouseY, 1500, 250);
  //line(mouseX, mouseY, 500, -150);
  //line(mouseX, mouseY, 750, 2000);
}
