color purp = color(138, 122, 255);
color purpOpaque = color(138, 122, 255, 0.005);
color turq = color(150, 255, 255);
color purpPink = color(218, 153, 255);

int ellipseWidth;

void setup () {
  //fullScreen();
  size(800, 600);
  
  ellipseWidth = width / 8;
  
  // werden hier nur ein mal gezeichnet und unten dann ueberzeichnet
  strokeWeight(5);
  
  frameRate(5);
  
  stroke(turq);
  fill(purpPink);
  ellipse(width / 2, height / 2, ellipseWidth, ellipseWidth);
}

void draw () {
  background(purpOpaque);
  
  line (pmouseX, pmouseY, mouseX, mouseY);
}
