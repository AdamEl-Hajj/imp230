class Slider {
  float ellipseX,ellipseY;
  float rectX, rectY;
  float w, h;
  boolean locked;
  float r;
  
  Slider(float ellipseX, float ellipseY, float rectX, float rectY, float w, float h) {
    this.ellipseX = ellipseX;
    this.ellipseY = ellipseY;
    this.rectX = rectX;
    this.rectY = rectY;
    this.w = w;
    this.h = h;
    locked = true;
    r = 10;
  }
  
  void display() {
    fill(#afc3e8);
    rect(rectX,rectY,w-1,h);
    fill(255);
    rect(rectX+50,rectY+8,w-100,h/4);
    ellipse(ellipseX,rectY+12,20,20);
  }
  
  float move() {
    if(!locked) {
      ellipseX = constrain(mouseX,280,980);
    } 
    return ellipseX;
  }
  
  
  boolean isOver() {
    if(dist(mouseX,mouseY,ellipseX,ellipseY) < r) { //PROBLEM HERE
      locked = false;
      ellipseX = mouseX;
      return true;
    }
    return false;
  }
  
  void lock() {
    locked = true;
  }
}
