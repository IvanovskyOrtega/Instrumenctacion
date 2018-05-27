byte outByte = 0;
int pins[8] = {2,3,4,5,6,7,8,9};
byte adc[8];

void setup() {
  
  /* Pines en modo entrada */
  pinMode(pins[0],INPUT);
  pinMode(pins[1],INPUT);
  pinMode(pins[2],INPUT);
  pinMode(pins[3],INPUT);
  pinMode(pins[4],INPUT);
  pinMode(pins[5],INPUT);
  pinMode(pins[6],INPUT);
  pinMode(pins[7],INPUT);
  
  /* Abrimos la comunicacion Serial */
  Serial.begin(9600); 
  
}

void loop() {

  /* Leemos las entradas */
  adc[0] = digitalRead(pins[0]);
  adc[1] = digitalRead(pins[1]);
  adc[2] = digitalRead(pins[2]);
  adc[3] = digitalRead(pins[3]);
  adc[4] = digitalRead(pins[4]);
  adc[5] = digitalRead(pins[5]);
  adc[6] = digitalRead(pins[6]);
  adc[7] = digitalRead(pins[7]);

  /* 
    Escribimos los bits leidos al byte 
    a enviar por el pin TX.
  */
  bitWrite(outByte,0,adc[0]);
  bitWrite(outByte,1,adc[1]);
  bitWrite(outByte,2,adc[2]);
  bitWrite(outByte,3,adc[3]);
  bitWrite(outByte,4,adc[4]);
  bitWrite(outByte,5,adc[5]);
  bitWrite(outByte,6,adc[6]);
  bitWrite(outByte,7,adc[7]);

  /* Escribimos el byte por el pin TX */
  Serial.write(outByte);

  /* Delay de 50 ms */
  //delay(50);
  
}
