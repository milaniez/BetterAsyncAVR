/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.0 Professional
Automatic Program Generator
© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 6/13/2011
Author  : NeVaDa
Company : 
Comments: 


Chip type               : ATmega16
Program type            : Application
AVR Core Clock frequency: 12.000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 256
*****************************************************/
#define NORMAL_DELAY     1
#define TIMER_DELAY      2
#define GLCD_DELAY_TYPE  TIMER_DELAY
#include <mega16.h>

#include <glcd128x64td.h>
#include <delay.h>

#if GLCD_DELAY_TYPE == TIMER_DELAY
// Timer 0 output compare interrupt service routine
interrupt [TIM0_COMP] void timer0_comp_isr(void)
{
// Place your code here
  timer_isr();
}
#endif

#if GLCD_DELAY_TYPE == TIMER_DELAY
unsigned char TCCR0_value = 0x09;
void timer_start (void)
{
  TCCR0 = TCCR0_value;
}

void timer_stop (void)
{
  TCCR0 = 0x08;
  TCNT0 = 0x00;
}

void set_ctc_7us (void)
{
  TCCR0_value = 0x09;
  OCR0 = 0x53;
}

void set_ctc_10ms (void)
{
  TCCR0_value = 0x0D;
  OCR0 = 0x74;
}

/*void portc_tgl(void)
{
/}*/
#endif

// Declare your global variables here
flash char glcd_intro_bmp[1024] = {
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  2,  2,254,254,254, 
 254,  2,  2,  0,  0,  2,  2,254,254,254,254,  2,  2,  0,  0,  0, 
   0,  2,  2,254,  2,  2,  0,  0,126, 30,  6,  2,  2,254,254,254, 
 254,  2,  2,  6, 30,126,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255, 
 255,  0,  0,  0,  0,  0,  0,255,255,255,255,  0,  0,  0,  0,  0, 
   0,  0,  0,255,  0,  0,  0,  0,  0,  0,  0,  0,  0,255,255,255, 
 255,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,128,128,128,128,  0,128,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  4,  4,  7,  7,  7, 
   7,  4,  4,  0,  0,  0,128,128,129,131,135,  7,  6,  4,  4,  4, 
 132,130,131,128,128,  0,  0,  0,  0,  0,  4,  4,  4,  7,135,135, 
 135,  4,  4,  4,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0, 14, 25, 48, 48, 48, 97, 99,199,128,  0,  0, 32, 
 224,224,  0,  0, 32,224,224,  0,  0,  0, 32,224,224, 64, 32, 32, 
  32,192,128,  0,  0,128,192, 32, 32, 32,192,128,  0,  0, 32,224, 
 224, 64, 32, 96, 96,  0,  0,  0,255,  1, 31,254,224,  0,224, 30, 
   1,255,255,  0,  0,  0,  0,  0, 32,227,227,  0,  0,  0,  0,255, 
 255,  0,  0,  0,128,192, 32, 32, 32,192,128,  0,  0,192,224, 32, 
  32, 32,224,192,  0,  0,  0,192,224, 32, 32, 32,192,192, 96, 96, 
   0,128,192, 32, 32, 32,192,128,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0, 30, 12,  8, 16, 16, 16, 16,  8,  7,  0,  0,  0, 
  15, 31, 16, 16,  8, 31, 31, 16,  0,  0,  0,255,255,  8, 16, 16, 
  16, 15,  7,  0,  0,  7, 15, 17, 17, 17, 17,  9,  0,  0, 16, 31, 
  31, 16, 16,  0,  0,  0, 16, 16, 31, 16, 16,  1, 31, 30,  1, 16, 
  16, 31, 31, 16, 16,  0,  0,  0, 16, 31, 31, 16,  0,  0, 16, 31, 
  31, 16,  0,  0,  7, 15, 17, 17, 17, 17,  9,  0,  0, 12, 30, 19, 
  17,  9, 31, 31, 16,  0,  0,185,119, 52, 52, 52, 55, 51,224,  0, 
   0,  7, 15, 17, 17, 17, 17,  9,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  2,  3,  3,  2,  2,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,128,128,224,224,128, 
 128,128,  0,  0,  0,  0,128,128,128,  0,  0,  0,  0,  0,128,128, 
 128,128,128,  0,  0,  0,  0,128,128,128,  0,128,128,128,  0,  0, 
 128,128,128,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  1,  2,  2,  2,  2,  2,  1,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 63,127, 64, 
  64, 32,  0,  0, 30, 63, 68, 68, 68, 71, 38,  0,  0, 51,123, 76, 
  68, 36,127,127, 64,  0,  0, 64,127,127, 65,  0, 64,127,127, 65, 
   0, 64,127,127, 64,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 
};
void main(void)
{
// Declare your local variables here

// Input/Output Ports initialization
// Port A initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTA=0x00;
DDRA=0x00;

// Port B initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTB=0x00;
DDRB=0x00;

// Port C initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTC=0x00;
DDRC=0xFF;

// Port D initialization
// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
PORTD=0x00;
DDRD=0x00;

#if GLCD_DELAY_TYPE == NORMAL_DELAY
// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: Normal top=0xFF
// OC0 output: Disconnected
TCCR0=0x00;
TCNT0=0x00;
OCR0=0x00;
#elif GLCD_DELAY_TYPE == TIMER_DELAY
// Timer/Counter 0 initialization
// Clock source: System Clock
// Clock value: Timer 0 Stopped
// Mode: CTC top=OCR0
// OC0 output: Disconnected
TCCR0=0x08;
TCNT0=0x00;
OCR0 = 0x53/*((unsigned char)((_MCU_CLOCK_FREQUENCY_*7)/1000000))*/;
#endif

// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer1 Stopped
// Mode: Normal top=0xFFFF
// OC1A output: Discon.
// OC1B output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer1 Overflow Interrupt: Off
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: Timer2 Stopped
// Mode: Normal top=0xFF
// OC2 output: Disconnected
ASSR=0x00;
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
MCUCR=0x00;
MCUCSR=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
#if GLCD_DELAY_TYPE == NORMAL_DELAY
TIMSK=0x00;
#elif GLCD_DELAY_TYPE == TIMER_DELAY
TIMSK=0x02;
#endif

// USART initialization
// USART disabled
UCSRB=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
ACSR=0x80;
SFIOR=0x00;

// ADC initialization
// ADC disabled
ADCSRA=0x00;

// SPI initialization
// SPI disabled
SPCR=0x00;

// TWI initialization
// TWI disabled
TWCR=0x00;

#if GLCD_DELAY_TYPE == TIMER_DELAY
// Global enable interrupts
#asm("sei")
#endif

#if GLCD_DELAY_TYPE == TIMER_DELAY
timer_interrupt_enable = (void (*)())(timer_start);
timer_interrupt_disable = (void (*)())(timer_stop);
set_delay_7us = (void (*)())(set_ctc_7us);
set_delay_10ms = (void (*)())(set_ctc_10ms);
//glcd_free_fcn = (void (*)())(portc_tgl);
#endif

glcd_define (&PORTB, &PORTA, 2, &PORTA, 3, &PORTA, 4, &PORTA, 5, &PORTA, 6, &PORTA, 7);
glcd_init ();
while (glcd_status());
glcd_clear();
while (glcd_status());
glcd_putsf (3,3,"Mehdi Zeinali");
while (glcd_status());
glcd_putbmp(glcd_intro_bmp);
while (glcd_status());
delay_ms(1000);
glcd_clear();

while (1)
      {
      // Place your code here
      }
}
