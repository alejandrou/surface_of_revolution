import java.util.Iterator; 
import gifAnimation.*;

PShape obj ;
boolean drawing, figureCreate, figureDrawn;
int x, y, x0, y0, firstPress;
ArrayList<Coordinates> points;


//GifMaker ficherogif;

void setup (){
  size (800 ,800 ,P3D) ;
  drawing=true;
  figureCreate=false;
  firstPress = 1;
  points = new ArrayList();
  
  textSize(30);
  textAlign(CENTER, CENTER); 
  rectMode(CENTER);
  
  /*ficherogif = new GifMaker(this, "figure.gif");
  ficherogif.setRepeat(0);
  ficherogif.setTransparent(0,0,0);*/
}

void mainAlgorithm(int x1, int y1, int x11, int y11, int diametro){
  
   int ax1 = x1;
   int ay1 = y1;
   int az1 = 0;
   int ax11 = x11;
   int ay11 = y11;
   int az11=0;
   
   double x2 ;
   double y2;
   double z2;
    
   for(int i=0;i<1201;i=i+diametro){
     
    int angulo=i;
    int z1=0;
    
    obj.vertex (ax1 , ay1 , az1 ) ;
  
    x2 = x1*Math.cos(angulo)-z1*Math.sin(angulo);
    y2 = y1;
    z2 = x1*Math.sin(angulo)+z1*Math.cos(angulo);
    
    obj.vertex ((int)x2 , (int)y2 , (int)z2 );
    ax1=(int)x2;
    ay1=(int)y2;
    az1=(int)z2;
    
    obj.vertex (ax11 , ay11 , az11 ) ;
    
    x2 = x11*Math.cos(angulo)-z1*Math.sin(angulo);
    y2 = y11;
    z2 = x11*Math.sin(angulo)+z1*Math.cos(angulo);
    
    obj.vertex ((int)x2 , (int)y2 , (int)z2 );
    ax11=(int)x2;
    ay11=(int)y2;
    az11=(int)z2;
  }
}

void draw() {
  create_revolution_of_surface();
  figureDrawn();
  
  /*ficherogif.setDelay(1);
  ficherogif.addFrame();*/
  
}

void create_revolution_of_surface(){
  if(drawing){
      stroke(255);
      line(400, 0, 400, 800);
      stroke (255, 225, 0);    
      if(mousePressed){
        if (mouseX<400){
          drawing=false;
          y0=mouseY;
          points.add(new Coordinates(0, y0));
        }else if (firstPress == 1) {
          firstPress = 0;
          x0=mouseX;
          y0=mouseY;
          point(x0, y0);
          points.add(new Coordinates(x0-400, y0));
        }
        else {   
          x=mouseX;
          y=mouseY;
          point(x, y);
          line(x0, y0, x, y);
          x0=x;
          y0=y;
          points.add(new Coordinates(x0-400, y0));
        }
      }
    } else if(!figureCreate){
      
        figureCreate=true;
        
        obj=createShape();
        obj.beginShape(TRIANGLE_STRIP);
        obj.fill(100);
        obj.stroke (255,225,0) ;
        
        Coordinates b, a=points.get(0);
        
        for(int i=1; i<points.size();i++){
          b=points.get(i);
          mainAlgorithm(a.x, a.y, b.x, b.y, 100);
          a = b;
        }  
        obj.endShape();
      
    } else {
      background(0);
      translate (mouseX, mouseY-100);
      shape(obj);
    }
}

void figureDrawn() {
  if(figureCreate == true) {
    figureDrawnPage("Figure has been drawn!", color(255,0,0));
  }
  
}


void figureDrawnPage(String text, color c) {
  
  fill(255);
  text("Press ENTER to draw again",  width/2, height/3 + 40);
  fill(c);
  text(text, width/2, height/3);
  if(keyPressed) {
     if (key == ENTER){
        background(200);
        drawing=true;
        figureCreate=false;
        firstPress = 1;
        Iterator itr = points.iterator(); 
        while (itr.hasNext()) 
        { 
           Object coordinates = itr.next();
           itr.remove(); 
        }
    }
  }
}

/*void keyPressed() {
if (key == 'w' || key == 'W') {
    ficherogif.finish();
  }
}*/


class Coordinates{
  int x;
  int y;
  
  public Coordinates(int x, int y){
    this.x=x;
    this.y=y;
  }
}
