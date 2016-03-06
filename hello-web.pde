
// Global variables
float radius = 50.0;
int X, Y;
int nX, nY;
int delay = 16;
PImage bmp_top_net;
PImage[] bmp_sprite = new Pimage[136];

// Setup the Processing Canvas
void setup(){
	size( 640, 300 );
	strokeWeight( 10 );
	frameRate( 15 );
	X = width / 2;
	Y = width / 2;
	nX = X;
	nY = Y; 
	bmp_top_net = loadImage("net_top.png"); 
	int a;
	int b;
	for (a=0;a<136;a++){
		b = a +1
		bmp_sprite[a] = loadImage("img/_"+b+".png");
	}
	//String lines[] = loadStrings("list.txt");
}

// Main draw loop
void draw(){
  
  // Track circle to new destination
  X+=(nX-X)/delay;
  Y+=(nY-Y)/delay;
  
  // Fill canvas green
  background( #00AA00 );
  
 
  //top net
  image (bmp_top_net, 270, 35)
  //top line
  strokeWeight(2);   // Default
  stroke (#FFFFFF)
  line(50, 74, 590, 74);
  line(50, 74, 50, 400);
  line(590, 74, 590, 400);
  fill(#00AA00);
  rect(100, 74, 440, 150);
  rect(200, 74, 250, 50);
  ellipse( 320, 180, 3, 3 );  
  
  
  // Set stroke-color white
  stroke(255); 
  
  // Draw player
	fill(#005500);
	stroke (#005500);
	ellipse (X + int(cos(_abtp(mouseX,mouseY,X,Y))*10)+10,Y + int(-sin(_abtp(mouseX,mouseY,X,Y))*10)+20,7,2)
	fill(#FFFFFF);
	stroke (#FFFFFF);
	ellipse (X + int(cos(_abtp(mouseX,mouseY,X,Y))*10)+10,Y + int(-sin(_abtp(mouseX,mouseY,X,Y))*10)+15,7,7)
  image( bmp_sprite[start_frame(_abtp(mouseX,mouseY,X,Y))+frameCount%6], X, Y-5);
  // println(lines[0]);
    println("Frame " + frameCount + "X" + int(X) + "; Y" + int(Y));       
}

// Set circle's next destination

void mouseMoved(){
  nX = mouseX;
  nY = mouseY;  
}

float _abtp(int x1, int y1, int x2, int y2) {
	return -atan2(y1-y2,x1-x2);
}

int start_frame (float radiants){
    int degree;
    //convert radiants to 360° degree
    degree = (180-int(radiants*180/PI));
    if (degree < 23) {
		return 68;
	} else if (degree < 68){
		return 51;
	} else if (degree < 113){
		return 34;
	} else if (degree < 158){
		return 17;
	} else if (degree < 203){
		return 0;
	} else if (degree < 248){
		return 119;
	} else if (degree < 293){
		return 102;
	} else if (degree < 338){
		return 85;
	} else if (degree < 361){
		return 68;
	}
}


