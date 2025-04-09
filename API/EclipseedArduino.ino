void setup()
{
  	Serial.begin(9600);
}

void loop(){

  int n;

  // Recebendo o valor lido pelo sensor
  n = analogRead(A0);
  
  // Label para Iluminação
  // Serial.print("Iluminação:");
  Serial.println(n);
  
  // Esperar 2000 milisegundos para repetir
  delay(2000); 
}