/*TO DO LIST:
 * Problems:
 * Low contrast
 * Turning on and off functionalities (overlapping)
 * Is Mouse inside circle? Check SLIDER class
 * Noise and Selective Random continously are called
*/

int flag = 0;
int imgNum = -1; //Used to save multiple files
int saveFlag = 0;

int convActive = 0;
int avgActive = 0;
int edgeActive = 0;
int gausActive = 0;
int sharpActive = 0;

int rgbActive = 0;
Slider r = new Slider(630, 600, 230, 600, 800, 25);
Slider g = new Slider(630, 630, 230, 630, 800, 25);
Slider b = new Slider(630, 660, 230, 660, 800, 25);

int quanActive = 0;
int fourC = 0;
int eightC = 0;
int sixteenC = 0;
int[] fourPalette= {0, 64, 128, 192};
int[] eightPalette= {0, 32, 64, 96, 128, 160, 192, 224};
int[] sixteenPalette= {0, 16, 32, 48, 64, 80, 96, 112, 128, 144, 160, 176, 192, 208, 224};

int dithActive = 0;
int threshActive =0;
int noiseActive = 0;
int pattActive = 0;
int selectActive = 0;
int[][] patternMask = {{8,3,4},{6,1,2},{7,5,9}};

int contrActive = 0;

float [][]avgFilter = {{1.0/9,1.0/9,1.0/9},{1.0/9,1.0/9,1.0/9},{1.0/9,1.0/9,1.0/9}};
float [][]edgeFilter = {{1.0/3,1.0/3,1.0/3},{0,0,0},{-1.0/3,-1.0/3,-1.0/3}};
float [][]gausFilter = {{1.0/16,1.0/8,1.0/16},{1.0/8,1.0/4,1.0/8},{1.0/16,1.0/8,1.0/16}};
float [][]sharpFilter = {{0,-1,0},{-1,5,-1},{0,-1,0}};

PImage img,img2;

void setup() {
  size(1080,700);
  img = loadImage("gettingStarted.jpg");
  
}

void draw() {
  fill(0);
  background(#226b77);
  fill(#d7eff3);
  rect(230,80,800,500,10,10,10,10);//Big Picture rectangle
  imageMode(CENTER);
  image(img,630,330);
  stroke(#008000);
  strokeWeight(3);
  line(252,93,238,93); //+ sign HORIZONTAL
  line(245,85,245,100); //+ sign VERTICAL
  stroke(#FF0000);
  line(1005,100,1020,85); //X sign
  line(1020,100,1005,85); //X sign
  stroke(#0000FF);
  line(243,555,243,568); //
  line(243,568,239,561);
  line(243,568,247,561);
  line(235,561,235,572); //Save sign
  line(235,572,251,572);
  line(251,572,251,561); //
  stroke(0);
  strokeWeight(1);
  textSize(48);
  fill(0);
  text("IMP Hub", 500, 65); //Title text
  fill(#ff6666);
  rect(10,10,60,20); //Exit Button
  fill(0);
  textSize(12);
  text("Exit", 29,25); //Exit Text
  fill(#e8b7af);
  rect(30,100,150,50,5,5,5,5); //Convolutions rect
  rect(30,200,150,50,5,5,5,5); //RGB HSV rect
  rect(30,300,150,50,5,5,5,5); //Quantization rect
  rect(30,400,150,50,5,5,5,5); //Dithering rect
  rect(30,500,150,50,5,5,5,5); //Contrast rect
  fill(0);
  text("Convolutions", 65, 130); //Convolutions Text
  text("RGB Adjustment", 55, 230); //RGB HSV Text
  text("Quantization", 65, 330); //Quantization Text
  text("Dithering", 75, 430); //Dithering Text
  text("Contrast", 80, 530); //Contrast text
  text("Make sure to turn off a", 30, 620);
  text("functionality after using it,", 30, 635);
  text("software is still in progress", 30, 650);

//----------------------------DYNAMIC DRAWINGS----------------------------//
  
  if(flag == 1) {
    if(img.width > 755) {
      img.resize(755,img.height);
    }
    if(img.height > 455) {
      img.resize(img.width,455);
    }
    imageMode(CENTER); //Always placing the image in the center
    image(img,630,330);
  }
  
  if(saveFlag == 1) { //If statement to display that an image has been saved
    fill(0);
    strokeWeight(5);
    text("myImage"+ imgNum +".jpg has saved to the data directory!", 230, 600);
    strokeWeight(1);
  }
  
  if(convActive == 1) { //If convultions are active
    fill(#00FF7F);
    rect(30,100,150,50,5,5,5,5);
    fill(0);
    text("Convolutions", 65, 130);
    fill(#e8d4af);
    rect(245,625,150,50,5,5,5,5);
    rect(445,625,150,50,5,5,5,5);
    rect(645,625,150,50,5,5,5,5);
    rect(845,625,150,50,5,5,5,5);
    fill(0);
    text("Average Blur", 283, 655);
    text("Gaussian Blur", 480, 655);
    text("Edge Detection", 675, 655);
    text("Sharpen", 895, 655);
  }
  
  if(avgActive == 1) { //If avg conv is active
    fill(#afc3e8);
    rect(245,625,150,50,5,5,5,5);
    fill(0);
    text("Average Blur", 283, 655);
    img2 = img.copy();
    convolutions(avgFilter, img2);
    imageMode(CENTER);
    image(img2,630,330);
  }
  
  if(edgeActive == 1) { //If edge conv is active
    fill(#afc3e8);
    rect(645,625,150,50,5,5,5,5);
    fill(0);
    text("Edge Detection", 675, 655);
    img2 = img.copy();
    convolutions(edgeFilter, img2);
    imageMode(CENTER);
    image(img2,630,330);
  }
  
  if(gausActive == 1) { //If gaus conv is active
    fill(#afc3e8);
    rect(445,625,150,50,5,5,5,5);
    fill(0);
    text("Gaussian Blur", 480, 655);
    img2 = img.copy();
    convolutions(gausFilter, img2);
    imageMode(CENTER);
    image(img2,630,330);
  }
  
  if(sharpActive == 1) {
    fill(#afc3e8);
    rect(845,625,150,50,5,5,5,5);
    fill(0);
    text("Sharpen", 895, 655);
    img2 = img.copy();
    convolutions(sharpFilter, img2);
    imageMode(CENTER);
    image(img2,630,330);
  }
  
  if(quanActive == 1) {
    fill(#00FF7F);
    rect(30,300,150,50,5,5,5,5);
    fill(0);
    text("Quantization", 65, 330);
    fill(#e8d4af);
    rect(270,625,150,50,5,5,5,5);
    rect(537,625,150,50,5,5,5,5);
    rect(803,625,150,50,5,5,5,5);
    fill(0);
    text("4 colors", 320, 655);
    text("8 colors", 590, 655);
    text("16 colors", 850, 655);
  }
  
  if(fourC == 1) {
    fill(#afc3e8);
    rect(270,625,150,50,5,5,5,5);
    fill(0);
    text("4 colors", 320, 655);
    img2 = img.copy();
    quantize(fourPalette,img2);
    imageMode(CENTER);
    image(img2,630,330);
  }
  
  if(eightC == 1) {
    fill(#afc3e8);
    rect(537,625,150,50,5,5,5,5);
    fill(0);
    text("8 colors", 590, 655);
    img2 = img.copy();
    quantize(eightPalette,img2);
    imageMode(CENTER);
    image(img2,630,330);
  }
  
  if(sixteenC == 1) {
    fill(#afc3e8);
    rect(803,625,150,50,5,5,5,5);
    fill(0);
    text("16 colors", 850, 655);
    img2 = img.copy();
    quantize(sixteenPalette,img2);
    imageMode(CENTER);
    image(img2,630,330);
  }
  
  if(dithActive == 1) {
    fill(#00FF7F);
    rect(30,400,150,50,5,5,5,5);
    fill(0);
    text("Dithering", 75, 430);
    fill(#e8d4af);
    rect(245,625,150,50,5,5,5,5);
    rect(445,625,150,50,5,5,5,5);
    rect(645,625,150,50,5,5,5,5);
    rect(845,625,150,50,5,5,5,5);
    fill(0);
    text("Threshold", 286, 655);
    text("Noise", 505, 655);
    text("Pattern", 700, 655);
    text("Selective Random", 873, 655);
  }
  
  if(threshActive == 1) {
    fill(#afc3e8);
    rect(245,625,150,50,5,5,5,5);
    fill(0);
    text("Threshold", 286, 655);
    img2 = img.copy();
    threshold(img2);
    imageMode(CENTER);
    image(img2,630,330);
  }
  
  if(noiseActive == 1) {
    fill(#afc3e8);
    rect(445,625,150,50,5,5,5,5);
    fill(0);
    text("Noise", 505, 655);
    img2 = img.copy();
    noise_dither(img2);
    imageMode(CENTER); //PROBLEM WITH CONTINOUSLY DRAWING
    image(img2,630,330);
  }
  
  if(pattActive == 1) {
    fill(#afc3e8);
    rect(645,625,150,50,5,5,5,5);
    fill(0);
    text("Pattern", 700, 655);
    img2 = img.copy();
    pattern_dither(img2);
    imageMode(CENTER);
    image(img2,630,330);
  }
  
  if(selectActive == 1) {
    fill(#afc3e8);
    rect(845,625,150,50,5,5,5,5);
    fill(0);
    text("Selective Random", 873, 655);
    img2 = img.copy();
    selective_random_dither(img2); //PROBLEM WITH CONTINOUSLY DRAWING
    imageMode(CENTER); 
    image(img2,630,330);
  }
  
  float red,green,blue;
  
  if(rgbActive == 1) {
    fill(#00FF7F);
    rect(30,200,150,50,5,5,5,5);
    fill(0);
    text("RGB Adjustment", 55, 230);
    r.display();
    g.display();
    b.display();
    fill(#FF0000);
    textSize(28);
    text("R", 233, 623);
    fill(#088000);
    text("G", 233, 653);
    fill(#0000FF);
    text("B", 233, 683);
    img2 = img.copy();
    red = map(r.move(),280,980,0,1);
    green = map(g.move(),280,980,0,1);
    blue = map(b.move(),280,980,0,1);
    rgbChange(img2,red,green,blue);
    imageMode(CENTER); 
    image(img2,630,330);
  }
}

//----------------------------METHODS USED IN DRAW OR NEEDED METHODS----------------------------//
void fileSelected(File selection) {
  if(selection == null) {
    println("No image chosen!");
  } else {
    img = loadImage(selection.getAbsolutePath());
    flag = 1;
  }
}

void rgbChange(PImage img2, float red, float green, float blue) {
  for(int i = 0; i < img.pixels.length; i++) {
      img2.pixels[i] = color(red*red(img2.pixels[i]),green*green(img2.pixels[i]),blue*blue(img2.pixels[i]));
  }
}

void noise_dither(PImage img2) {
  img2.loadPixels();
  
  for(int i = 0; i < img2.pixels.length; i++) {
    color c = img.pixels[i];
    if(red(c) < random(0,pow(2,8)-1)) {
      img2.pixels[i] = color(0);
    } else {
      img2.pixels[i] = color(255);
    }
  }
  img2.updatePixels(); 
}

void threshold(PImage img2) {
  img2.loadPixels();
  
  for(int i = 0; i < img2.pixels.length; i++) {
    color c = img.pixels[i];
    if(red(c) < 127) {
      img2.pixels[i] = color(0);
    } else {
      img2.pixels[i] = color(255);
    }
  }
  img2.updatePixels(); 
}

void selective_random_dither(PImage img2) {
  img2.loadPixels();
  
  float random;
  for(int i = 0; i < img2.pixels.length; i++) {
    color c = img.pixels[i];
    random = random(0,10);
    if(random < 5) {
      img2.pixels[i] = color(0);
    } else {
      img2.pixels[i] = color(c);
    }
  }
  img2.updatePixels(); 
}

void pattern_dither(PImage img2) {
  img2.loadPixels();
  
  for(int i = 0; i < img.width; i+=3)
  for(int j = 0; j < img.height; j+=3) 
  {
    for(int x = 0; x < 3; x++)
    for(int y = 0; y < 3; y++) 
    {
      color c = img.get(i+x,j+y);
      int value = (int) map(red(c), 0, 255, 0, 9);
      if(value < patternMask[y][x]) {
            img2.set(i+x,j+y,color(0));
      } else {
            img2.set(i+x,j+y,color(255));
      }
    }
  }
  img2.updatePixels();
}

void convolutions(float[][] filter, PImage img2) {
  float r,g,b;
      for(int i=1; i<img.width-1;i++)
      for(int j=1; j<img.height-1;j++)
      {
        r = 0;
        g = 0;
        b = 0;

        for(int m=-1;m<2;m++)
        for(int n=-1;n<2;n++)
        {
          r+=red(img.get(i+m, j+n))*filter[n+1][m+1];
          g+=green(img.get(i+m, j+n))*filter[n+1][m+1];
          b+=blue(img.get(i+m, j+n))*filter[n+1][m+1];
        }
        img2.set(i,j,color(r,g,b));
      }
   img2.updatePixels();
}

void quantize(int[] palette, PImage img2) {
  for(int i = 0; i<img.width; i++)
  for(int j = 0; j<img.height; j++) {
    
   color c = img.get(i,j);
   
   float r = red(c);
   float g = green(c);
   float b = blue(c);
   
   float newR = findClosestColor(r, palette);
   float newG = findClosestColor(g, palette);
   float newB = findClosestColor(b, palette);
   
   img2.set(i,j,color(newR,newG,newB));
    
  }
}

float getDistance(float thisColor, float match) {
  float diff = thisColor - match;
  return diff*diff;
}

int findClosestColor(float thisColor, int[] palette) {
  
  float shortestDistance=60000;
  int num=-1;
  
  for(int i = 0; i <palette.length; i++) {
    float match;
    float distance;
    
    match = palette[i];
    distance = getDistance(thisColor,match);
    
    if(distance < shortestDistance) {
      num = palette[i];
      shortestDistance = distance;
    }
  }
  
  return num;
}


//----------------------------WHEN MOUSE IS CLICKED----------------------------//
void mouseClicked() {
  
  //Adding an image
  if(mouseX <= 257 && mouseX >= 232 && mouseY <= 107 && mouseY >= 82)
    selectInput("Select a file to process:", "fileSelected");
  
  //Exit Button
  if(mouseX <= 70 && mouseX >= 10 && mouseY <= 30 && mouseY >= 10) exit();
  
  //Removing the image
  if(mouseX <= 1025 && mouseX >= 1005 && mouseY <= 100 && mouseY >= 85) {
    convActive = 0;
    avgActive = 0;
    edgeActive = 0;
    gausActive = 0;
    sharpActive = 0;
    rgbActive = 0;
    quanActive = 0;
    fourC = 0;
    eightC = 0;
    sixteenC = 0;
    dithActive = 0;
    threshActive = 0;
    noiseActive = 0;
    pattActive = 0;
    selectActive = 0;
    contrActive = 0;
    flag = 0;
    img = loadImage("gettingStarted.jpg");
  }
  //Saving the image
  if(mouseX <= 255 && mouseX >= 230 && mouseY <= 585 && mouseY >= 555) {
    String s = "myImage" + (imgNum+1) + ".jpg";
    if(img2 == null) img.save(s); 
    else img2.save(s);
    imgNum++;
    saveFlag = 1;
  }
  
//----------------------------CONVOLUTIONS----------------------------//
  if(mouseX <= 180 && mouseX >= 30 && mouseY <= 150 && mouseY >= 100) {
    if(convActive == 1) {
      convActive = 0;
    }
    else if(convActive == 0) {
      convActive = 1;
    }
  }
  
  if(convActive == 1 && mouseX <= 395 && mouseX >= 245 && mouseY <= 675 && mouseY >= 625) {
    if(avgActive == 1) avgActive = 0;
    else if(avgActive == 0) avgActive = 1;
  }
  
  if(convActive == 1 && mouseX <= 795 && mouseX >= 645 && mouseY <= 675 && mouseY >= 625) {
    if(edgeActive == 1) edgeActive = 0;
    else if(edgeActive == 0) edgeActive = 1;
  }
  
  if(convActive == 1 && mouseX <= 595 && mouseX >= 445 && mouseY <= 675 && mouseY >= 625) {
    if(gausActive == 1) gausActive = 0;
    else if(gausActive == 0) gausActive = 1;
  }
  
  if(convActive == 1 && mouseX <= 995 && mouseX >= 845 && mouseY <= 675 && mouseY >= 625) {
    if(sharpActive == 1) sharpActive = 0;
    else if(sharpActive == 0) sharpActive = 1;
  }
  
//----------------------------QUANTIZATION----------------------------//

  if(mouseX <= 180 && mouseX >= 30 && mouseY <= 350 && mouseY >= 300) {
    if(quanActive == 1) {
      quanActive = 0;
    }
    else if(quanActive == 0) {
      quanActive = 1;
    }
  }
  
  if(quanActive == 1 && mouseX <= 420 && mouseX >= 270 && mouseY <= 675 && mouseY >= 625) {
    if(fourC == 1) fourC = 0;
    else if(fourC == 0) fourC = 1;
  }
  
  if(quanActive == 1 && mouseX <= 687 && mouseX >= 537 && mouseY <= 675 && mouseY >= 625) {
    if(eightC == 1) eightC = 0;
    else if(eightC == 0) eightC = 1;
  }
  
  if(quanActive == 1 && mouseX <= 953 && mouseX >= 803 && mouseY <= 675 && mouseY >= 625) {
    if(sixteenC == 1) sixteenC = 0;
    else if(sixteenC == 0) sixteenC = 1;
  }
//----------------------------DITHERING----------------------------//

  if(mouseX <= 180 && mouseX >= 30 && mouseY <= 450 && mouseY >= 400) {
    if(dithActive == 1) {
      dithActive = 0;
    }
    else if(dithActive == 0) {
      dithActive = 1;
    }
  }
  
  if(dithActive == 1 && mouseX <= 395 && mouseX >= 245 && mouseY <= 675 && mouseY >= 625) {
    if(threshActive == 1) threshActive = 0;
    else if(threshActive == 0) threshActive = 1;
  }
  
  if(dithActive == 1 && mouseX <= 595 && mouseX >= 445 && mouseY <= 675 && mouseY >= 625) {
    if(noiseActive == 1) noiseActive = 0;
    else if(noiseActive == 0) noiseActive = 1;
  }
  
  if(dithActive == 1 && mouseX <= 795 && mouseX >= 645 && mouseY <= 675 && mouseY >= 625) {
    if(pattActive == 1) pattActive = 0;
    else if(pattActive == 0) pattActive = 1;
  }
  
  if(dithActive == 1 && mouseX <= 995 && mouseX >= 845 && mouseY <= 675 && mouseY >= 625) {
    if(selectActive == 1) selectActive = 0;
    else if(selectActive == 0) selectActive = 1;
  }
//----------------------------RGB Adjustment----------------------------//
  if(mouseX <= 180 && mouseX >= 30 && mouseY <= 250 && mouseY >= 200) {
    if(rgbActive == 1) {
      rgbActive = 0;
    }
    else if(dithActive == 0) {
      rgbActive = 1;
    }
  } 
}

void mousePressed() {
  if (rgbActive == 1) r.isOver();
  else if (rgbActive == 1) g.isOver();
  else if (rgbActive == 1) b.isOver();
}

void mouseReleased() {
  r.lock();
  g.lock();
  b.lock();
}

void mouseDragged() {
  if(rgbActive == 1 && r.isOver()) {
    r.move();
  }
  
  if(rgbActive == 1 && g.isOver()) {
    g.move();
  }
  
  if(rgbActive == 1 && b.isOver()) {
    b.move();
  }
}
