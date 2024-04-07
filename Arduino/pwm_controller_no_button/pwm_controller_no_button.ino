int analogPin1 = A1; 
int analogPin3 = A3;
int Isns = 0;  // variable to store the value read
int vload = 0; // variable load voltage

double Icrit = 645;  //526 1A, 580 5A, 600 6.4A, 650 9.5A, 655 10.1A
double Vcrit = 145; // Critical voltage value (div 4, Vmax 13.2, Vcrit = 675.84 (out of 1024))
                              // 1024 at output voltage correspond 20V
double DC_step = 1; // 0.01*160/100 ; //%100 DC = 160, 

void setup ()
{
  Serial.begin(600);   
  pinMode (3, OUTPUT) ;
  TCCR2A = 0x23 ;
  TCCR2B = 0x09 ; // mode 7, clock prescale by 1
  OCR2A = 160-1 ;  // 160 clock periods = 10us per cycle
  OCR2B =0 ;
  TCNT2 =0 ;
  delay(5000);
}
void loop ()
{
  // here you can set the duty cycle by writing values between 0 and 160 to 
  //OCR2B = 80;

  vload = analogRead(analogPin1); // read the input pin - VOLTAGE SENSE
  Isns = analogRead(analogPin3);  // read the input pin - CURRENT SENSE (512 -> 2.5V voltage offset)
 
  Serial.println("Current");   Serial.println(Isns);          // debugging purpose
  Serial.println("Voltage");   Serial.println(vload);         // debugging purpose
  Serial.println(OCR2B);                                      // debugging purpose

  if ((Isns<=Icrit) & (vload<=Vcrit)) {   
    Serial.println("Safe");
    if (OCR2B <144){      
      OCR2B = OCR2B + DC_step;
    }  
  } 
  else if (OCR2B > 0) {
    Serial.println("Fail");
    OCR2B = OCR2B - 1;
 }
}