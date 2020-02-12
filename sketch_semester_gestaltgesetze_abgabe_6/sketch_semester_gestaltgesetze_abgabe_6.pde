

//
//
// GLOBALS
//
//

// SLOW & LARGER

//float elementWidthHeightPercentage = 11 / (float)10;

//float rotationSpeed = 1 / (float)225 ; // based on frameCount / rotationSpeed
//int animateDuration = 1000; // in ms

//int offsetDistance = 15;

// FASTER & SMALLER
float elementWidthHeightPercentage = 8 / (float)9;

float rotationSpeed = 1 / (float)175 ; // based on frameCount / rotationSpeed
int animateDuration = 700; // in ms
float clickBuffer = 1.7;

int offsetDistance = 15;

// COLORS
//color colorBase = color(2,30,115); // darkblue
//color colorHighlight = color(4, 46, 255); // brightblue
//color colorBackground = color(242, 226, 5); // bright yellow

color colorBackground = color(242, 226, 5); // bright yellow
color colorBase = color(243, 202, 5); // darker yellow
color colorHighlight = color(4, 46, 255); // brightblue


int colorPalette = 1;
color[] colorPalette0 = {
  color(0, 0, 0), // brightblue   /* BACKGROUND */
  color(255, 255, 0), // darker yellow      /* BASE */
  color(255, 0, 255), // bright yellow        /* HIGHLIGHT */
};
//color[] colorPalette1 = {
//  color(242, 226, 5), // bright yellow    /* BACKGROUND */
//  color(243,202,5), // darker yellow          /* BASE */
//  color(4, 46, 255), // brightblue        /* HIGHLIGHT */
//};
color[] colorPalette1 = {
  color(242, 226, 5), // bright yellow    /* BACKGROUND */
  color(243, 202, 5), // darker yellow          /* BASE */
  color(4, 46, 255), // brightblue        /* HIGHLIGHT */
};
//color[] colorPalette2 = {
//  color(4, 196, 217), // darker yellow   /* BACKGROUND */
//  color(4, 217, 79), // brightblue      /* BASE */
//  color(242, 5, 48), // bright yellow        /* HIGHLIGHT */
//};
color[] colorPalette2 = {
  color(255, 179, 222), // darker yellow   /* BACKGROUND */
  color(52, 242, 169), // brightblue      /* BASE */
  color(222, 69, 155), // bright yellow        /* HIGHLIGHT */
};

boolean colorToggle = false;

// elements
ElementsController elementsController;

class ElementBase {
  int eX;
  int eY;
  int eWidth;
  int eHeight;
  int eRadius;
  color eColor;

  // animating color
  boolean animatingColor = false;
  float animateColorPercent = 0; // 0 - 1
  int animateColorStartTime = 0;
  color eColorOrigin;
  color eColorTarget;

  // animating offset
  boolean animatingOffset = false;
  float animateOffsetPercent = 0; // 0 - 1
  int animateOffsetStartTime = 0;
  int[] eOffset = {0, 0};
  int[] eOffsetOrigin;
  int[] eOffsetTarget;

  ElementBase(int xInput, int yInput, int widthInput, int heightInput, color colorInput) {
    eX = xInput;
    eY = yInput;
    eWidth = widthInput;
    eHeight = heightInput;
    eRadius = eWidth / 14;
    eColor = colorInput;
  }

  void draw() {
    int now = millis();
    if (animatingColor) {
      //println("animating", animateStartTime, animateDuration, now);

      // stop animating
      if (animateColorStartTime + animateDuration < now) {
        //println("stop");
        animatingColor = false;
        animateColorPercent = 0;
        animateColorStartTime = 0;
        eColor = eColorTarget;
      }

      // animating
      if (animatingColor) {
        //println("perform animating");
        //println(now - animateStartTime, animateDuration, animatePercent);
        //println(animatePercent);

        animateColorPercent = float(now - animateColorStartTime) / animateDuration;

        eColor = gColorAnimate(eColorOrigin, eColorTarget, animateColorPercent);
      }
    }

    if (animatingOffset) {
      //println("animating", animateStartTime, animateDuration, now);

      // stop animating
      if (animateOffsetStartTime + animateDuration < now) {
        //println("stop");
        animatingOffset = false;
        animateOffsetPercent = 0;
        animateOffsetStartTime = 0;
        eOffset = eOffsetTarget;
      }

      // animating
      if (animatingOffset) {
        //println("perform animating");
        //println(now - animateStartTime, animateDuration, animatePercent);
        //println(animatePercent);

        animateOffsetPercent = float(now - animateOffsetStartTime) / animateDuration;

        eOffset = gOffsetAnimate(eOffsetOrigin, eOffsetTarget, animateOffsetPercent);
      }
    }

    rectMode(CENTER);
    pushMatrix();
    translate(eX + eOffset[0], eY + eOffset[1]);
    drawInternal();
    popMatrix();
  }
  void drawInternal() {
    strokeWeight(3);
    stroke(eColor);
    fill(255, 255, 255, 75);
    rect(0, 0, eWidth, eHeight, eRadius);
  }
  void animateColor(color colorTarget) {
    animatingColor = true;
    animateColorStartTime = millis();
    eColorOrigin = eColor;
    eColorTarget = colorTarget;
    //println(animateStartTime, animateDuration);
  }
  void animateOffset(int x, int y) {
    animatingOffset = true;
    animateOffsetStartTime = millis();
    eOffsetOrigin = eOffset;
    int[] offset = {x, y};
    eOffsetTarget = offset;
  }
  boolean isClicked() {
    if ( (mouseX > eX - eWidth * clickBuffer / 2 && mouseX < eX - clickBuffer + eWidth / 2) 
      && (mouseY > eY - eHeight * clickBuffer / 2 && mouseY < eY - clickBuffer + eHeight / 2)
      ) {
      return true;
    } else {
      return false;
    }
  }
}


class Element extends ElementBase {

  boolean rotating = true;

  Element(int xInput, int yInput, int widthInput, int heightInput, color colorInput) {
    super(xInput, yInput, widthInput, heightInput, colorInput);
    eRadius = eWidth / 4;
  }

  void drawInternal() {
    translate(eWidth / 2, eHeight / 2);
    pushMatrix();
    if (rotating) {
      rotate(2 * PI * frameCount * rotationSpeed);
    }

    noStroke();
    fill(eColor);
    rect(0, 0, eWidth * elementWidthHeightPercentage, eHeight * elementWidthHeightPercentage, eRadius);
    popMatrix();
  }
}

class ElementText extends ElementBase {
  String eText;
  ElementText(int xInput, int yInput, int widthInput, int heightInput, color colorInput, String textInput) {
    super(xInput, yInput, widthInput, heightInput, colorInput);
    eText = textInput;
  }

  void drawInternal() {
    fill(eColor);
    text(eText, 0, 0);
  }
}


class ElementsController {
  int paddingTop;
  int paddingBottom;
  int paddingLeft;
  int paddingRight;

  int widthHeight = 100;
  int columns;
  int rows;

  int columnWidth;
  int rowHeight;
  int eWidth;
  int eHeight;

  // NAV

  // principles
  ElementBase elementMode1;
  ElementBase elementMode2;
  ElementBase elementMode3;

  ElementText elementText1;
  ElementText elementText2;
  ElementText elementText3;

  // user / auto
  ElementBase elementUser;
  ElementBase elementAuto;

  ElementBase elementTextUser;
  ElementBase elementTextAuto;

  // colors
  ElementBase elementColor1;
  ElementBase elementColor2;
  ElementBase elementColor3;

  ElementBase elementTextColor1;
  ElementBase elementTextColor2;
  ElementBase elementTextColor3;

  // ROTATING ELEMENTS
  Element[] elements;

  Element elementClicked;
  Element elementRandom;

  Element[] elementsContinuity;

  Element[] elementsProximity;

  boolean mode1;
  boolean mode2 = true;
  boolean mode3;

  ElementsController() {
    paddingLeft = paddingRight = width / 19;
    paddingTop = paddingBottom = height / 12;

    columns = round((width - 2 * paddingLeft) / widthHeight);
    rows = round((height - 2 * paddingBottom) / widthHeight);

    columnWidth = round((width - 2 * paddingLeft) / columns);
    rowHeight = round((height - 2 * paddingBottom) / rows);

    paddingLeft = paddingRight = (width - columns * columnWidth) / 2;
    paddingTop = paddingBottom = (height - rows * rowHeight) / 2;
    //println(width, columns*columnWidth, paddingLeft, paddingRight);
    //println(height, rows*rowHeight, paddingTop, paddingBottom);
  }

  void createElements() {
    // NAV
    elementMode1 = new ElementBase((int)((float)width / (float)5), 0, 275, 85, colorBase);
    elementText1 = new ElementText(width / 5 - 92, 27, 0, 0, colorBase, "Law of Continuity");
    elementMode2 = new ElementBase(width / 2, 0, 275, 85, colorHighlight);
    elementText2 = new ElementText(width / 2 - 90, 27, 0, 0, colorHighlight, "Law of Similarity");
    elementMode3 = new ElementBase((int)((float)width * (float)4 / (float)5), 0, 275, 85, colorBase);
    elementText3 = new ElementText(width * 4 / 5 - 85, 27, 0, 0, colorBase, "Law of Proximity");

    elementUser = new ElementBase(0, (int)((float)height * (float)2), 85, 175, colorBase);
    elementTextUser = new ElementText(0, (int)((float)height * (float)2), 0, 0, colorBase, "User");

    elementColor1 = new ElementBase((int)((float)width / (float)5), height, 275, 85, colorBase);
    elementTextColor1 = new ElementText(width / 5 - 96, height - 10, 0, 0, colorBase, "Colors of Contrast");
    elementColor2 = new ElementBase(width / 2, height, 310, 85, colorHighlight);
    elementTextColor2 = new ElementText(width / 2 - 115, height - 10, 0, 0, colorHighlight, "Colors of Rain Jacket");
    elementColor3 = new ElementBase((int)((float)width * (float)4 / (float)5), height, 275, 85, colorBase);
    elementTextColor3 = new ElementText(width * 4 / 5 - 83, height - 10, 0, 0, colorBase, "Colors of Happy");



    // ELEMENTS
    elements = new Element[columns*rows];

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        int index = r * columns + c;
        int x = c * columnWidth;
        int y = r * rowHeight;
        elements[index] = new Element(x, y, columnWidth, rowHeight, colorBase);
      }
    }
  }

  void drawElements() {
    rectMode(CENTER);

    elementMode1.draw();
    elementText1.draw();
    elementMode2.draw();
    elementText2.draw();
    elementMode3.draw();
    elementText3.draw();

    elementUser.draw();
    elementTextUser.draw();

    elementColor1.draw();
    elementTextColor1.draw();
    elementColor2.draw();
    elementTextColor2.draw();
    elementColor3.draw();
    elementTextColor3.draw();

    pushMatrix();
    translate(paddingLeft, paddingTop);
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        int index = r * columns + c;
        elements[index].draw();
      }
    }
    popMatrix();
  }

  Element getElement(int column, int row) {
    int index = row * columns + column;
    if (index >= 0 && index <= elements.length - 1) {
      return elements[index];
    } else {
      return null;
    }
  }

  void resetElements() {
    // reset helper vars
    if (elementClicked != null) {
      elementClicked.animateColor(colorBase);
      elementClicked = null;
    }
    if (elementRandom != null) {
      elementRandom.animateColor(colorBase);
      elementRandom = null;
    }

    // reset elements
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < columns; c++) {
        int index = r * columns + c;
        elements[index].animateColor(colorBase);
        elements[index].animateOffset(0, 0);
        elements[index].rotating = true;
      }
    }
    if (elementsContinuity != null) {
      elementsContinuity = null;
    }
    if (elementsProximity != null) {
      elementsProximity = null;
    }
  }

  void setNavElement(int number) {
    if (number == 1 && mode1 == false) {
      mode1 = true;
      elementMode1.animateColor(colorHighlight);
      elementText1.animateColor(colorHighlight);

      // reset
      mode2 = false;
      elementMode2.animateColor(colorBase);
      elementText2.animateColor(colorBase);
      mode3 = false;
      elementMode3.animateColor(colorBase);
      elementText3.animateColor(colorBase);
    } else if (number == 2 && mode2 == false) {
      mode2 = true;
      elementMode2.animateColor(colorHighlight);
      elementText2.animateColor(colorHighlight);

      // reset
      mode1 = false;
      elementMode1.animateColor(colorBase);
      elementText1.animateColor(colorBase);
      mode3 = false;
      elementMode3.animateColor(colorBase);
      elementText3.animateColor(colorBase);
    } else if (number == 3 && mode3 == false) {
      mode3 = true;
      elementMode3.animateColor(colorHighlight);
      elementText3.animateColor(colorHighlight);

      // reset
      mode1 = false;
      elementMode1.animateColor(colorBase);
      elementText1.animateColor(colorBase);
      mode2 = false;
      elementMode2.animateColor(colorBase);
      elementText2.animateColor(colorBase);
    } else {
      println("nav does not exist");
    }
  }


  void mousePressed() {
    int insideX = mouseX - paddingLeft;
    int insideY = mouseY - paddingTop;

    println(insideX, insideY);

    // top nav
    if (insideX > 0 && insideY < 0) {
      if (elementMode1.isClicked()) {
        println("mode1");
        setNavElement(1);
        resetElements();
      } else if (elementMode2.isClicked()) {
        println("mode2");
        setNavElement(2);
        resetElements();
      } else if (elementMode3.isClicked()) {
        println("mode3");
        setNavElement(3);
        resetElements();
      } else {
        println("nothing clicked");
      }
      return;
    }
    // bottom nav
    else if (mouseY > height - paddingTop) {
      println("bottom nav");
      if (elementColor1.isClicked()) {
        gChangeColor(0);
      } else if (elementColor2.isClicked()) {
        gChangeColor(1);
      } else if (elementColor3.isClicked()) {
        gChangeColor(2);
      }
    }

    float columnFloat = insideX / (float)columnWidth;
    float rowFloat = insideY / (float)rowHeight;
    int columnInt = floor(columnFloat);
    int rowInt = floor(rowFloat);
    float columnRest = columnFloat - (float)columnInt;
    float rowRest = rowFloat - (float)rowInt;
    float columnPosition = columnRest * columnWidth;
    float rowPosition = rowRest * rowHeight;

    float cellPadding = ((float)1 - (float)elementWidthHeightPercentage) / (float)2 * columnWidth;

    //println("column", cellPadding);
    //println("row", rowInt);

    if (getElement(columnInt, rowInt) == null) {
      return;
    }

    if (columnPosition > cellPadding && columnPosition < columnWidth - cellPadding
      && rowPosition > cellPadding && rowPosition < rowHeight - cellPadding) {
      //println("clicked");

      elementWasClicked(columnInt, rowInt);
    }
  }

  void elementWasClicked(int columnIndex, int rowIndex) {
    if (mode1) {
      // cleanupprevious
      if (elementsContinuity != null) {
        for (int e = 0; e < elementsContinuity.length; e++) {
          elementsContinuity[e].rotating = true;
          elementsContinuity[e].animateColor(colorBase);
        }
        elementsContinuity = null;
      }
      Element[] selectedElements = new Element[1];
      selectedElements[0] = getElement(columnIndex, rowIndex);
      elementsContinuity = selectedElements;

      // find new ones
      float columnMedian = columns / 2;
      float rowMedian = rows / 2;
      int dirUpColumnIncrement = 0;
      int dirUpRowIncrement = 0;
      int dirDownColumnIncrement = 0;
      int dirDownRowIncrement = 0;
      // Q1 || Q4
      if (
        columnIndex < columnMedian && rowIndex < rowMedian
        || columnIndex >= columnMedian && rowIndex >= rowMedian
        ) {
        dirUpColumnIncrement = - 1;
        dirUpRowIncrement = - 1;
        dirDownColumnIncrement = + 1;
        dirDownRowIncrement = + 1;
      }
      // Q2 || Q3
      else if (
        columnIndex >= columnMedian && rowIndex < rowMedian
        || columnIndex < columnMedian && rowIndex >= rowMedian
        ) {
        dirUpColumnIncrement = + 1;
        dirUpRowIncrement = - 1;
        dirDownColumnIncrement = - 1;
        dirDownRowIncrement = + 1;
      }

      for (int c = columnIndex, r = rowIndex; c >= 0 && r >=0 && c <= columns - 1 && r <= rows - 1; c += dirUpColumnIncrement, r += dirUpRowIncrement) {
        Element el = getElement(c, r);
        elementsContinuity = (Element[]) append(elementsContinuity, el);
      }
      for (int c = columnIndex, r = rowIndex; c >= 0 && r >=0 && c <= columns - 1 && r <= rows - 1; c += dirDownColumnIncrement, r += dirDownRowIncrement) {
        Element el = getElement(c, r);
        elementsContinuity = (Element[]) append(elementsContinuity, el);
      }

      // iterate over all selectedElements
      for (int e = 0; e < elementsContinuity.length; e++) {
        //elementsContinuity[e].rotating = false;
        elementsContinuity[e].animateColor(colorHighlight);
      }
    } else if (mode2) {
      // cleanupprevious
      if (elementClicked != null) {
        elementClicked.animateColor(colorBase);
        elementClicked = null;
      }
      if (elementRandom != null) {
        elementRandom.animateColor(colorBase);
        elementRandom = null;
      }

      // find new ones
      elementClicked = getElement(columnIndex, rowIndex);
      elementClicked.animateColor(colorHighlight);
      //delay(300);
      int randomIndex;
      do {
        randomIndex = int(random(elements.length - 1));
        elementRandom = elements[randomIndex];
      } while (elementRandom == elementClicked || elementRandom == null);

      //println(elements.length, randomIndex);
      elementRandom.animateColor(colorHighlight);
    } else if (mode3) {
      // cleanupprevious
      if (elementsProximity != null) {
        for (int e = 0; e < elementsProximity.length; e++) {
          elementsProximity[e].animateColor(colorBase);
          elementsProximity[e].animateOffset(0, 0);
        }
      }

      // find new ones
      Element[] selectedElements = new Element[1];
      selectedElements[0] = getElement(columnIndex, rowIndex);
      elementsProximity = selectedElements;

      Element el1;
      Element el2;
      Element el3;

      // anywhere
      if (columnIndex < columns - 1 && rowIndex < rows - 1) {
        selectedElements[0].animateOffset(offsetDistance, offsetDistance);
        el1 = getElement(columnIndex + 1, rowIndex);
        el1.animateOffset(-offsetDistance, offsetDistance);
        el2 = getElement(columnIndex, rowIndex + 1);
        el2.animateOffset(offsetDistance, -offsetDistance);
        el3 = getElement(columnIndex + 1, rowIndex + 1);
        el3.animateOffset(-offsetDistance, -offsetDistance);
      }
      // last row
      else if (columnIndex < columns - 1 && rowIndex == rows - 1) {
        selectedElements[0].animateOffset(offsetDistance, -offsetDistance);
        el1 = getElement(columnIndex + 1, rowIndex);
        el1.animateOffset(-offsetDistance, -offsetDistance);
        el2 = getElement(columnIndex, rowIndex - 1);
        el2.animateOffset(offsetDistance, offsetDistance);
        el3 = getElement(columnIndex + 1, rowIndex - 1);
        el3.animateOffset(-offsetDistance, offsetDistance);
      }
      // last column
      else if (columnIndex == columns - 1 && rowIndex < rows - 1) {
        selectedElements[0].animateOffset(-offsetDistance, offsetDistance);
        el1 = getElement(columnIndex - 1, rowIndex);
        el1.animateOffset(offsetDistance, offsetDistance);
        el2 = getElement(columnIndex - 1, rowIndex + 1);
        el2.animateOffset(offsetDistance, -offsetDistance);
        el3 = getElement(columnIndex, rowIndex + 1);
        el3.animateOffset(-offsetDistance, -offsetDistance);
      }
      // last column & last row
      else {
        selectedElements[0].animateOffset(-offsetDistance, -offsetDistance);
        el1 = getElement(columnIndex - 1, rowIndex);
        el1.animateOffset(offsetDistance, -offsetDistance);
        el2 = getElement(columnIndex, rowIndex - 1);
        el2.animateOffset(-offsetDistance, offsetDistance);
        el3 = getElement(columnIndex - 1, rowIndex - 1);
        el3.animateOffset(offsetDistance, offsetDistance);
      }


      elementsProximity = (Element[]) append(elementsProximity, el1);
      elementsProximity = (Element[]) append(elementsProximity, el2);
      elementsProximity = (Element[]) append(elementsProximity, el3);

      for (int e = 0; e < elementsProximity.length; e++) {
        println(e);
        elementsProximity[e].animateColor(colorHighlight);
      }
    }
  }
}




//
//
//
// SETUP
//
//
//

void setup() {
  fullScreen();

  PFont font;
  // The font must be located in the sketch's 
  // "data" directory to load successfully
  font = loadFont("MessinaSansMonoTrial-Black-48.vlw");
  textFont(font, 18);
  //font = loadFont("MessinaSansTrial-Bold-48.vlw");
  //textFont(font, 24);

  elementsController = new ElementsController();
  elementsController.createElements();
}

//
//
// DRAW
//
//

void draw() { 
  background(colorBackground);

  //if (elementsController != null && elementsController.paddingLeft != null) {

  //}

  elementsController.drawElements();
}

//
//
//
//
// MOUSE PRESSED
//
//
//
//
void mousePressed() {
  println("mousePressed");
  colorToggle = !colorToggle;
  elementsController.mousePressed();
}

//
//
//
//
// COLORS
//
//
//
// fast ways of getting color
void getColorTest(color c) {
  println(getColorR(c));
  println(getColorG(c));
  println(getColorB(c));
  println(getColorA(c));
}
int getColorR(color c) {
  return (c >> 16) & 0xFF;
}

int getColorG(color c) {
  return (c >> 8) & 0xFF;
}
int getColorB(color c) {
  return c & 0xFF;
}
int getColorA(color c) {
  return (c >> 24) & 0xFF;
}



//
//
//
//
// ANIMATE
//
//
//
//

void gChangeColor(int paletteNumber) {
  println("changeColor", paletteNumber);
  color[] colorPalette;
  if (paletteNumber == 0) {
    colorPalette = colorPalette0;
  } else if (paletteNumber == 1) {
    colorPalette = colorPalette1;
  } else {
    colorPalette = colorPalette2;
  }

  colorBackground = colorPalette[0];
  colorBase = colorPalette[1];
  colorHighlight = colorPalette[2];

  // all elements
  //println(elementsController.elements);
  for (int e = 0; e < elementsController.elements.length; e++) {
    println(e, elementsController.elements.length);
    if (elementsController.elements[e] != null) { // CLEANUP
      elementsController.elements[e].animateColor(colorBase);
    }
  }

  // continuity elements
  if (elementsController.mode1 && elementsController.elementsContinuity != null) {
    for (int e = 0; e < elementsController.elementsContinuity.length; e++) {
      elementsController.elementsContinuity[e].animateColor(colorHighlight);
    }
  }
  // similarity elements
  if (elementsController.mode2) {
    if (elementsController.elementClicked != null) {
      elementsController.elementClicked.animateColor(colorHighlight);
    }
    if (elementsController.elementRandom != null) {
      elementsController.elementRandom.animateColor(colorHighlight);
    }
  }
  // proximity elements
  if (elementsController.mode3 && elementsController.elementsProximity != null) {
    for (int e = 0; e < elementsController.elementsProximity.length; e++) {
      elementsController.elementsProximity[e].animateColor(colorHighlight);
    }
  }
  // control elements
  elementsController.elementMode1.animateColor(colorBase);
  elementsController.elementText1.animateColor(colorBase);
  elementsController.elementMode2.animateColor(colorBase);
  elementsController.elementText2.animateColor(colorBase);
  elementsController.elementMode3.animateColor(colorBase);
  elementsController.elementText3.animateColor(colorBase);

  if (elementsController.mode1) {
    elementsController.elementMode1.animateColor(colorHighlight);
    elementsController.elementText1.animateColor(colorHighlight);
  }
  if (elementsController.mode2) {
    elementsController.elementMode2.animateColor(colorHighlight);
    elementsController.elementText2.animateColor(colorHighlight);
  }
  if (elementsController.mode3) {
    elementsController.elementMode3.animateColor(colorHighlight);
    elementsController.elementText3.animateColor(colorHighlight);
  }


  elementsController.elementColor1.animateColor(colorBase);
  elementsController.elementTextColor1.animateColor(colorBase);
  elementsController.elementColor2.animateColor(colorBase);
  elementsController.elementTextColor2.animateColor(colorBase);
  elementsController.elementColor3.animateColor(colorBase);
  elementsController.elementTextColor3.animateColor(colorBase);

  if (paletteNumber == 0) {
    elementsController.elementColor1.animateColor(colorHighlight);
    elementsController.elementTextColor1.animateColor(colorHighlight);
  }
  if (paletteNumber == 1) {
    elementsController.elementColor2.animateColor(colorHighlight);
    elementsController.elementTextColor2.animateColor(colorHighlight);
  }
  if (paletteNumber == 2) {
    elementsController.elementColor3.animateColor(colorHighlight);
    elementsController.elementTextColor3.animateColor(colorHighlight);
  }
}

// animateColor
color gColorAnimate(color origin, color target, float percent /* 0 - 1 */) {
  float deltaR = getColorR(target) - getColorR(origin);
  float deltaG = getColorG(target) - getColorG(origin);
  float deltaB = getColorB(target) - getColorB(origin);
  //println(origin, target);
  //println(deltaR, deltaG, deltaB);

  //println(getColorR(origin) + percent * deltaR, 
  //  getColorG(origin) + percent * deltaG, 
  //  getColorB(origin) + percent * deltaB
  //);

  return color(getColorR(origin) + percent * deltaR, 
    getColorG(origin) + percent * deltaG, 
    getColorB(origin) + percent * deltaB
    );
}

// animateOffset
int[] gOffsetAnimate(int[] origin, int[] target, float percent /* 0 - 1 */) {
  float deltaX = target[0] - origin[0];
  float deltaY = target[1] - origin[1];
  //println(origin, target);
  //println(deltaR, deltaG, deltaB);

  //println(getColorR(origin) + percent * deltaR, 
  //  getColorG(origin) + percent * deltaG, 
  //  getColorB(origin) + percent * deltaB
  //);
  int[] offset = {int(origin[0] + percent * deltaX), int(origin[1] + percent * deltaY)};
  return offset;
}
