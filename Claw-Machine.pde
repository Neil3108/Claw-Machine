void setup()
{
  size(640, 640, P3D);
  hint(DISABLE_OPTIMIZED_STROKE);
}
boolean perspective = false; // Switches the perspective
boolean one = false; // Camare view one
boolean two = false; // Camare view two
boolean three = false; // Camare view three
boolean movement = false; // Check if movement is happening
boolean maxDisUp = false; // Max distance up
boolean maxDisDown = false; // Max distance down
boolean open = false; // Checks if the claw is open or close
float rotateRod = 0; // Rotates the rod
float rotateRedBox = 0; // Rotates the red box
float moveBlueBox = -5; // Moves the blue box
float moveRedBox = -3; // Moves the red box
float opens = 0; // How much should the claw close or open
float openSpaces = 0; // How much should the claw close or open during the claw sequence
int openSpace = 2; // Check condition of claw during the claw sequence

void draw()
{
  clear();
  background(51, 204, 255);
  stroke(255, 255, 255);

  if (perspective)
    frustum(-10, 10, 10, -10, 4, 100);
  else
    ortho(-10, 10, 10, -10, 4, 100);

  resetMatrix();

  if (one)
    camera(0.0, 0.0, 0.0, 0.0, 0.0, -2.0, 0.0, 1.0, 0.0);
  else if (two)
    camera(0, 20, 0, -1, 0, -7, 0, -10, 0);
  else if (three)
    camera(-1, -5, 1, 0.0, 0.0, -2.5, 0.0, 2.0, 0.0);

  translate(0, 0, -11);
  rotation();
  drawPrize();
  clawMachine();

  if (openSpace == 0)
  {
    if (openSpaces >= -0.3)
      openSpaces -= 0.02;
  } else if (openSpace == 1)
  {
    if (openSpaces <= 0)
      openSpaces += 0.01;
  }
}

void clawMachine()
{
  pushMatrix();
  translate(0, 10, 0);
  drawTopBox();
  popMatrix();

  pushMatrix();
  translate(0, 8, 0);
  rotateY(rotateRod);
  drawRod();
  pushMatrix();
  translate(moveBlueBox, -2, 0);
  drawBlueBox();
  pushMatrix();
  strokeWeight(2);
  line(0, 2, 0, moveRedBox);
  strokeWeight(1);
  translate(0, moveRedBox, 0);
  rotateY(rotateRedBox);
  drawRedBox();
  pushMatrix();
  translate(5, -5.9, 0);
  drawClaws();
  popMatrix();
  popMatrix();
  popMatrix();
  popMatrix();
}

void drawTopBox()
{
  fill(0);
  drawBox();
}

void drawRod()
{
  fill(47, 79, 79);
  box(12, 2, 1);
}

void drawBlueBox()
{
  fill(0, 0, 255);
  drawBox();
}

void drawRedBox()
{
  fill(255, 0, 0);
  drawBox();
}

void drawBox()
{
  beginShape(QUADS);
  vertex(-1, -1, 1);
  vertex(-1, 1, 1);
  vertex(1, 1, 1);
  vertex(1, -1, 1);

  vertex(1, -1, 1);
  vertex(1, -1, -1);
  vertex(1, 1, -1);
  vertex(1, 1, 1);

  vertex(1, -1, -1);
  vertex(-1, -1, -1);
  vertex(-1, 1, -1);
  vertex(1, 1, -1);

  vertex(-1, -1, -1);
  vertex(-1, -1, 1);
  vertex(-1, 1, 1);
  vertex(-1, 1, -1);

  vertex(-1, 1, 1);
  vertex(1, 1, 1);
  vertex(1, 1, -1);
  vertex(-1, 1, -1);

  vertex(1, -1, 1);
  vertex(-1, -1, 1);
  vertex(-1, -1, -1);
  vertex(1, -1, -1);

  endShape();
}

void drawClaws()
{
  pushMatrix();

  drawClaw();
  popMatrix();

  pushMatrix();
  translate(-10, 0, 0);
  scale(-1, 1);
  drawClaw();
  popMatrix();

  pushMatrix();

  drawClaw();
  popMatrix();

  pushMatrix();
  translate(-10, 0, 0);
  scale(-1, 1);
  drawClaw();
  popMatrix();
}

void drawClaw()
{
  fill(119, 136, 153);
  pushMatrix();
  rotate(0.5);
  translate(-2.9, 6.6, 0);
  box(0.8, 0.5, 0.5);
  pushMatrix();
  if (openSpace == 1 || openSpace ==0)
    shearX(openSpaces);
  else
    shearX(opens);
  translate(-0.7, -0.4, 0);
  sphere(0.25);
  pushMatrix();
  translate(-1, -1.5, 0);
  drawLowerClaw();
  popMatrix();
  popMatrix();
  popMatrix();
}

void drawLowerClaw()
{
  pushMatrix();
  rotate(-2);
  box(3, 0.5, 0.5);
  popMatrix();
}

void drawPrize()
{
  pushMatrix();
  fill(0, 255, 0);
  translate(0, -10, -4);
  box(4);
  popMatrix();

  pushMatrix();
  fill(255, 255, 0);
  translate(-5, -10, 5);
  sphere(2);
  popMatrix();

  pushMatrix();
  fill(255, 80, 80);
  translate(5, -10, 3);
  box(2, 4, 2);
  popMatrix();

  pushMatrix();
  fill(255, 102, 255);
  translate(2, -10, 0);
  box(2, 1, 1);
  popMatrix();

  pushMatrix();
  fill(0, 51, 204);
  translate(-3, -10, -3);
  sphere(1);
  popMatrix();
}

void moveRedDown()
{
  if (moveRedBox == -5.999997 )
  {
    maxDisDown = true;
  } else
  {
    maxDisDown = false;
  }
  if (moveRedBox >= -6)
    moveRedBox -= 0.1;
}

void moveRedUp()
{
  if (moveRedBox == -2.9)
  {
    maxDisUp = true;
  } else {
    maxDisUp = false;
  }
  if (moveRedBox <= -3)
  {
    moveRedBox += 0.1;
  }
}

void rodRotation(char k)
{
  if (k == 'q')
    rotateRod += 0.01;
  else if (k == 'w')
    rotateRod -= 0.01;
}

void redBoxRotation(char k)
{
  if ( k == 's')
    rotateRedBox += 0.01;
  else if (k == 'd')
    rotateRedBox -= 0.01;
}

void blueBoxMove(char k)
{
  if (k == 'e')
  {
    if (moveBlueBox <= 5.0)
    {
      moveBlueBox += 0.1;
    }
  } else if (k == 'r')
  {
    if (moveBlueBox >= -5.0)
    {
      moveBlueBox -= 0.1;
    }
  }
}

void claw()
{
  openSpace = 2;
  if (open)
  {
    if (opens >= -0.3)
      opens -= 0.01;
  } else
  {
    if (opens <= 0.0)
      opens += 0.01;
  }
}

void moveRedBox(char k)
{
  if (k == 'z')
    moveRedDown();
  else if (k == 'a')
    moveRedUp();
}

void rotation()
{
  if (key == 'q' && movement)
  {
    rodRotation('q');
  } else if (key == 'w' && movement)
    rodRotation('w');
  else if (key == 's' && movement)
    redBoxRotation('s');
  else if (key == 'd' && movement)
    redBoxRotation('d');
  else if (key == 'e' && movement)
  {
    blueBoxMove('e');
  } else if (key == 'r' && movement)
  {
    blueBoxMove('r');
  } else if (key == 'x')
  {
    claw();
  } else if (key == 'c')
  {
    claw();
  } else if (key == 'z' && movement)
    moveRedBox('z');
  else if (key == 'a' && movement)
    moveRedBox('a');
  else if (key == ' ' && movement)
  {
    if (!maxDisDown)
    {
      moveRedDown();
      if (moveRedBox == -5.999997)
      {
        openSpace = 0;
      }
    } else
    {
      moveRedUp();
      if (moveRedBox == -2.9)
      {
        openSpace = 1;
      }
    }
  }
}

void keyPressed() 
{
  switch (key) 
  {
  case 'q':
    if (movement)
      movement = false;
    else
      movement = true;
    break;
  case 'w':
    if (movement)
      movement = false;
    else
      movement = true;
    break;
  case 's':
    if (movement)
      movement = false;
    else
      movement = true;
    break;
  case 'd':
    if (movement)
      movement = false;
    else
      movement = true;
    break;
  case 'e':
    if (movement)
      movement = false;
    else
      movement = true;
    break;
  case 'r':
    if (movement)
      movement = false;
    else
      movement = true;
    break;
  case 'z':
    if (movement)
      movement = false;
    else
      movement = true;
    break;
  case 'a':
    if (movement)
      movement = false;
    else
      movement = true;
    break;
  case 'x':
    open = true;
    break;
  case 'c':
    open = false;
    break;
  case ' ':
    movement = true;
    maxDisDown = false;
    break;
  case 'o':
    perspective = !perspective; 
    break;
  case 'p':
    perspective = !perspective;
    break;
  case '1':
    one = true;
    two = false;
    three = false;
    movement = true;
    break;
  case '2':
    two = true;
    one = false;
    three = false;
    movement = true;
    break;
  case '3':
    three = true;
    two = false;
    one = false;
    movement = true;
    break;
  case '0':
    three = false;
    two = false;
    one = false;
    break;
  }
}
