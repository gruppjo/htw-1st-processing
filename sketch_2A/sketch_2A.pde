
void setup() {
  size (600, 600);
}
int strokeBaseWeight = 100;

void draw() {
  background(255);
  int strokeWeight;
  //int strokeWeight = strokeBaseWeight - frameCount % strokeBaseWeight;
  int strokeDirection = frameCount / strokeBaseWeight % 2;
  if (strokeDirection == 0) {
    strokeWeight = frameCount % strokeBaseWeight;
  }
  else {
    strokeWeight = strokeBaseWeight - frameCount % strokeBaseWeight;
  }
  
  //int strokeWeight = strokeBaseWeight;
  //int lineLengthHalf = 150 - frameCount % 70;
  int lineLengthHalf = 150;
  //float offsetX = random(-50, 50);
  float offsetX = 0;
  int offsetDirection = frameCount * 2 / 50 % 2;
  if (offsetDirection == 0) {
    offsetX = frameCount * 2 % 50;
  }
  else {
    offsetX = 50 - frameCount * 2 % 50;
  }
  strokeWeight(strokeWeight);
  println(strokeWeight);
  
  line(width/2 - lineLengthHalf + offsetX, height/2 - lineLengthHalf, width/2 + lineLengthHalf, height/2 + lineLengthHalf);
  line(width/2 + lineLengthHalf + offsetX, height/2 - lineLengthHalf, width/2 - lineLengthHalf, height/2 + lineLengthHalf);
}
