// Global variables
bmp_net 		= new Pimage[2];
bmp_ball 		= new Pimage[15];
bmp_t1_sprite 	= new Pimage[136];
bmp_t2_sprite 	= new Pimage[136];
bmp_pitch 		= new Pimage[];

int TOT_FRAMES 		= 120;
int Current_Frame 	= 0;
int Replay_Line 	= 0;
int SCREEN_W 		= 480;
int SCREEN_H 		= 280;
int r_slot 			= 0;
String Replay_Data[] = loadStrings("rep/"+r_slot+".rep");
Player_Data 		= new int[120][22][3];
Ball_Data 			= new int[120][4];

float CAMERA_EASING_RATIO = 0.25;

/*___________________PITCH VARIABLES_____________________*/
int Pitch_x = 50;
int Pitch_y = 50; 
int Pitch_w = 832;
int Pitch_h	= 992;
int Pitch_middle_w = int(Pitch_w / 2) + Pitch_x;
int Pitch_middle_h = int(Pitch_h/2) + Pitch_y;

float cs = 0;
int Xm = int (Pitch_w / 2) + Pitch_x;
int Ym = int(Pitch_h / 2) + Pitch_y;
int Paw = int (Pitch_w / 3 );//half penalty area width
int Pah = int (Pitch_h / 6); //penalty area height
int Pac = int (Pitch_w / 10); //penalty area circle diameter
int Padw = 2; //penalty dish diameter
int Padd = int (Pah / 2);//penalty dish distance from net
int Gkw = int (Paw / 2); //half goalkeeper area width
int Gkh = int (Pah / 3); //goalkeeper area height
int Cxo = 0;
int Cyo = 0;

int cx=Xm;
int cy=Ym;
int bx = 300;
int by = 300;


// Setup the Processing Canvas
void setup(){
		
	size(SCREEN_W, SCREEN_H);
	strokeWeight( 10 );
	frameRate( 30 );
	bmp_net[0] = loadImage("img/pitch/net_top.png"); 
	bmp_net[1] = loadImage("img/pitch/net_bottom.png");
	bmp_pitch = loadImage("img/pitch/pitch.png");
	
	for (a=0;a<136;a++){
		int b;
		b = a +1;
		bmp_t1_sprite[a] = loadImage("img/t1/_"+b+".png");
		bmp_t2_sprite[a] = loadImage("img/t2/_"+b+".png");
	}
	for (a=1;a<16;a++){
		bmp_ball[a] = loadImage("img/ball/_"+a+".png");
	}
	load_replay_slot(int(random(19)));
}

// Main draw loop
void draw(){
	noSmooth();
	// Fill canvas green
	background( #00AA00 );
	stroke (#005500);

	//Draw background pitch
	draw_pitch_lines ( 	Pitch_x, Pitch_y, Pitch_w, Pitch_h, Xm, Ym, Paw, Pah,
						Pac, Padw, Padd, Gkw, Gkh, Cxo, Cyo);
	
	
	
	Render_Frame(Current_Frame);
	Current_Frame++;
	if (Current_Frame > TOT_FRAMES-1) {
		load_replay_slot(int(random(19)));
		Current_Frame =0;
	}
	update_camera_position(Ball_Data[Current_Frame][0], Ball_Data[Current_Frame][1]);
}


float _abtp(int x1, int y1, int x2, int y2) {
	return -atan2(y1-y2,x1-x2);
}

void Render_Frame (int frame) {
	/*Ball line*/
	if (frame > 20) {
		for (int c =0 ; c < 20; c++){
			strokeWeight (10-(int(c/2)));
			stroke (#004500, 100-int(c*4));
			/*shadow line*/
			line(	Ball_Data[frame-c][0] - Cxo + 7,
					Ball_Data[frame-c][1] - Cyo + 13,
					Ball_Data[frame-c-1][0] - Cxo + 7,
					Ball_Data[frame-c-1][1] - Cyo + 13);
			stroke (#FFFFFF,100-int(c*4));
			/*white line*/
			line(	Ball_Data[frame-c][0] - Cxo + 7,
					Ball_Data[frame-c][1] - Ball_Data[frame-c][2] - Cyo + 13,
					Ball_Data[frame-c-1][0] - Cxo + 7,
					Ball_Data[frame-c-1][1] - Ball_Data[frame-c][2] - Cyo + 13);
		}
	}
	
	//draw players				
	for (int c = 0; c < 22; c++) {
		if (c < 11) {
			image( bmp_t2_sprite[Player_Data[frame][c][2]], Player_Data[frame][c][0] - Cxo, Player_Data[frame][c][1] - Cyo);
		}else{
			image( bmp_t1_sprite[Player_Data[frame][c][2]], Player_Data[frame][c][0] - Cxo, Player_Data[frame][c][1] - Cyo);
		}
	}
	
	/*Ball Shadow*/
	fill(#003300);
	stroke (#003300);
	ellipse (Ball_Data[frame][0] - Cxo + 8, Ball_Data[frame][1] - Cyo + 15,8,4);
	/*draw ball*/
	image (bmp_ball[Ball_Data[frame][3]+1], Ball_Data[frame][0] - Cxo , Ball_Data[frame][1] - Cyo - Ball_Data[frame][2] +5);
	/*bottom net*/
	image (bmp_net[1], Xm -50- Cxo, Pitch_y+ Pitch_h-28-Cyo);
}

void draw_pitch_lines ( int x, int y, int w, int h, int xm, int ym, int paw,
                        int pah /*penalty area height*/,
                        int pac /*penalty area circl diameter*/,
                        int padw /*'penalty dish diameter*/,
                        int padd /*penalty dish distance from net*/,
                        int gkw /*'half goalkeeper area*/,
                        int gkh, int cxo ,int cyo ) {
    /*PITCH TEXTURE*/
    for (int c = 0; c < 32; c ++) {
		for (int r = 0; r < 21; r++) {
			image (bmp_pitch, c * 32 - cxo - 96, r * 64 - cyo - 128);
		}
	}	
    
    strokeWeight(2);   // Default
	stroke (#DDDDDD);
    noFill();
    //drawing the pitch's border lines
    x -= cxo;
    y -= cyo;
    xm -= cxo;
    ym -= cyo;
    
    //border limit of the pitch
    rect (x, y, w , h);
        
    //middle pitch dish
    ellipse (xm , ym , pac*2, pac*1.5);
     //middle pitch dish
    ellipse (xm , ym , 3, 3);
    //middle line, circle , dish
    line (x , ym ,x + w , ym );
    //Top penalty area
    arc(xm , y + pah , pac * 2, pac * 1.5, 0, PI)
    rect (xm - paw , y ,paw*2, pah);
    ellipse (xm , y + pah/2 + 25 , 3, 3);
     //Top Gk area
    rect (xm - gkw , y ,gkw*2,gkh);
    //Bottom penalty area
    arc(xm , y +h- pah , pac * 2, pac * 1.5, PI, TWO_PI)
    rect (xm - paw , y + h - pah ,paw*2, pah);
    ellipse (xm , y + h - pah/2 - 25 , 3, 3);
    //Bottom Gk area
    rect (xm - gkw , y + h - gkh ,gkw*2, gkh);
        
	//top net
	image (bmp_net[0], Xm -50- Cxo, Pitch_y-38-Cyo)
}

void update_camera_position(int bx, int by) {
	float cs;
	int cxp = 64;
	int cyp = 64;
	cs = d_b_t_p(cx, cy, bx, by) * CAMERA_EASING_RATIO;
    cx -= int (cos(_abtp(cx, cy, bx, by))*cs);
    cy -= int (-sin(_abtp(cx, cy, bx, by))*cs);
    
    /*Border limit check*/
    if (cx < Pitch_x + SCREEN_W/2 - cxp) {
        cx = Pitch_x + SCREEN_W/2 - cxp;
    }
    if (cx > Pitch_x + Pitch_w - SCREEN_W/2 + cxp) {
        cx = Pitch_x + Pitch_w - SCREEN_W/2 + cxp;
    }
    if (cy > Pitch_y + Pitch_h - SCREEN_H/2 + cyp) {
        cy = Pitch_y + Pitch_h - SCREEN_H/2 + cyp;
    }
    if (cy < Pitch_y + SCREEN_H/2 - cyp) {
        cy = Pitch_y + SCREEN_H/2 - cyp;
    }
    
    Cxo = cx - int(SCREEN_W/2);
    Cyo = cy - int(SCREEN_H/2);
}

void load_replay_slot(int slot) {
	Replay_Data = loadStrings("rep/" + slot + ".rep");
	int current_line = 0;
	for (t=0; t< TOT_FRAMES; t++) {
		/*load and store player data*/
		for (c=0; c< 22; c++){
			int[] t_p = int(split(Replay_Data[current_line],','));
			Player_Data[t][c][0] = t_p[0]; //player x
			Player_Data[t][c][1] = t_p[1]; //player y
			Player_Data[t][c][2] = t_p[2]; //player frame
			current_line++;
		}
		/*load and store ball data*/
		int[] t_p = int(split(Replay_Data[current_line],','));
		Ball_Data[t][0] = t_p[0]; //ball x
		Ball_Data[t][1] = t_p[1]; //ball y
		Ball_Data[t][2] = t_p[2]; //ball z
		Ball_Data[t][3] = t_p[3]; //ball frame
		current_line++;
	}
}

int d_b_t_p (int x1, int y1, int x2, int y2) {
    return int (sqrt(((x1-x2)*(x1-x2))+((y1-y2)*(y1-y2))));
}
