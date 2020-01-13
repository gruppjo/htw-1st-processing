color purp = color(138, 122, 255);
color turq = color(150, 255, 255);
color purpPink = color(218, 153, 255);

int ellipseWidth;

void setup () {
  //fullScreen();
  size(800, 600);
  
  ellipseWidth = width / 8;
  
  // werden hier nur ein mal gezeichnet und unten dann ueberzeichnet
  strokeWeight(5);
  background(purp);
  
  stroke(turq);
  fill(purpPink);
  ellipse(width / 2, height / 2, ellipseWidth, ellipseWidth);
}

void draw () {
  
  ellipse(width * 2/3, mouseY, ellipseWidth * 2/3, ellipseWidth * 2/3);
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
  //point (mouseX, mouseY);
  
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
