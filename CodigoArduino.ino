void setup()
{
  	Serial.begin(9600);
}

void loop(){

  int n;

  // Recebendo o valor lido pelo sensor
  n = analogRead(A0);
  
  // Label para Máximo
  Serial.print("Máxima:");
  Serial.print(801);
  Serial.print(" ");
  // Label para Iluminação
  Serial.print("Iluminação:");
  Serial.print(n);
  Serial.print(" ");
  // Label para Mínimo
  Serial.print("Mínima:");
  Serial.println(349);
  
  // Esperar 2000 milisegundos para repetir
  delay(2000); 
}