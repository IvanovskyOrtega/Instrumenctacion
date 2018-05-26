int x = 0;

void setup() {
  Serial.begin(9600);    
}

void loop() {  

  for(x=0; x<256; x++){
    Serial.write(x);
    delay(200);
  }
}
