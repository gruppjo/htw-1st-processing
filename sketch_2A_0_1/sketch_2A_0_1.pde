
void setup() {
  size (600, 600);
}
int strokeBaseWeight = 100;

void draw() {
  background(255);
  //int strokeWeight = strokeBaseWeight - frameCount * 5 % strokeBaseWeight;
  int strokeWeight = strokeBaseWeight;
  int lineLengthHalf = 150 - frameCount % 70;
  //int lineLengthHalf = 150;
  //float offsetX = random(-50, 50);
  float offsetX = 0;

  strokeWeight(strokeWeight);
  println(strokeWeight);
  
  line(width/2 - lineLengthHalf + offsetX, height/2 - lineLengthHalf, width/2 + lineLengthHalf, height/2 + lineLengthHalf);
  line(width/2 + lineLengthHalf + offsetX, height/2 - lineLengthHalf, width/2 - lineLengthHalf, height/2 + lineLengthHalf);
}
