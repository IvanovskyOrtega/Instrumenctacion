import controlP5.*;
import java.util.*;
import processing.serial.*;

ControlP5 cp5;

Serial myPort;
int w, h;
float value;
int inByte;
float scaledValue;
int currentTempScale;
int currentSensor = -1;
CallbackListener cb;

void serialEvent(Serial p) { 
  inByte = p.read(); 
  switch (currentSensor) {
    case 0:
      value = termometerValue(inByte);
      break;
    case 1:
      value = distanceValue(inByte);
      break;
  }
} 

void drawTermometer(int x, int y, int d){
  y = y+200;
  stroke(255, 26, 26);
  fill(255, 26, 26);
  arc(x, y+45, d, d,-63*PI/180,241*PI/180,CHORD);
  noStroke();
  fill(0);
  textSize(25);
  fill(255);
  textAlign(CENTER);
  fill(255);
  text(String.format("%.2f", value)+"°", x, y + 50);
  fill(33, 129, 247);
  text("La temperatura es: \n"+String.format("%.2f", scaledValue), x+200, h);
  noFill();
  stroke(50);
  strokeWeight(3);
  arc(x, y+45, d+10, d+10,-56*PI/180,236*PI/180);
  line(x-30,y-(d-5)/2+45,x-30,y-505);
  line(x+30,y-(d-5)/2+45,x+30,y-505);
  line(x-30,y-505,x+30,y-505);
  rectMode(CORNERS);
  stroke(255, 26, 26);
  strokeWeight(3);
  fill(255, 26, 26);
  rect(x-25, y,x+25, y-value*10);
  noStroke();
  fill(0);
  stroke(50);
  strokeWeight(3);
  line(x+30,y-10,x+20,y-10);
  line(x+30,y-20,x+20,y-20);
  line(x+30,y-30,x+20,y-30);
  line(x+30,y-40,x+20,y-40);
  line(x+30,y-50,x+10,y-50);
  line(x+30,y-60,x+20,y-60);
  line(x+30,y-70,x+20,y-70);
  line(x+30,y-80,x+20,y-80);
  line(x+30,y-90,x+20,y-90);
  line(x+30,y-100,x,y-100);
  line(x+30,y-110,x+20,y-110);
  line(x+30,y-120,x+20,y-120);
  line(x+30,y-130,x+20,y-130);
  line(x+30,y-140,x+20,y-140);
  line(x+30,y-150,x+10,y-150);
  line(x+30,y-160,x+20,y-160);
  line(x+30,y-170,x+20,y-170);
  line(x+30,y-180,x+20,y-180);
  line(x+30,y-190,x+20,y-190);
  line(x+30,y-200,x,y-200);
  line(x+30,y-210,x+20,y-210);
  line(x+30,y-220,x+20,y-220);
  line(x+30,y-230,x+20,y-230);
  line(x+30,y-240,x+20,y-240);
  line(x+30,y-250,x+10,y-250);
  line(x+30,y-260,x+20,y-260);
  line(x+30,y-270,x+20,y-270);
  line(x+30,y-280,x+20,y-280);
  line(x+30,y-290,x+20,y-290);
  line(x+30,y-300,x,y-300);
  line(x+30,y-310,x+20,y-310);
  line(x+30,y-320,x+20,y-320);
  line(x+30,y-330,x+20,y-330);
  line(x+30,y-340,x+20,y-340);
  line(x+30,y-350,x+10,y-350);
  line(x+30,y-360,x+20,y-360);
  line(x+30,y-370,x+20,y-370);
  line(x+30,y-380,x+20,y-380);
  line(x+30,y-390,x+20,y-390);
  line(x+30,y-400,x,y-400);
  line(x+30,y-410,x+20,y-410);
  line(x+30,y-420,x+20,y-420);
  line(x+30,y-430,x+20,y-430);
  line(x+30,y-440,x+20,y-440);
  line(x+30,y-450,x+10,y-450);
  line(x+30,y-460,x+20,y-460);
  line(x+30,y-470,x+20,y-470);
  line(x+30,y-480,x+20,y-480);
  line(x+30,y-490,x+20,y-490);
  line(x+30,y-500,x,y-500);
}


float distanceValue(int inByte){
  int distanceValue = 0;
  for(int i = 7; i >=0 ; i--){
    if(((inByte >> i) & 1) == 1 )
      distanceValue += Math.pow(2,i);
  }
  distanceValue *= .2745;
  distanceValue += 10;
  /*switch (EscalaD) {
    case 'cm':
      scaledValue = distanceValue;
      scaledValue = scaledValue.toFixed(2);
      scaledValue = scaledValue+" cm";
      break;
    case 'ft':
      scaledValue = distanceValue/30.48;
      scaledValue = scaledValue.toFixed(2);
      scaledValue = scaledValue+" ft";
      break;
    case 'in':
      scaledValue = distanceValue/2.54;
      scaledValue = scaledValue.toFixed(2);
      scaledValue = scaledValue+" in";
      break;
  }*/
  return distanceValue;
}

float termometerValue(int inByte){
  float termometerValue = 0.0;
  for(int i = 7; i >=0 ; i--){
    if(((inByte >> i) & 1) == 1 )
      termometerValue += Math.pow(2,i);
  }
  termometerValue *= 0.19607;
  switch (currentTempScale) {
    case 0:
      scaledValue = termometerValue;
      break;
    case 1:
      scaledValue = termometerValue+273.15;
      break;
    case 2:
      scaledValue = (termometerValue*1.8)+32;
      break;
  }
  return termometerValue;
}


void setup() {
  size(1600, 900);
  w =width/2;
  h=height/2;
  printArray(Serial.list()); 
  myPort = new Serial(this, "COM1", 9600);  
  cp5 = new ControlP5(this);
  List l = Arrays.asList("TEMPERATURA", "DISTANCIA", "POTENCIOMETRICO", "PROXIMIDAD");
  List e1 = Arrays.asList("CELSIUS", "KELVIN", "FAHRENHEIT");
  cp5.addScrollableList("SENSORES")
     .setPosition(20, 20)
     .setSize(200, 500)
     .setBarHeight(80)
     .setItemHeight(80)
     .addItems(l)
     ;
  cp5.addScrollableList("ESCALAS")
     .setPosition(20, 200)
     .setSize(200, 500)
     .setBarHeight(80)
     .setItemHeight(80)
     .addItems(e1)
     ;
   cp5.get(ScrollableList.class, "ESCALAS").setVisible(false);  
     
}

void draw() {
  background(240);
  switch(currentSensor){
    case 0: 
      cp5.get(ScrollableList.class, "ESCALAS").setVisible(true);
      drawTermometer(w,h,100);
    break;
    case 1: 
      cp5.get(ScrollableList.class, "ESCALAS").setVisible(false);
      drawRuler(w,h);
    break;
  }
}


void drawRuler(int x, int y){
  stroke(0);
  strokeWeight(5);
  fill(224, 228, 18);
  rect(x/4,y,value*10,200);
  noStroke();
  fill(233, 237, 33);
  rect(x/4+3,y+50,value*10-5,100);
  int k = 10;
  int count = 1;
  stroke(0);
  strokeWeight(1);
  for(int j = 1; j < value; j++, count++){
    strokeWeight(1);
    if(count % 5 == 0){
      strokeWeight(4);
      line((x/4)+k,y,(x/8)+k,.75*y+100);
      k+=10;
      textSize(20);
      fill(255);
      text(count, (x/4)-20+k, y+120);
    }
    else if(j < value){
      line((x/4)+k,y,(x/4)+k,y+50);
      k+=10;
    }
  }
  k = 10;
  noStroke();
  textSize(32);
  fill(33, 129, 247);
  text("La distancia es: \n"+scaledValue, x, w/2);
}


void SENSORES(int n) {
  cp5.get(ScrollableList.class, "ESCALAS").setVisible(false);
  println(n, cp5.get(ScrollableList.class, "SENSORES").getItem(n));
  currentSensor = n;
}

void ESCALAS(int n) {
  println(n, cp5.get(ScrollableList.class, "SENSORES").getItem(n));
  currentTempScale = n;
  
}
