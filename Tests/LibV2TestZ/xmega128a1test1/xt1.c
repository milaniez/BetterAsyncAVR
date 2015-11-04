/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.0 Professional
Automatic Program Generator
© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 8/25/2011
Author  : NeVaDa
Company : 
Comments: 


Chip type               : ATxmega128A1
Program type            : Application
AVR Core Clock frequency: 32.000000 MHz
Memory model            : Small
Data Stack size         : 2048
*****************************************************/

// I/O Registers definitions
#include <io.h>
#include <stdio.h>

// Declare your global variables here


//#define Debugging

#ifndef _ATXMEGA_DEVICE_
#include <iobits.h>
#endif

// Global Variables
static unsigned char *glcd_data_address;
static unsigned char *glcd_rs_address;
#ifdef _ATXMEGA_DEVICE_
static unsigned char glcd_rs_bit_msk;
#else
static unsigned char glcd_rs_bit_pos;
#endif
static unsigned char *glcd_rw_address;
#ifdef _ATXMEGA_DEVICE_
static unsigned char glcd_rw_bit_msk;
#else
static unsigned char glcd_rw_bit_pos;
#endif
static unsigned char *glcd_en_address;
#ifdef _ATXMEGA_DEVICE_
static unsigned char glcd_en_bit_msk;
#else
static unsigned char glcd_en_bit_pos;
#endif
static unsigned char *glcd_cs1_address;
#ifdef _ATXMEGA_DEVICE_
static unsigned char glcd_cs1_bit_msk;
#else
static unsigned char glcd_cs1_bit_pos;
#endif
static unsigned char *glcd_cs2_address;
#ifdef _ATXMEGA_DEVICE_
static unsigned char glcd_cs2_bit_msk;
#else
static unsigned char glcd_cs2_bit_pos;
#endif
static unsigned char *glcd_rst_address;
#ifdef _ATXMEGA_DEVICE_
static unsigned char glcd_rst_bit_msk;
#else
static unsigned char glcd_rst_bit_pos;
#endif

flash char glcd_font [91][6] =
{
    { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },   // sp
    { 0x00, 0x00, 0x5F, 0x00, 0x00, 0x00 },   // !
    { 0x00, 0x00, 0x5F, 0x00, 0x00, 0x00 },   // "
    { 0x14, 0x7F, 0x14, 0x7F, 0x14, 0x00 },   // #
    { 0x24, 0x2A, 0x7F, 0x2A, 0x12, 0x00 },   // $
    { 0x23, 0x13, 0x08, 0x64, 0x62, 0x00 },   // %
    { 0x36, 0x49, 0x55, 0x22, 0x50, 0x00 },   // &
    { 0x00, 0x05, 0x03, 0x00, 0x00, 0x00 },   // '
    { 0x00, 0x1C, 0x22, 0x41, 0x00, 0x00 },   // (
    { 0x00, 0x41, 0x22, 0x1C, 0x00, 0x00 },   // )
    { 0x08, 0x2A, 0x1C, 0x2A, 0x08, 0x00 },   // *
    { 0x08, 0x08, 0x3E, 0x08, 0x08, 0x00 },   // +
    { 0x00, 0x50, 0x30, 0x00, 0x00, 0x00 },   // ,
    { 0x08, 0x08, 0x08, 0x08, 0x08, 0x00 },   // -
    { 0x00, 0x30, 0x30, 0x00, 0x00, 0x00 },   // .
    { 0x20, 0x10, 0x08, 0x04, 0x02, 0x00 },   // /
    { 0x3E, 0x51, 0x49, 0x45, 0x3E, 0x00 },   // 0
    { 0x00, 0x42, 0x7F, 0x40, 0x00, 0x00 },   // 1
    { 0x42, 0x61, 0x51, 0x49, 0x46, 0x00 },   // 2
    { 0x21, 0x41, 0x45, 0x4B, 0x31, 0x00 },   // 3
    { 0x18, 0x14, 0x12, 0x7F, 0x10, 0x00 },   // 4
    { 0x27, 0x45, 0x45, 0x45, 0x39, 0x00 },   // 5
    { 0x3C, 0x4A, 0x49, 0x49, 0x30, 0x00 },   // 6
    { 0x01, 0x71, 0x09, 0x05, 0x03, 0x00 },   // 7
    { 0x36, 0x49, 0x49, 0x49, 0x36, 0x00 },   // 8
    { 0x06, 0x49, 0x49, 0x29, 0x1E, 0x00 },   // 9
    { 0x00, 0x36, 0x36, 0x00, 0x00, 0x00 },   // :
    { 0x00, 0x56, 0x36, 0x00, 0x00, 0x00 },   // ;
    { 0x00, 0x08, 0x14, 0x22, 0x41, 0x00 },   // <
    { 0x14, 0x14, 0x14, 0x14, 0x14, 0x00 },   // =
    { 0x41, 0x22, 0x14, 0x08, 0x00, 0x00 },   // >
    { 0x02, 0x01, 0x51, 0x09, 0x06, 0x00 },   // ?
    { 0x32, 0x49, 0x79, 0x41, 0x3E, 0x00 },   // @
    { 0x7E, 0x11, 0x11, 0x11, 0x7E, 0x00 },   // A
    { 0x7F, 0x49, 0x49, 0x49, 0x36, 0x00 },   // B
    { 0x3E, 0x41, 0x41, 0x41, 0x22, 0x00 },   // C
    { 0x7F, 0x41, 0x41, 0x22, 0x1C, 0x00 },   // D
    { 0x7F, 0x49, 0x49, 0x49, 0x41, 0x00 },   // E
    { 0x7F, 0x09, 0x09, 0x01, 0x01, 0x00 },   // F
    { 0x3E, 0x41, 0x41, 0x51, 0x32, 0x00 },   // G
    { 0x7F, 0x08, 0x08, 0x08, 0x7F, 0x00 },   // H
    { 0x00, 0x41, 0x7F, 0x41, 0x00, 0x00 },   // I
    { 0x20, 0x40, 0x41, 0x3F, 0x01, 0x00 },   // J
    { 0x7F, 0x08, 0x14, 0x22, 0x41, 0x00 },   // K
    { 0x7F, 0x40, 0x40, 0x40, 0x40, 0x00 },   // L
    { 0x7F, 0x02, 0x04, 0x02, 0x7F, 0x00 },   // M
    { 0x7F, 0x04, 0x08, 0x10, 0x7F, 0x00 },   // N
    { 0x3E, 0x41, 0x41, 0x41, 0x3E, 0x00 },   // O
    { 0x7F, 0x09, 0x09, 0x09, 0x06, 0x00 },   // P
    { 0x3E, 0x41, 0x51, 0x21, 0x5E, 0x00 },   // Q
    { 0x7F, 0x09, 0x19, 0x29, 0x46, 0x00 },   // R
    { 0x46, 0x49, 0x49, 0x49, 0x31, 0x00 },   // S
    { 0x01, 0x01, 0x7F, 0x01, 0x01, 0x00 },   // T
    { 0x3F, 0x40, 0x40, 0x40, 0x3F, 0x00 },   // U
    { 0x1F, 0x20, 0x40, 0x20, 0x1F, 0x00 },   // V
    { 0x7F, 0x20, 0x18, 0x20, 0x7F, 0x00 },   // W
    { 0x63, 0x14, 0x08, 0x14, 0x63, 0x00 },   // X
    { 0x03, 0x04, 0x78, 0x04, 0x03, 0x00 },   // Y
    { 0x61, 0x51, 0x49, 0x45, 0x43, 0x00 },   // Z
    { 0x00, 0x00, 0x7F, 0x41, 0x41, 0x00 },   // [
    { 0x02, 0x04, 0x08, 0x10, 0x20, 0x00 },   // 55
    { 0x41, 0x41, 0x7F, 0x00, 0x00, 0x00 },   // ]
    { 0x04, 0x02, 0x01, 0x02, 0x04, 0x00 },   // ^
    { 0x40, 0x40, 0x40, 0x40, 0x40, 0x00 },   // _
    { 0x00, 0x01, 0x02, 0x04, 0x00, 0x00 },   // '
    { 0x20, 0x54, 0x54, 0x54, 0x78, 0x00 },   // a
    { 0x7F, 0x48, 0x44, 0x44, 0x38, 0x00 },   // b
    { 0x38, 0x44, 0x44, 0x44, 0x20, 0x00 },   // c
    { 0x38, 0x44, 0x44, 0x48, 0x7F, 0x00 },   // d
    { 0x38, 0x54, 0x54, 0x54, 0x18, 0x00 },   // e
    { 0x08, 0x7E, 0x09, 0x01, 0x02, 0x00 },   // f
    { 0x08, 0x14, 0x54, 0x54, 0x3C, 0x00 },   // g
    { 0x7F, 0x08, 0x04, 0x04, 0x78, 0x00 },   // h
    { 0x00, 0x44, 0x7D, 0x40, 0x00, 0x00 },   // i
    { 0x20, 0x40, 0x44, 0x3D, 0x00, 0x00 },   // j
    { 0x00, 0x7F, 0x10, 0x28, 0x44, 0x00 },   // k
    { 0x00, 0x41, 0x7F, 0x40, 0x00, 0x00 },   // l
    { 0x7C, 0x04, 0x18, 0x04, 0x78, 0x00 },   // m
    { 0x7C, 0x08, 0x04, 0x04, 0x78, 0x00 },   // n
    { 0x38, 0x44, 0x44, 0x44, 0x38, 0x00 },   // o
    { 0x7C, 0x14, 0x14, 0x14, 0x08, 0x00 },   // p
    { 0x08, 0x14, 0x14, 0x18, 0x7C, 0x00 },   // q
    { 0x7C, 0x08, 0x04, 0x04, 0x08, 0x00 },   // r
    { 0x48, 0x54, 0x54, 0x54, 0x20, 0x00 },   // s
    { 0x04, 0x3F, 0x44, 0x40, 0x20, 0x00 },   // t
    { 0x3C, 0x40, 0x40, 0x20, 0x7C, 0x00 },   // u
    { 0x1C, 0x20, 0x40, 0x20, 0x1C, 0x00 },   // v
    { 0x3C, 0x40, 0x30, 0x40, 0x3C, 0x00 },   // w
    { 0x44, 0x28, 0x10, 0x28, 0x44, 0x00 },   // x
    { 0x0C, 0x50, 0x50, 0x50, 0x3C, 0x00 },   // y
    { 0x44, 0x64, 0x54, 0x4C, 0x44, 0x00 }    // z
};

// Bit Control
#ifdef _ATXMEGA_DEVICE_
#define set_rs  *(glcd_rs_address  + 0x01) = glcd_rs_bit_msk
#define set_rw  *(glcd_rw_address  + 0x01) = glcd_rw_bit_msk
#define set_en  *(glcd_en_address  + 0x01) = glcd_en_bit_msk
#define set_cs1 *(glcd_cs1_address + 0x01) = glcd_cs1_bit_msk
#define set_cs2 *(glcd_cs2_address + 0x01) = glcd_cs2_bit_msk
#define set_rst *(glcd_rst_address + 0x01) = glcd_rst_bit_msk
#define clr_rs  *(glcd_rs_address  + 0x02) = glcd_rs_bit_msk
#define clr_rw  *(glcd_rw_address  + 0x02) = glcd_rw_bit_msk
#define clr_en  *(glcd_en_address  + 0x02) = glcd_en_bit_msk
#define clr_cs1 *(glcd_cs1_address + 0x02) = glcd_cs1_bit_msk
#define clr_cs2 *(glcd_cs2_address + 0x02) = glcd_cs2_bit_msk
#define clr_rst *(glcd_rst_address + 0x02) = glcd_rst_bit_msk
#define tgl_rs  *(glcd_rs_address  + 0x03) = glcd_rs_bit_msk
#define tgl_rw  *(glcd_rw_address  + 0x03) = glcd_rw_bit_msk
#define tgl_en  *(glcd_en_address  + 0x03) = glcd_en_bit_msk
#define tgl_cs1 *(glcd_cs1_address + 0x03) = glcd_cs1_bit_msk
#define tgl_cs2 *(glcd_cs2_address + 0x03) = glcd_cs2_bit_msk
#define tgl_rst *(glcd_rst_address + 0x03) = glcd_rst_bit_msk
#else
#define set_rs  SETBIT(*glcd_rs_address, glcd_rs_bit_pos)
#define set_rw  SETBIT(*glcd_rw_address, glcd_rw_bit_pos)
#define set_en  SETBIT(*glcd_en_address, glcd_en_bit_pos)
#define set_cs1 SETBIT(*glcd_cs1_address,glcd_cs1_bit_pos)
#define set_cs2 SETBIT(*glcd_cs2_address,glcd_cs2_bit_pos)
#define set_rst SETBIT(*glcd_rst_address,glcd_rst_bit_pos)
#define clr_rs  CLRBIT(*glcd_rs_address, glcd_rs_bit_pos)
#define clr_rw  CLRBIT(*glcd_rw_address, glcd_rw_bit_pos)
#define clr_en  CLRBIT(*glcd_en_address, glcd_en_bit_pos)
#define clr_cs1 CLRBIT(*glcd_cs1_address,glcd_cs1_bit_pos)
#define clr_cs2 CLRBIT(*glcd_cs2_address,glcd_cs2_bit_pos)
#define clr_rst CLRBIT(*glcd_rst_address,glcd_rst_bit_pos)
#define tgl_rs  TGLBIT(*glcd_rs_address, glcd_rs_bit_pos)
#define tgl_rw  TGLBIT(*glcd_rw_address, glcd_rw_bit_pos)
#define tgl_en  TGLBIT(*glcd_en_address, glcd_en_bit_pos)
#define tgl_cs1 TGLBIT(*glcd_cs1_address,glcd_cs1_bit_pos)
#define tgl_cs2 TGLBIT(*glcd_cs2_address,glcd_cs2_bit_pos)
#define tgl_rst TGLBIT(*glcd_rst_address,glcd_rst_bit_pos)
#endif

#define NumberOfCases 33
         unsigned int  CaseAddress[NumberOfCases];
register unsigned int  CaseAddressIndex @0x02; //R3:R2
#define  GotoAddress   CaseAddressIndex

// External (user's) functions
void glcd_define (unsigned char *glcd_data_port_address,
                  unsigned char *glcd_rs_port_address,  unsigned char glcd_rs_pin,
                  unsigned char *glcd_rw_port_address,  unsigned char glcd_rw_pin,
                  unsigned char *glcd_en_port_address,  unsigned char glcd_en_pin,
                  unsigned char *glcd_cs1_port_address, unsigned char glcd_cs1_pin,
                  unsigned char *glcd_cs2_port_address, unsigned char glcd_cs2_pin,
                  unsigned char *glcd_rst_port_address, unsigned char glcd_rst_pin)
{
    glcd_data_address = glcd_data_port_address;
    glcd_rs_address   = glcd_rs_port_address;
    glcd_rw_address   = glcd_rw_port_address;
    glcd_en_address   = glcd_en_port_address;
    glcd_cs1_address  = glcd_cs1_port_address;
    glcd_cs2_address  = glcd_cs2_port_address;
    glcd_rst_address  = glcd_rst_port_address;
#ifdef _ATXMEGA_DEVICE_
    glcd_rs_bit_msk  = 0b00000001 << glcd_rs_pin;
    glcd_rw_bit_msk  = 0b00000001 << glcd_rw_pin;
    glcd_en_bit_msk  = 0b00000001 << glcd_en_pin;
    glcd_cs1_bit_msk = 0b00000001 << glcd_cs1_pin;
    glcd_cs2_bit_msk = 0b00000001 << glcd_cs2_pin;
    glcd_rst_bit_msk = 0b00000001 << glcd_rst_pin;
    // Set all the pins as output
    *(glcd_data_address - 0x03) = 0xFF;
    *(glcd_rs_address - 0x03)   = glcd_rs_bit_msk;
    clr_rw;
    *(glcd_rw_address - 0x03)   = glcd_rw_bit_msk;
    *(glcd_en_address - 0x03)   = glcd_en_bit_msk;
    *(glcd_cs1_address - 0x03)  = glcd_cs1_bit_msk;
    *(glcd_cs2_address - 0x03)  = glcd_cs2_bit_msk;
    *(glcd_rst_address - 0x03)  = glcd_rst_bit_msk;
#else
    glcd_rs_bit_pos  = glcd_rs_pin;
    glcd_rw_bit_pos  = glcd_rw_pin;
    glcd_en_bit_pos  = glcd_en_pin;
    glcd_cs1_bit_pos = glcd_cs1_pin;
    glcd_cs2_bit_pos = glcd_cs2_pin;
    glcd_rst_bit_pos = glcd_rst_pin;
    // Sets the pins as output
    *(glcd_data_address - 1) = 0xFF;
    SETBIT (*(glcd_rs_address - 0x01),glcd_rs_bit_pos);
    SETBIT (*(glcd_rw_address - 0x01),glcd_rw_bit_pos);
    clr_rw;
    SETBIT (*(glcd_en_address - 0x01),glcd_en_bit_pos);
    SETBIT (*(glcd_cs1_address - 0x01),glcd_cs1_bit_pos);
    SETBIT (*(glcd_cs2_address - 0x01),glcd_cs2_bit_pos);
    SETBIT (*(glcd_rst_address - 0x01),glcd_rst_bit_pos);
#endif
#asm
    LDI        R30, LOW(_CaseAddress)
    LDI     R31, HIGH(_CaseAddress)
    ;//Save R16, R17
    PUSH    R16
    PUSH    R17
    ;//Load #1 case for delay function
    LDI     R16, LOW(DelayLabel1)
    LDI        R17, HIGH(DelayLabel1)
    ST        Z+,  R16
    ST        Z+,  R17
    ;//Load #2 case for delay function
    LDI     R16, LOW(DelayLabel2)
    LDI        R17, HIGH(DelayLabel2)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdUnlockLockLabel1)
    LDI        R17, HIGH(GlcdUnlockLockLabel1)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdUnlockLockLabel2)
    LDI        R17, HIGH(GlcdUnlockLockLabel2)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdUnlockLockLabel3)
    LDI        R17, HIGH(GlcdUnlockLockLabel3)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdInitLabel1)
    LDI        R17, HIGH(GlcdInitLabel1)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdInitLabel2)
    LDI        R17, HIGH(GlcdInitLabel2)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdInitLabel3)
    LDI        R17, HIGH(GlcdInitLabel3)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdInitLabel4)
    LDI        R17, HIGH(GlcdInitLabel4)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdInitLabel5)
    LDI        R17, HIGH(GlcdInitLabel5)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdInitLabel6)
    LDI        R17, HIGH(GlcdInitLabel6)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdInitLabel7)
    LDI        R17, HIGH(GlcdInitLabel7)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdInitLabel8)
    LDI        R17, HIGH(GlcdInitLabel8)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdWriteByteLabel1)
    LDI        R17, HIGH(GlcdWriteByteLabel1)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdWriteByteLabel2)
    LDI        R17, HIGH(GlcdWriteByteLabel2)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdWriteByteLabel3)
    LDI        R17, HIGH(GlcdWriteByteLabel3)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdWriteByteLabel4)
    LDI        R17, HIGH(GlcdWriteByteLabel4)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdClearPageLabel1)
    LDI        R17, HIGH(GlcdClearPageLabel1)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdClearPageLabel2)
    LDI        R17, HIGH(GlcdClearPageLabel2)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdPutcharLabel1)
    LDI        R17, HIGH(GlcdPutcharLabel1)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdPutcharLabel2)
    LDI        R17, HIGH(GlcdPutcharLabel2)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdPutsLabel1)
    LDI        R17, HIGH(GlcdPutsLabel1)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdPutsLabel2)
    LDI        R17, HIGH(GlcdPutsLabel2)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdPutsCenterLabel1)
    LDI        R17, HIGH(GlcdPutsCenterLabel1)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdPutsCenterLabel2)
    LDI        R17, HIGH(GlcdPutsCenterLabel2)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdPutsfLabel1)
    LDI        R17, HIGH(GlcdPutsfLabel1)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdPutsfLabel2)
    LDI        R17, HIGH(GlcdPutsfLabel2)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdPutsfCenterLabel1)
    LDI        R17, HIGH(GlcdPutsfCenterLabel1)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdPutsfCenterLabel2)
    LDI        R17, HIGH(GlcdPutsfCenterLabel2)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdClearLabel1)
    LDI        R17, HIGH(GlcdClearLabel1)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdClearLabel2)
    LDI        R17, HIGH(GlcdClearLabel2)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdPutbmpLabel1)
    LDI        R17, HIGH(GlcdPutbmpLabel1)
    ST        Z+,  R16
    ST        Z+,  R17
    
    LDI     R16, LOW(GlcdPutbmpLabel2)
    LDI        R17, HIGH(GlcdPutbmpLabel2)
    ST        Z+,  R16
    ST        Z+,  R17
    
    POP        R17
    POP        R16
#endasm
}

// Timer function pointers
void (*timer_interrupt_enable) (void);

void (*timer_interrupt_disable) (void);

void (*set_delay_7us) (void);

void (*set_delay_10ms) (void);

#define StackSize     10
enum cases
{
    DelayCase1 = 0,
    DelayCase2,
    GlcdUnlockLockCase1,
    GlcdUnlockLockCase2,
    GlcdUnlockLockCase3,
    GlcdInitCase1,
    GlcdInitCase2,
    GlcdInitCase3,
    GlcdInitCase4,
    GlcdInitCase5,
    GlcdInitCase6,
    GlcdInitCase7,
    GlcdInitCase8,
    GlcdWriteByteCase1,
    GlcdWriteByteCase2,
    GlcdWriteByteCase3,
    GlcdWriteByteCase4,
    GlcdClearPageCase1,
    GlcdClearPageCase2,
    GlcdPutcharCase1,
    GlcdPutcharCase2,
    GlcdPutsCase1,
    GlcdPutsCase2,
    GlcdPutsCenterCase1,
    GlcdPutsCenterCase2,
    GlcdPutsfCase1,
    GlcdPutsfCase2,
    GlcdPutsfCenterCase1,
    GlcdPutsfCenterCase2,
    GlcdClearCase1,
    GlcdClearCase2,
    GlcdPutbmpCase1,
    GlcdPutbmpCase2
} CaseStack[StackSize];
unsigned char StackPointer = 0xFF;
#define GlcdBusy (~StackPointer)

unsigned char PushCase (enum cases Case)
{
    if (((StackPointer + 1) < StackSize) || (StackPointer == 0xFF) )
    {
        StackPointer++;
        CaseStack[StackPointer] = Case;
        return 0;
    }
    else
        return 1;
}

unsigned char PopCase (void)
{
    if (~StackPointer)
    {
        StackPointer--;
        return 0;
    }
    else
        return 1;
}

unsigned char strlen_char (unsigned char *str)
{
    unsigned char i;
    for (i = 0; *str++ != 0;i++);
    return i;
}

unsigned char strlenf_char (flash unsigned char *str)
{
    unsigned char i;
    for (i = 0; *str++ != 0;i++);
    return i;
}

#define IndirectGoto    do\
                        {\
                            #asm("MOV    R30, R2")\
                            #asm("MOV    R31, R3")\
                            #asm("IJMP")\
                        } while (0)

#define GotoNextCase    if ((~StackPointer))\
                        {\
                            GotoAddress = CaseAddress[CaseStack[StackPointer]];\
                            IndirectGoto;\
                        }\
                        else\
                            return

#define SetCurrentCase(CCase)    CaseStack[StackPointer] = CCase

#define StackPlus(Case,Label)   do\
                                {\
                                    SetCurrentCase(Case);\
                                    StackPointer++;\
                                    goto Label;\
                                }\
                                while (0)

#define StackMinus()            do\
                                {\
                                    PopCase();\
                                    GotoNextCase;\
                                }\
                                while (0)

#define DebugDisplay(Pos,Char)  do\
                                {\
                                    lcd_gotoxy(0,0);\
                                    lcd_putsf("          ");\
                                    lcd_gotoxy(Pos,0);\
                                    lcd_putchar(Char);\
                                }\
                                while (0)

unsigned char GlcdPage;
unsigned char GlcdColumn;
unsigned char GlcdDataByte;
unsigned char GlcdChar;
unsigned char *GlcdString;
flash unsigned char *GlcdFlashString;
flash unsigned char *GlcdFlashPointer;

void glcd_timer_isr (void)
{
    static unsigned char i;
    static unsigned int  j;
    if (StackPointer != 0xFF)
    {
        if (StackPointer == 0x00)
        {
            GotoNextCase;
        }
/////////////////////////////////////////////////////////////////////////
#asm
DelayLabel2:
#endasm
DelayLabel2:
        (*timer_interrupt_disable)();
#ifdef Debugging
        DebugDisplay(0x0,'2');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        StackMinus();
#asm
DelayLabel1:
#endasm
DelayLabel1:
#ifdef Debugging
        DebugDisplay(0x0,'1');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        SetCurrentCase(DelayCase2);
        (*timer_interrupt_enable)();
        return;
#asm
GlcdUnlockLockLabel3:
#endasm
GlcdUnlockLockLabel3:
#ifdef Debugging
        DebugDisplay(0x1,'3');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        clr_en;
        StackMinus();
#asm
GlcdUnlockLockLabel2:
#endasm
GlcdUnlockLockLabel2:
#ifdef Debugging
        DebugDisplay(0x1,'2');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        set_en;
        StackPlus(GlcdUnlockLockCase3,DelayLabel1);
#asm
GlcdUnlockLockLabel1:
#endasm
GlcdUnlockLockLabel1:
#ifdef Debugging
        DebugDisplay(0x1,'1');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        (*set_delay_7us)();
        StackPlus(GlcdUnlockLockCase2,DelayLabel1);
#asm
GlcdInitLabel8:
#endasm
GlcdInitLabel8:
#ifdef Debugging
        DebugDisplay(0x2,'8');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        StackMinus();
#asm
GlcdInitLabel7:
#endasm
GlcdInitLabel7:
#ifdef Debugging
        DebugDisplay(0x2,'7');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        tgl_cs1;
        tgl_cs2;
        *glcd_data_address = 0x3E;
        StackPlus(GlcdInitCase4,GlcdUnlockLockLabel1);
#asm
GlcdInitLabel6:
#endasm
GlcdInitLabel6:
#ifdef Debugging
        DebugDisplay(0x2,'6');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        *glcd_data_address = 0x3F;
        i++;
        if (i < 2)
            SetCurrentCase(GlcdInitCase7);
        else
            SetCurrentCase(GlcdInitCase8);
        StackPointer++;
        #asm("JMP GlcdUnlockLockLabel1")
#asm
GlcdInitLabel5:
#endasm
GlcdInitLabel5:
#ifdef Debugging
        DebugDisplay(0x2,'5');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        *glcd_data_address = 0xB8;
        StackPlus(GlcdInitCase6,GlcdUnlockLockLabel1);
#asm
GlcdInitLabel4:
#endasm
GlcdInitLabel4:
#ifdef Debugging
        DebugDisplay(0x2,'4');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        *glcd_data_address = 0x40;
        StackPlus(GlcdInitCase5,GlcdUnlockLockLabel1);
#asm
GlcdInitLabel3:
#endasm
GlcdInitLabel3:
#ifdef Debugging
        DebugDisplay(0x2,'3');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        clr_rs;
        clr_cs1;
        set_cs2;
        *glcd_data_address = 0x3E;
        StackPlus(GlcdInitCase4,GlcdUnlockLockLabel1);
#asm
GlcdInitLabel2:
#endasm
GlcdInitLabel2:
#ifdef Debugging
        DebugDisplay(0x2,'2');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        set_rst;
        StackPlus(GlcdInitCase3,DelayLabel1);
#asm
GlcdInitLabel1:
#endasm
GlcdInitLabel1:
        i = 0;
        clr_rst;
        (*set_delay_10ms)();
#ifdef Debugging
        DebugDisplay(0x2,'1');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        StackPlus(GlcdInitCase2,DelayLabel1);
#asm
GlcdWriteByteLabel4:
#endasm
GlcdWriteByteLabel4:
#ifdef Debugging
        DebugDisplay(0x3,'4');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        StackMinus();
#asm
GlcdWriteByteLabel3:
#endasm
GlcdWriteByteLabel3:
#ifdef Debugging
        DebugDisplay(0x3,'3');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        set_rs;
        clr_rw;
        *glcd_data_address = GlcdDataByte;
        StackPlus(GlcdWriteByteCase4,GlcdUnlockLockLabel1);
#asm
GlcdWriteByteLabel2:
#endasm
GlcdWriteByteLabel2:
#ifdef Debugging
        DebugDisplay(0x3,'2');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        clr_rs;
        clr_rw;
        *glcd_data_address = 0x40 | GlcdColumn;
        StackPlus(GlcdWriteByteCase3,GlcdUnlockLockLabel1);
#asm
GlcdWriteByteLabel1:
#endasm
GlcdWriteByteLabel1:
#ifdef Debugging
        DebugDisplay(0x3,'1');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        if(GlcdColumn >= 64)
        {
            clr_cs1;
            set_cs2;
        }
        else
        {
            set_cs1;
            clr_cs2;
        }
        clr_rs;
        clr_rw;
        *glcd_data_address = 0xB8 | GlcdPage;
        StackPlus(GlcdWriteByteCase2,GlcdUnlockLockLabel1);
#asm
GlcdClearPageLabel2:
#endasm
GlcdClearPageLabel2:
#ifdef Debugging
        DebugDisplay(0x4,'2');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        GlcdColumn++;
        if (GlcdColumn < 128)
            StackPlus(GlcdClearPageCase2,GlcdWriteByteLabel1);
        else
        {
            StackMinus();
        }
#asm
GlcdClearPageLabel1:
#endasm
GlcdClearPageLabel1:
#ifdef Debugging
        DebugDisplay(0x4,'1');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        GlcdColumn = 0;
        GlcdDataByte = 0x00;
        StackPlus(GlcdClearPageCase2,GlcdWriteByteLabel1);
#asm
GlcdPutcharLabel2:
#endasm
GlcdPutcharLabel2:
#ifdef Debugging
        DebugDisplay(0x5,'2');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        if (++i < 6)
        {
            GlcdDataByte = glcd_font[GlcdChar][i];
            GlcdColumn++;
            StackPlus(GlcdPutcharCase2,GlcdWriteByteLabel1);
        }
        else
        {
            StackMinus();
        }
#asm
GlcdPutcharLabel1:
#endasm
GlcdPutcharLabel1:
#ifdef Debugging
        DebugDisplay(0x5,'1');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        i = 0;
        GlcdChar -= 0x20;
        GlcdDataByte = glcd_font[GlcdChar][0];
        StackPlus(GlcdPutcharCase2,GlcdWriteByteLabel1);
#asm
GlcdPutsLabel2:
#endasm
GlcdPutsLabel2:
#ifdef Debugging
        DebugDisplay(0x6,'2');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        if (*GlcdString)
        {
            GlcdColumn++;
            GlcdChar = *GlcdString++;
            StackPlus(GlcdPutsCase2,GlcdPutcharLabel1);
        }
        else
        {
            StackMinus();
        }
#asm
GlcdPutsLabel1:
#endasm
GlcdPutsLabel1:
#ifdef Debugging
        DebugDisplay(0x6,'1');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        if (*GlcdString)
        {
            GlcdChar = *GlcdString++;
            StackPlus(GlcdPutsCase2,GlcdPutcharLabel1);
        }
        else
        {
            StackMinus();
        }
#asm
GlcdPutsCenterLabel2:
#endasm
GlcdPutsCenterLabel2:
#ifdef Debugging
        DebugDisplay(0x7,'2');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        StackMinus();
#asm
GlcdPutsCenterLabel1:
#endasm
GlcdPutsCenterLabel1:
#ifdef Debugging
        DebugDisplay(0x7,'1');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        i = strlen_char(GlcdString);
        i = i * 6;
        i = 128 - i;
        GlcdColumn = i / 2;
        StackPlus(GlcdPutsCenterCase2,GlcdPutsLabel1);
#asm
GlcdPutsfLabel2:
#endasm
GlcdPutsfLabel2:
#ifdef Debugging
        DebugDisplay(0x8,'2');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        if (*GlcdFlashString)
        {
            GlcdColumn++;
            GlcdChar = *GlcdFlashString++;
            StackPlus(GlcdPutsfCase2,GlcdPutcharLabel1);
        }
        else
        {
            StackMinus();
        }
#asm
GlcdPutsfLabel1:
#endasm
GlcdPutsfLabel1:
#ifdef Debugging
        DebugDisplay(0x8,'1');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        if (*GlcdFlashString)
        {
            GlcdChar = *GlcdFlashString++;
            StackPlus(GlcdPutsfCase2,GlcdPutcharLabel1);
        }
        else
        {
            StackMinus();
        }
#asm
GlcdPutsfCenterLabel2:
#endasm
GlcdPutsfCenterLabel2:
#ifdef Debugging
        DebugDisplay(0x9,'2');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        StackMinus();
#asm
GlcdPutsfCenterLabel1:
#endasm
GlcdPutsfCenterLabel1:
#ifdef Debugging
        DebugDisplay(0x9,'1');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        i = strlenf_char(GlcdFlashString);
        i = i * 6;
        i = 128 - i;
        GlcdColumn = i / 2;
        StackPlus(GlcdPutsfCenterCase2,GlcdPutsfLabel1);
#asm
GlcdClearLabel2:
#endasm
GlcdClearLabel2:
#ifdef Debugging
        DebugDisplay(0xa,'2');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        if (((GlcdPage == 7) && (GlcdColumn < 127)) || (GlcdPage < 7))
        {
            GlcdColumn++;
            if (GlcdColumn == 128)
            {
                GlcdColumn = 0;
                GlcdPage++;
            }
            StackPlus(GlcdClearCase2,GlcdWriteByteLabel1);
        }
        else
        {
            StackMinus();
        }
#asm
GlcdClearLabel1:
#endasm
GlcdClearLabel1:
#ifdef Debugging
        DebugDisplay(0xa,'1');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        GlcdColumn = 0;
        GlcdPage = 0;
        GlcdDataByte = 0x00;
        StackPlus(GlcdClearCase2,GlcdWriteByteLabel1);
#asm
GlcdPutbmpLabel2:
#endasm
GlcdPutbmpLabel2:
#ifdef Debugging
        DebugDisplay(0xb,'2');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        if (++j < 1024)
        {
            GlcdColumn = ((unsigned char)(j)) & 0x7F;
            GlcdPage = ((unsigned char)(j >> 7));
            GlcdDataByte = *(++GlcdFlashPointer);
            StackPlus(GlcdPutbmpCase2,GlcdWriteByteLabel1);
        }
        else
        {
            StackMinus();
        }
#asm
GlcdPutbmpLabel1:
#endasm
GlcdPutbmpLabel1:
#ifdef Debugging
        DebugDisplay(0xb,'1');
        while (PINB & 0x01); while (!(PINB & 0x01));
#endif
        j = 0;
        GlcdColumn = 0;
        GlcdPage = 0;
        GlcdDataByte = *GlcdFlashPointer;
        StackPlus(GlcdPutbmpCase2,GlcdWriteByteLabel1);
    }
}



// GLCD initializing function
void glcd_init (void)
{
    while (GlcdBusy);
    PushCase (GlcdInitCase1);
    glcd_timer_isr();
}

// GLCD write byte in specific column and page function
void glcd_writebyte (unsigned char column, unsigned char page, unsigned char data)
{
    while (GlcdBusy);
    GlcdColumn = column;
    GlcdPage = page;
    GlcdDataByte = data;
    PushCase(GlcdWriteByteCase1);
    glcd_timer_isr();
}

// GLCD clear page function
void glcd_clear_page (unsigned char page)
{
    while (GlcdBusy);
    GlcdPage = page;
    PushCase (GlcdClearPageCase1);
    glcd_timer_isr();
}

// GLCD put character function
void glcd_putchar (unsigned char column, unsigned char page, unsigned char ch)
{
    while (GlcdBusy);
    GlcdColumn = column;
    GlcdPage = page;
    GlcdChar = ch;
    PushCase(GlcdPutcharCase1);
    glcd_timer_isr();
}

// GLCD put string function
void glcd_puts (unsigned char column, unsigned char page, unsigned char *str)
{
    while (GlcdBusy);
    GlcdColumn = column;
    GlcdPage = page;
    GlcdString = str;
    PushCase(GlcdPutsCase1);
    glcd_timer_isr();
}

// GLCD put string in center function
void glcd_puts_center (unsigned char page, unsigned char *str)
{
    while (GlcdBusy);
    GlcdPage = page;
    GlcdString = str;
    PushCase(GlcdPutsCenterCase1);
    glcd_timer_isr();
}

// GLCD put flash string function
void glcd_putsf (unsigned char column, unsigned char page, flash unsigned char *str)
{
    while (GlcdBusy);
    GlcdColumn = column;
    GlcdPage = page;
    GlcdFlashString = str;
    PushCase(GlcdPutsfCase1);
    glcd_timer_isr();
}

// GLCD put flash string in center function
void glcd_putsf_center (unsigned char page, flash unsigned char *str)
{
    while (GlcdBusy);
    GlcdPage = page;
    GlcdFlashString = str;
    PushCase(GlcdPutsfCenterCase1);
    glcd_timer_isr();
}

// GLCD clear function
void glcd_clear (void)
{
    while (GlcdBusy);
    PushCase(GlcdClearCase1);
    glcd_timer_isr();
}

// GLCD put bitmap function
void glcd_putbmp (flash unsigned char *bmp)
{
    while (GlcdBusy);
    GlcdFlashPointer = bmp;
    PushCase(GlcdPutbmpCase1);
    glcd_timer_isr();
}

#include <delay.h>

void glcd_define2 (unsigned char *glcd_data_port_address,
                  unsigned char *glcd_rs_port_address,  unsigned char glcd_rs_pin,
                  unsigned char *glcd_rw_port_address,  unsigned char glcd_rw_pin,
                  unsigned char *glcd_en_port_address,  unsigned char glcd_en_pin,
                  unsigned char *glcd_cs1_port_address, unsigned char glcd_cs1_pin,
                  unsigned char *glcd_cs2_port_address, unsigned char glcd_cs2_pin,
                  unsigned char *glcd_rst_port_address, unsigned char glcd_rst_pin)
{
  glcd_data_address = glcd_data_port_address;
  glcd_rs_address   = glcd_rs_port_address;
  glcd_rw_address   = glcd_rw_port_address;
  glcd_en_address   = glcd_en_port_address;
  glcd_cs1_address  = glcd_cs1_port_address;
  glcd_cs2_address  = glcd_cs2_port_address;
  glcd_rst_address  = glcd_rst_port_address;
#ifdef _ATXMEGA_DEVICE_
  glcd_rs_bit_msk  = 0b00000001 << glcd_rs_pin;
  glcd_rw_bit_msk  = 0b00000001 << glcd_rw_pin;
  glcd_en_bit_msk  = 0b00000001 << glcd_en_pin;
  glcd_cs1_bit_msk = 0b00000001 << glcd_cs1_pin;
  glcd_cs2_bit_msk = 0b00000001 << glcd_cs2_pin;
  glcd_rst_bit_msk = 0b00000001 << glcd_rst_pin;
  // Set all the pins as output
  *(glcd_data_address - 0x03) = 0xFF;
  *(glcd_rs_address - 0x03)   = glcd_rs_bit_msk;
  clr_rw;
  *(glcd_rw_address - 0x03)   = glcd_rw_bit_msk;
  *(glcd_en_address - 0x03)   = glcd_en_bit_msk;
  *(glcd_cs1_address - 0x03)  = glcd_cs1_bit_msk;
  *(glcd_cs2_address - 0x03)  = glcd_cs2_bit_msk;
  *(glcd_rst_address - 0x03)  = glcd_rst_bit_msk;
#else
  glcd_rs_bit_pos  = glcd_rs_pin;
  glcd_rw_bit_pos  = glcd_rw_pin;
  glcd_en_bit_pos  = glcd_en_pin;
  glcd_cs1_bit_pos = glcd_cs1_pin;
  glcd_cs2_bit_pos = glcd_cs2_pin;
  glcd_rst_bit_pos = glcd_rst_pin;
  // Sets the pins as output
  *(glcd_data_address - 1) = 0xFF;
  SETBIT (*(glcd_rs_address - 0x01),glcd_rs_bit_pos);
  SETBIT (*(glcd_rw_address - 0x01),glcd_rw_bit_pos);
  clr_rw;
  SETBIT (*(glcd_en_address - 0x01),glcd_en_bit_pos);
  SETBIT (*(glcd_cs1_address - 0x01),glcd_cs1_bit_pos);
  SETBIT (*(glcd_cs2_address - 0x01),glcd_cs2_bit_pos);
  SETBIT (*(glcd_rst_address - 0x01),glcd_rst_bit_pos);
#endif
}

void glcd_unlock_lock2 (void)
{
  delay_us(7);
  set_en;
  delay_us(7);
  clr_en;
}

void glcd_init2 (void)
{
  char i;
  clr_rst;
  delay_ms(10);
  set_rst;
  delay_ms(10);
  clr_rs;
  clr_cs1;
  set_cs2;
  for (i=0;i<2;i++)
  {
    *glcd_data_address = 0x3E;
    glcd_unlock_lock2();
    *glcd_data_address = 0x40;
    glcd_unlock_lock2();
    *glcd_data_address = 0xB8;
    glcd_unlock_lock2();
    *glcd_data_address = 0x3F;
    glcd_unlock_lock2();
    tgl_cs1;
    tgl_cs2;
  }
}

void glcd_writebyte2 (char clmn, char pg, char data)
{
  if(clmn >= 64)
  {
    clr_cs1;
    set_cs2;
  }
  else
  {
    set_cs1;
    clr_cs2;
  }
  clr_rs;
  clr_rw;
  *glcd_data_address = 0xB8 | pg;
  glcd_unlock_lock2();
  
  clr_rs;
  clr_rw;
  *glcd_data_address = 0x40 | clmn;
  glcd_unlock_lock2();
  
  set_rs;
  clr_rw;
  *glcd_data_address = data;
  glcd_unlock_lock2();
}

void glcd_clear_page2 (char page)
{
  char i;
  for (i = 0;i < 128;i++)
    glcd_writebyte2(i,page,0x00);
}

void glcd_putchar2 (char column, char page, char ch)
{
  char i;
  ch -= 32;
  for (i = 0;i < 6;i++)
  {
    glcd_writebyte2(column, page, glcd_font[ch][i]);
    column++;
  };
}

void glcd_puts2 (char column, char page, char* str)
{
  while (*str)
  {
    glcd_putchar2(column, page, *str++);
    column += 6;
  }
}

void glcd_puts_center2 (char page, char* str)
{
  char i;
  i = strlen_char(str);
  i = (128 - i * 6) / 2;
  glcd_puts2(i,page,str);
}

void glcd_putsf2 (char column, char page,flash char* str)
{
  while (*str)
  {
    glcd_putchar2(column, page, *str++ );
    column += 6;
  }
}

void glcd_putsf_center2 (char page, flash char* str)
{
  char i;
  i = strlenf_char(str);
  i = (128 - i * 6) / 2;
  glcd_putsf2(i,page,str);
}

void glcd_clear2 (void)
{
  char i, j;
  for (i = 0;i < 8;i++)
    for (j = 0;j < 128;j++)
      glcd_writebyte2(j, i, 0);
}

void glcd_putbmp2 (flash unsigned char bmp[])
{
  char x=0;
  char y=0;
  unsigned int i;  
  for(i=0;i<1024;i++)
  {
    if(x==128)
    {
      x=0;
      y++;
    }
    glcd_writebyte2(x,y,bmp[i]);
    x++;
  }
}

// System Clocks initialization
void system_clocks_init(void)
{
unsigned char n,s;

// Optimize for speed
#pragma optsize- 
// Save interrupts enabled/disabled state
s=SREG;
// Disable interrupts
#asm("cli")

// External 12000.000 kHz clock source on XTAL1 initialization
OSC.XOSCCTRL=0xCB;
// Enable the external clock source
OSC.CTRL|=OSC_XOSCEN_bm;

// System Clock prescaler A division factor: 1
// System Clock prescalers B & C division factors: B:1, C:1
// ClkPer4: 24000.000 kHz
// ClkPer2: 24000.000 kHz
// ClkPer:  24000.000 kHz
// ClkCPU:  24000.000 kHz
n=(CLK.PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm))) |
	CLK_PSADIV_1_gc | CLK_PSBCDIV_1_1_gc;
CCP=CCP_IOREG_gc;
CLK.PSCTRL=n;

// PLL initialization
// PLL clock cource: External Osc. or Clock
// PLL multiplication factor: 2
// PLL frequency: 24.000000 MHz
// Set the PLL clock source and multiplication factor
n=(OSC.PLLCTRL & (~(OSC_PLLSRC_gm | OSC_PLLFAC_gm))) |
	OSC_PLLSRC_XOSC_gc | 2;
CCP=CCP_IOREG_gc;
OSC.PLLCTRL=n;

// Wait for the clock source of PLL to be stable
while ((OSC.STATUS & OSC_XOSCRDY_bm)==0);

// Enable the PLL
OSC.CTRL|=OSC_PLLEN_bm;

// System Clock prescaler A division factor: 1
// System Clock prescalers B & C division factors: B:1, C:1
// ClkPer4: 24000.000 kHz
// ClkPer2: 24000.000 kHz
// ClkPer:  24000.000 kHz
// ClkCPU:  24000.000 kHz
n=(CLK.PSCTRL & (~(CLK_PSADIV_gm | CLK_PSBCDIV1_bm | CLK_PSBCDIV0_bm))) |
	CLK_PSADIV_1_gc | CLK_PSBCDIV_1_1_gc;
CCP=CCP_IOREG_gc;
CLK.PSCTRL=n;

// Wait for the PLL to stabilize
while ((OSC.STATUS & OSC_PLLRDY_bm)==0);

// Select the system clock source: Phase Locked Loop
n=(CLK.CTRL & (~CLK_SCLKSEL_gm)) | CLK_SCLKSEL_PLL_gc;
CCP=CCP_IOREG_gc;
CLK.CTRL=n;

// Disable the unused oscillators: 2 MHz, 32 MHz, internal 32 kHz
OSC.CTRL&= ~(OSC_RC2MEN_bm | OSC_RC32MEN_bm | OSC_RC32KEN_bm);

// Peripheral Clock output: Disabled
PORTCFG.CLKEVOUT=(PORTCFG.CLKEVOUT & (~PORTCFG_CLKOUT_gm)) | PORTCFG_CLKOUT_OFF_gc;

// Restore interrupts enabled/disabled state
SREG=s;
// Restore optimization for size if needed
#pragma optsize_default
}

// Ports initialization
void ports_init(void)
{
// PORTA initialization
// OUT register
PORTA.OUT=0x00;
// Bit0: Input
// Bit1: Input
// Bit2: Input
// Bit3: Input
// Bit4: Input
// Bit5: Input
// Bit6: Input
// Bit7: Input
PORTA.DIR=0x00;
// Bit0 Output/Pull configuration: Totempole/No
// Bit0 Input/Sense configuration: Sense both edges
// Bit0 inverted: Off
// Bit0 slew rate limitation: Off
PORTA.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit1 Output/Pull configuration: Totempole/No
// Bit1 Input/Sense configuration: Sense both edges
// Bit1 inverted: Off
// Bit1 slew rate limitation: Off
PORTA.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit2 Output/Pull configuration: Totempole/No
// Bit2 Input/Sense configuration: Sense both edges
// Bit2 inverted: Off
// Bit2 slew rate limitation: Off
PORTA.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit3 Output/Pull configuration: Totempole/No
// Bit3 Input/Sense configuration: Sense both edges
// Bit3 inverted: Off
// Bit3 slew rate limitation: Off
PORTA.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit4 Output/Pull configuration: Totempole/No
// Bit4 Input/Sense configuration: Sense both edges
// Bit4 inverted: Off
// Bit4 slew rate limitation: Off
PORTA.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit5 Output/Pull configuration: Totempole/No
// Bit5 Input/Sense configuration: Sense both edges
// Bit5 inverted: Off
// Bit5 slew rate limitation: Off
PORTA.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit6 Output/Pull configuration: Totempole/No
// Bit6 Input/Sense configuration: Sense both edges
// Bit6 inverted: Off
// Bit6 slew rate limitation: Off
PORTA.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit7 Output/Pull configuration: Totempole/No
// Bit7 Input/Sense configuration: Sense both edges
// Bit7 inverted: Off
// Bit7 slew rate limitation: Off
PORTA.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Interrupt 0 level: Disabled
// Interrupt 1 level: Disabled
PORTA.INTCTRL=(PORTA.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
// Bit0 pin change interrupt 0: Off
// Bit1 pin change interrupt 0: Off
// Bit2 pin change interrupt 0: Off
// Bit3 pin change interrupt 0: Off
// Bit4 pin change interrupt 0: Off
// Bit5 pin change interrupt 0: Off
// Bit6 pin change interrupt 0: Off
// Bit7 pin change interrupt 0: Off
PORTA.INT0MASK=0x00;
// Bit0 pin change interrupt 1: Off
// Bit1 pin change interrupt 1: Off
// Bit2 pin change interrupt 1: Off
// Bit3 pin change interrupt 1: Off
// Bit4 pin change interrupt 1: Off
// Bit5 pin change interrupt 1: Off
// Bit6 pin change interrupt 1: Off
// Bit7 pin change interrupt 1: Off
PORTA.INT1MASK=0x00;

// PORTB initialization
// OUT register
PORTB.OUT=0x00;
// Bit0: Input
// Bit1: Input
// Bit2: Input
// Bit3: Input
// Bit4: Input
// Bit5: Input
// Bit6: Input
// Bit7: Input
PORTB.DIR=0x00;
// Bit0 Output/Pull configuration: Totempole/No
// Bit0 Input/Sense configuration: Sense both edges
// Bit0 inverted: Off
// Bit0 slew rate limitation: Off
PORTB.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit1 Output/Pull configuration: Totempole/No
// Bit1 Input/Sense configuration: Sense both edges
// Bit1 inverted: Off
// Bit1 slew rate limitation: Off
PORTB.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit2 Output/Pull configuration: Totempole/No
// Bit2 Input/Sense configuration: Sense both edges
// Bit2 inverted: Off
// Bit2 slew rate limitation: Off
PORTB.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit3 Output/Pull configuration: Totempole/No
// Bit3 Input/Sense configuration: Sense both edges
// Bit3 inverted: Off
// Bit3 slew rate limitation: Off
PORTB.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit4 Output/Pull configuration: Totempole/No
// Bit4 Input/Sense configuration: Sense both edges
// Bit4 inverted: Off
// Bit4 slew rate limitation: Off
PORTB.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit5 Output/Pull configuration: Totempole/No
// Bit5 Input/Sense configuration: Sense both edges
// Bit5 inverted: Off
// Bit5 slew rate limitation: Off
PORTB.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit6 Output/Pull configuration: Totempole/No
// Bit6 Input/Sense configuration: Sense both edges
// Bit6 inverted: Off
// Bit6 slew rate limitation: Off
PORTB.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit7 Output/Pull configuration: Totempole/No
// Bit7 Input/Sense configuration: Sense both edges
// Bit7 inverted: Off
// Bit7 slew rate limitation: Off
PORTB.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Interrupt 0 level: Disabled
// Interrupt 1 level: Disabled
PORTB.INTCTRL=(PORTB.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
// Bit0 pin change interrupt 0: Off
// Bit1 pin change interrupt 0: Off
// Bit2 pin change interrupt 0: Off
// Bit3 pin change interrupt 0: Off
// Bit4 pin change interrupt 0: Off
// Bit5 pin change interrupt 0: Off
// Bit6 pin change interrupt 0: Off
// Bit7 pin change interrupt 0: Off
PORTB.INT0MASK=0x00;
// Bit0 pin change interrupt 1: Off
// Bit1 pin change interrupt 1: Off
// Bit2 pin change interrupt 1: Off
// Bit3 pin change interrupt 1: Off
// Bit4 pin change interrupt 1: Off
// Bit5 pin change interrupt 1: Off
// Bit6 pin change interrupt 1: Off
// Bit7 pin change interrupt 1: Off
PORTB.INT1MASK=0x00;

// PORTC initialization
// OUT register
PORTC.OUT=0x00;
// Bit0: Input
// Bit1: Input
// Bit2: Input
// Bit3: Input
// Bit4: Input
// Bit5: Input
// Bit6: Input
// Bit7: Input
PORTC.DIR=0x00;
// Bit0 Output/Pull configuration: Totempole/No
// Bit0 Input/Sense configuration: Sense both edges
// Bit0 inverted: Off
// Bit0 slew rate limitation: Off
PORTC.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit1 Output/Pull configuration: Totempole/No
// Bit1 Input/Sense configuration: Sense both edges
// Bit1 inverted: Off
// Bit1 slew rate limitation: Off
PORTC.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit2 Output/Pull configuration: Totempole/No
// Bit2 Input/Sense configuration: Sense both edges
// Bit2 inverted: Off
// Bit2 slew rate limitation: Off
PORTC.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit3 Output/Pull configuration: Totempole/No
// Bit3 Input/Sense configuration: Sense both edges
// Bit3 inverted: Off
// Bit3 slew rate limitation: Off
PORTC.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit4 Output/Pull configuration: Totempole/No
// Bit4 Input/Sense configuration: Sense both edges
// Bit4 inverted: Off
// Bit4 slew rate limitation: Off
PORTC.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit5 Output/Pull configuration: Totempole/No
// Bit5 Input/Sense configuration: Sense both edges
// Bit5 inverted: Off
// Bit5 slew rate limitation: Off
PORTC.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit6 Output/Pull configuration: Totempole/No
// Bit6 Input/Sense configuration: Sense both edges
// Bit6 inverted: Off
// Bit6 slew rate limitation: Off
PORTC.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit7 Output/Pull configuration: Totempole/No
// Bit7 Input/Sense configuration: Sense both edges
// Bit7 inverted: Off
// Bit7 slew rate limitation: Off
PORTC.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Interrupt 0 level: Disabled
// Interrupt 1 level: Disabled
PORTC.INTCTRL=(PORTC.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
// Bit0 pin change interrupt 0: Off
// Bit1 pin change interrupt 0: Off
// Bit2 pin change interrupt 0: Off
// Bit3 pin change interrupt 0: Off
// Bit4 pin change interrupt 0: Off
// Bit5 pin change interrupt 0: Off
// Bit6 pin change interrupt 0: Off
// Bit7 pin change interrupt 0: Off
PORTC.INT0MASK=0x00;
// Bit0 pin change interrupt 1: Off
// Bit1 pin change interrupt 1: Off
// Bit2 pin change interrupt 1: Off
// Bit3 pin change interrupt 1: Off
// Bit4 pin change interrupt 1: Off
// Bit5 pin change interrupt 1: Off
// Bit6 pin change interrupt 1: Off
// Bit7 pin change interrupt 1: Off
PORTC.INT1MASK=0x00;

// PORTD initialization
// OUT register
PORTD.OUT=0x00;
// Bit0: Input
// Bit1: Input
// Bit2: Input
// Bit3: Input
// Bit4: Input
// Bit5: Input
// Bit6: Input
// Bit7: Input
PORTD.DIR=0x00;
// Bit0 Output/Pull configuration: Totempole/No
// Bit0 Input/Sense configuration: Sense both edges
// Bit0 inverted: Off
// Bit0 slew rate limitation: Off
PORTD.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit1 Output/Pull configuration: Totempole/No
// Bit1 Input/Sense configuration: Sense both edges
// Bit1 inverted: Off
// Bit1 slew rate limitation: Off
PORTD.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit2 Output/Pull configuration: Totempole/No
// Bit2 Input/Sense configuration: Sense both edges
// Bit2 inverted: Off
// Bit2 slew rate limitation: Off
PORTD.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit3 Output/Pull configuration: Totempole/No
// Bit3 Input/Sense configuration: Sense both edges
// Bit3 inverted: Off
// Bit3 slew rate limitation: Off
PORTD.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit4 Output/Pull configuration: Totempole/No
// Bit4 Input/Sense configuration: Sense both edges
// Bit4 inverted: Off
// Bit4 slew rate limitation: Off
PORTD.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit5 Output/Pull configuration: Totempole/No
// Bit5 Input/Sense configuration: Sense both edges
// Bit5 inverted: Off
// Bit5 slew rate limitation: Off
PORTD.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit6 Output/Pull configuration: Totempole/No
// Bit6 Input/Sense configuration: Sense both edges
// Bit6 inverted: Off
// Bit6 slew rate limitation: Off
PORTD.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit7 Output/Pull configuration: Totempole/No
// Bit7 Input/Sense configuration: Sense both edges
// Bit7 inverted: Off
// Bit7 slew rate limitation: Off
PORTD.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Interrupt 0 level: Disabled
// Interrupt 1 level: Disabled
PORTD.INTCTRL=(PORTD.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
// Bit0 pin change interrupt 0: Off
// Bit1 pin change interrupt 0: Off
// Bit2 pin change interrupt 0: Off
// Bit3 pin change interrupt 0: Off
// Bit4 pin change interrupt 0: Off
// Bit5 pin change interrupt 0: Off
// Bit6 pin change interrupt 0: Off
// Bit7 pin change interrupt 0: Off
PORTD.INT0MASK=0x00;
// Bit0 pin change interrupt 1: Off
// Bit1 pin change interrupt 1: Off
// Bit2 pin change interrupt 1: Off
// Bit3 pin change interrupt 1: Off
// Bit4 pin change interrupt 1: Off
// Bit5 pin change interrupt 1: Off
// Bit6 pin change interrupt 1: Off
// Bit7 pin change interrupt 1: Off
PORTD.INT1MASK=0x00;

// PORTE initialization
// OUT register
PORTE.OUT=0x00;
// Bit0: Input
// Bit1: Input
// Bit2: Input
// Bit3: Input
// Bit4: Input
// Bit5: Input
// Bit6: Input
// Bit7: Input
PORTE.DIR=0x00;
// Bit0 Output/Pull configuration: Totempole/No
// Bit0 Input/Sense configuration: Sense both edges
// Bit0 inverted: Off
// Bit0 slew rate limitation: Off
PORTE.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit1 Output/Pull configuration: Totempole/No
// Bit1 Input/Sense configuration: Sense both edges
// Bit1 inverted: Off
// Bit1 slew rate limitation: Off
PORTE.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit2 Output/Pull configuration: Totempole/No
// Bit2 Input/Sense configuration: Sense both edges
// Bit2 inverted: Off
// Bit2 slew rate limitation: Off
PORTE.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit3 Output/Pull configuration: Totempole/No
// Bit3 Input/Sense configuration: Sense both edges
// Bit3 inverted: Off
// Bit3 slew rate limitation: Off
PORTE.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit4 Output/Pull configuration: Totempole/No
// Bit4 Input/Sense configuration: Sense both edges
// Bit4 inverted: Off
// Bit4 slew rate limitation: Off
PORTE.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit5 Output/Pull configuration: Totempole/No
// Bit5 Input/Sense configuration: Sense both edges
// Bit5 inverted: Off
// Bit5 slew rate limitation: Off
PORTE.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit6 Output/Pull configuration: Totempole/No
// Bit6 Input/Sense configuration: Sense both edges
// Bit6 inverted: Off
// Bit6 slew rate limitation: Off
PORTE.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit7 Output/Pull configuration: Totempole/No
// Bit7 Input/Sense configuration: Sense both edges
// Bit7 inverted: Off
// Bit7 slew rate limitation: Off
PORTE.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Interrupt 0 level: Disabled
// Interrupt 1 level: Disabled
PORTE.INTCTRL=(PORTE.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
// Bit0 pin change interrupt 0: Off
// Bit1 pin change interrupt 0: Off
// Bit2 pin change interrupt 0: Off
// Bit3 pin change interrupt 0: Off
// Bit4 pin change interrupt 0: Off
// Bit5 pin change interrupt 0: Off
// Bit6 pin change interrupt 0: Off
// Bit7 pin change interrupt 0: Off
PORTE.INT0MASK=0x00;
// Bit0 pin change interrupt 1: Off
// Bit1 pin change interrupt 1: Off
// Bit2 pin change interrupt 1: Off
// Bit3 pin change interrupt 1: Off
// Bit4 pin change interrupt 1: Off
// Bit5 pin change interrupt 1: Off
// Bit6 pin change interrupt 1: Off
// Bit7 pin change interrupt 1: Off
PORTE.INT1MASK=0x00;

// PORTF initialization
// OUT register
PORTF.OUT=0x00;
// Bit0: Input
// Bit1: Input
// Bit2: Input
// Bit3: Input
// Bit4: Input
// Bit5: Input
// Bit6: Input
// Bit7: Input
PORTF.DIR=0x00;
// Bit0 Output/Pull configuration: Totempole/No
// Bit0 Input/Sense configuration: Sense both edges
// Bit0 inverted: Off
// Bit0 slew rate limitation: Off
PORTF.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit1 Output/Pull configuration: Totempole/No
// Bit1 Input/Sense configuration: Sense both edges
// Bit1 inverted: Off
// Bit1 slew rate limitation: Off
PORTF.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit2 Output/Pull configuration: Totempole/No
// Bit2 Input/Sense configuration: Sense both edges
// Bit2 inverted: Off
// Bit2 slew rate limitation: Off
PORTF.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit3 Output/Pull configuration: Totempole/No
// Bit3 Input/Sense configuration: Sense both edges
// Bit3 inverted: Off
// Bit3 slew rate limitation: Off
PORTF.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit4 Output/Pull configuration: Totempole/No
// Bit4 Input/Sense configuration: Sense both edges
// Bit4 inverted: Off
// Bit4 slew rate limitation: Off
PORTF.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit5 Output/Pull configuration: Totempole/No
// Bit5 Input/Sense configuration: Sense both edges
// Bit5 inverted: Off
// Bit5 slew rate limitation: Off
PORTF.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit6 Output/Pull configuration: Totempole/No
// Bit6 Input/Sense configuration: Sense both edges
// Bit6 inverted: Off
// Bit6 slew rate limitation: Off
PORTF.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit7 Output/Pull configuration: Totempole/No
// Bit7 Input/Sense configuration: Sense both edges
// Bit7 inverted: Off
// Bit7 slew rate limitation: Off
PORTF.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Interrupt 0 level: Disabled
// Interrupt 1 level: Disabled
PORTF.INTCTRL=(PORTF.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
// Bit0 pin change interrupt 0: Off
// Bit1 pin change interrupt 0: Off
// Bit2 pin change interrupt 0: Off
// Bit3 pin change interrupt 0: Off
// Bit4 pin change interrupt 0: Off
// Bit5 pin change interrupt 0: Off
// Bit6 pin change interrupt 0: Off
// Bit7 pin change interrupt 0: Off
PORTF.INT0MASK=0x00;
// Bit0 pin change interrupt 1: Off
// Bit1 pin change interrupt 1: Off
// Bit2 pin change interrupt 1: Off
// Bit3 pin change interrupt 1: Off
// Bit4 pin change interrupt 1: Off
// Bit5 pin change interrupt 1: Off
// Bit6 pin change interrupt 1: Off
// Bit7 pin change interrupt 1: Off
PORTF.INT1MASK=0x00;

// PORTH initialization
// OUT register
PORTH.OUT=0x00;
// Bit0: Input
// Bit1: Input
// Bit2: Input
// Bit3: Input
// Bit4: Input
// Bit5: Input
// Bit6: Input
// Bit7: Input
PORTH.DIR=0x00;
// Bit0 Output/Pull configuration: Totempole/No
// Bit0 Input/Sense configuration: Sense both edges
// Bit0 inverted: Off
// Bit0 slew rate limitation: Off
PORTH.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit1 Output/Pull configuration: Totempole/No
// Bit1 Input/Sense configuration: Sense both edges
// Bit1 inverted: Off
// Bit1 slew rate limitation: Off
PORTH.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit2 Output/Pull configuration: Totempole/No
// Bit2 Input/Sense configuration: Sense both edges
// Bit2 inverted: Off
// Bit2 slew rate limitation: Off
PORTH.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit3 Output/Pull configuration: Totempole/No
// Bit3 Input/Sense configuration: Sense both edges
// Bit3 inverted: Off
// Bit3 slew rate limitation: Off
PORTH.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit4 Output/Pull configuration: Totempole/No
// Bit4 Input/Sense configuration: Sense both edges
// Bit4 inverted: Off
// Bit4 slew rate limitation: Off
PORTH.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit5 Output/Pull configuration: Totempole/No
// Bit5 Input/Sense configuration: Sense both edges
// Bit5 inverted: Off
// Bit5 slew rate limitation: Off
PORTH.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit6 Output/Pull configuration: Totempole/No
// Bit6 Input/Sense configuration: Sense both edges
// Bit6 inverted: Off
// Bit6 slew rate limitation: Off
PORTH.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit7 Output/Pull configuration: Totempole/No
// Bit7 Input/Sense configuration: Sense both edges
// Bit7 inverted: Off
// Bit7 slew rate limitation: Off
PORTH.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Interrupt 0 level: Disabled
// Interrupt 1 level: Disabled
PORTH.INTCTRL=(PORTH.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
// Bit0 pin change interrupt 0: Off
// Bit1 pin change interrupt 0: Off
// Bit2 pin change interrupt 0: Off
// Bit3 pin change interrupt 0: Off
// Bit4 pin change interrupt 0: Off
// Bit5 pin change interrupt 0: Off
// Bit6 pin change interrupt 0: Off
// Bit7 pin change interrupt 0: Off
PORTH.INT0MASK=0x00;
// Bit0 pin change interrupt 1: Off
// Bit1 pin change interrupt 1: Off
// Bit2 pin change interrupt 1: Off
// Bit3 pin change interrupt 1: Off
// Bit4 pin change interrupt 1: Off
// Bit5 pin change interrupt 1: Off
// Bit6 pin change interrupt 1: Off
// Bit7 pin change interrupt 1: Off
PORTH.INT1MASK=0x00;

// PORTJ initialization
// OUT register
PORTJ.OUT=0x00;
// Bit0: Input
// Bit1: Input
// Bit2: Input
// Bit3: Input
// Bit4: Input
// Bit5: Input
// Bit6: Input
// Bit7: Input
PORTJ.DIR=0x00;
// Bit0 Output/Pull configuration: Totempole/No
// Bit0 Input/Sense configuration: Sense both edges
// Bit0 inverted: Off
// Bit0 slew rate limitation: Off
PORTJ.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit1 Output/Pull configuration: Totempole/No
// Bit1 Input/Sense configuration: Sense both edges
// Bit1 inverted: Off
// Bit1 slew rate limitation: Off
PORTJ.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit2 Output/Pull configuration: Totempole/No
// Bit2 Input/Sense configuration: Sense both edges
// Bit2 inverted: Off
// Bit2 slew rate limitation: Off
PORTJ.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit3 Output/Pull configuration: Totempole/No
// Bit3 Input/Sense configuration: Sense both edges
// Bit3 inverted: Off
// Bit3 slew rate limitation: Off
PORTJ.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit4 Output/Pull configuration: Totempole/No
// Bit4 Input/Sense configuration: Sense both edges
// Bit4 inverted: Off
// Bit4 slew rate limitation: Off
PORTJ.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit5 Output/Pull configuration: Totempole/No
// Bit5 Input/Sense configuration: Sense both edges
// Bit5 inverted: Off
// Bit5 slew rate limitation: Off
PORTJ.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit6 Output/Pull configuration: Totempole/No
// Bit6 Input/Sense configuration: Sense both edges
// Bit6 inverted: Off
// Bit6 slew rate limitation: Off
PORTJ.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit7 Output/Pull configuration: Totempole/No
// Bit7 Input/Sense configuration: Sense both edges
// Bit7 inverted: Off
// Bit7 slew rate limitation: Off
PORTJ.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Interrupt 0 level: Disabled
// Interrupt 1 level: Disabled
PORTJ.INTCTRL=(PORTJ.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
// Bit0 pin change interrupt 0: Off
// Bit1 pin change interrupt 0: Off
// Bit2 pin change interrupt 0: Off
// Bit3 pin change interrupt 0: Off
// Bit4 pin change interrupt 0: Off
// Bit5 pin change interrupt 0: Off
// Bit6 pin change interrupt 0: Off
// Bit7 pin change interrupt 0: Off
PORTJ.INT0MASK=0x00;
// Bit0 pin change interrupt 1: Off
// Bit1 pin change interrupt 1: Off
// Bit2 pin change interrupt 1: Off
// Bit3 pin change interrupt 1: Off
// Bit4 pin change interrupt 1: Off
// Bit5 pin change interrupt 1: Off
// Bit6 pin change interrupt 1: Off
// Bit7 pin change interrupt 1: Off
PORTJ.INT1MASK=0x00;

// PORTK initialization
// OUT register
PORTK.OUT=0x00;
// Bit0: Input
// Bit1: Input
// Bit2: Input
// Bit3: Input
// Bit4: Input
// Bit5: Input
// Bit6: Input
// Bit7: Input
PORTK.DIR=0x00;
// Bit0 Output/Pull configuration: Totempole/No
// Bit0 Input/Sense configuration: Sense both edges
// Bit0 inverted: Off
// Bit0 slew rate limitation: Off
PORTK.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit1 Output/Pull configuration: Totempole/No
// Bit1 Input/Sense configuration: Sense both edges
// Bit1 inverted: Off
// Bit1 slew rate limitation: Off
PORTK.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit2 Output/Pull configuration: Totempole/No
// Bit2 Input/Sense configuration: Sense both edges
// Bit2 inverted: Off
// Bit2 slew rate limitation: Off
PORTK.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit3 Output/Pull configuration: Totempole/No
// Bit3 Input/Sense configuration: Sense both edges
// Bit3 inverted: Off
// Bit3 slew rate limitation: Off
PORTK.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit4 Output/Pull configuration: Totempole/No
// Bit4 Input/Sense configuration: Sense both edges
// Bit4 inverted: Off
// Bit4 slew rate limitation: Off
PORTK.PIN4CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit5 Output/Pull configuration: Totempole/No
// Bit5 Input/Sense configuration: Sense both edges
// Bit5 inverted: Off
// Bit5 slew rate limitation: Off
PORTK.PIN5CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit6 Output/Pull configuration: Totempole/No
// Bit6 Input/Sense configuration: Sense both edges
// Bit6 inverted: Off
// Bit6 slew rate limitation: Off
PORTK.PIN6CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit7 Output/Pull configuration: Totempole/No
// Bit7 Input/Sense configuration: Sense both edges
// Bit7 inverted: Off
// Bit7 slew rate limitation: Off
PORTK.PIN7CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Interrupt 0 level: Disabled
// Interrupt 1 level: Disabled
PORTK.INTCTRL=(PORTK.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
// Bit0 pin change interrupt 0: Off
// Bit1 pin change interrupt 0: Off
// Bit2 pin change interrupt 0: Off
// Bit3 pin change interrupt 0: Off
// Bit4 pin change interrupt 0: Off
// Bit5 pin change interrupt 0: Off
// Bit6 pin change interrupt 0: Off
// Bit7 pin change interrupt 0: Off
PORTK.INT0MASK=0x00;
// Bit0 pin change interrupt 1: Off
// Bit1 pin change interrupt 1: Off
// Bit2 pin change interrupt 1: Off
// Bit3 pin change interrupt 1: Off
// Bit4 pin change interrupt 1: Off
// Bit5 pin change interrupt 1: Off
// Bit6 pin change interrupt 1: Off
// Bit7 pin change interrupt 1: Off
PORTK.INT1MASK=0x00;

// PORTQ initialization
// OUT register
PORTQ.OUT=0x00;
// Bit0: Input
// Bit1: Input
// Bit2: Input
// Bit3: Input
PORTQ.DIR=0x00;
// Bit0 Output/Pull configuration: Totempole/No
// Bit0 Input/Sense configuration: Sense both edges
// Bit0 inverted: Off
// Bit0 slew rate limitation: Off
PORTQ.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit1 Output/Pull configuration: Totempole/No
// Bit1 Input/Sense configuration: Sense both edges
// Bit1 inverted: Off
// Bit1 slew rate limitation: Off
PORTQ.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit2 Output/Pull configuration: Totempole/No
// Bit2 Input/Sense configuration: Sense both edges
// Bit2 inverted: Off
// Bit2 slew rate limitation: Off
PORTQ.PIN2CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit3 Output/Pull configuration: Totempole/No
// Bit3 Input/Sense configuration: Sense both edges
// Bit3 inverted: Off
// Bit3 slew rate limitation: Off
PORTQ.PIN3CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Interrupt 0 level: Disabled
// Interrupt 1 level: Disabled
PORTQ.INTCTRL=(PORTQ.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
// Bit0 pin change interrupt 0: Off
// Bit1 pin change interrupt 0: Off
// Bit2 pin change interrupt 0: Off
// Bit3 pin change interrupt 0: Off
PORTQ.INT0MASK=0x00;
// Bit0 pin change interrupt 1: Off
// Bit1 pin change interrupt 1: Off
// Bit2 pin change interrupt 1: Off
// Bit3 pin change interrupt 1: Off
PORTQ.INT1MASK=0x00;

// PORTR initialization
// OUT register
PORTR.OUT=0x00;
// Bit0: Input
// Bit1: Input
PORTR.DIR=0x00;
// Bit0 Output/Pull configuration: Totempole/No
// Bit0 Input/Sense configuration: Sense both edges
// Bit0 inverted: Off
// Bit0 slew rate limitation: Off
PORTR.PIN0CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Bit1 Output/Pull configuration: Totempole/No
// Bit1 Input/Sense configuration: Sense both edges
// Bit1 inverted: Off
// Bit1 slew rate limitation: Off
PORTR.PIN1CTRL=PORT_OPC_TOTEM_gc | PORT_ISC_BOTHEDGES_gc;
// Interrupt 0 level: Disabled
// Interrupt 1 level: Disabled
PORTR.INTCTRL=(PORTR.INTCTRL & (~(PORT_INT1LVL_gm | PORT_INT0LVL_gm))) |
	PORT_INT1LVL_OFF_gc | PORT_INT0LVL_OFF_gc;
// Bit0 pin change interrupt 0: Off
// Bit1 pin change interrupt 0: Off
PORTR.INT0MASK=0x00;
// Bit0 pin change interrupt 1: Off
// Bit1 pin change interrupt 1: Off
PORTR.INT1MASK=0x00;
}

// Virtual Ports initialization
void vports_init(void)
{
// PORTA mapped to VPORT0
// PORTB mapped to VPORT1
PORTCFG.VPCTRLA=PORTCFG_VP1MAP_PORTB_gc | PORTCFG_VP0MAP_PORTA_gc;
// PORTC mapped to VPORT2
// PORTD mapped to VPORT3
PORTCFG.VPCTRLB=PORTCFG_VP3MAP_PORTD_gc | PORTCFG_VP2MAP_PORTC_gc;
}

// Disable a Timer/Counter type 0
void tc0_disable(TC0_t *ptc)
{
// Timer/Counter off
ptc->CTRLA=(ptc->CTRLA & (~TC0_CLKSEL_gm)) | TC_CLKSEL_OFF_gc;
// Issue a reset command
ptc->CTRLFSET=TC_CMD_RESET_gc;
}

// Disable a Timer/Counter type 1
void tc1_disable(TC1_t *ptc)
{
// Timer/Counter off
ptc->CTRLA=(ptc->CTRLA & (~TC1_CLKSEL_gm)) | TC_CLKSEL_OFF_gc;
// Issue a reset command
ptc->CTRLFSET=TC_CMD_RESET_gc;
}

// Timer/Counter TCC0 initialization
void tcc0_init(void)
{
unsigned char s;
unsigned char n;

// Note: the correct PORTC direction for the Compare Channels outputs
// is configured in the ports_init function

// Save interrupts enabled/disabled state
s=SREG;
// Disable interrupts
#asm("cli")

// Disable and reset the timer/counter just to be sure
tc0_disable(&TCC0);
// Clock source: Peripheral Clock/1
TCC0.CTRLA=(TCC0.CTRLA & (~TC0_CLKSEL_gm)) | TC_CLKSEL_DIV1_gc;
// Mode: Normal Operation, Overflow Int./Event on TOP
// Compare/Capture on channel A: Off
// Compare/Capture on channel B: Off
// Compare/Capture on channel C: Off
// Compare/Capture on channel D: Off
TCC0.CTRLB=(TCC0.CTRLB & (~(TC0_CCAEN_bm | TC0_CCBEN_bm | TC0_CCCEN_bm | TC0_CCDEN_bm | TC0_WGMODE_gm))) |
	TC_WGMODE_NORMAL_gc;

// Capture event source: None
// Capture event action: None
TCC0.CTRLD=(TCC0.CTRLD & (~(TC0_EVACT_gm | TC0_EVSEL_gm))) |
	TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;

// Overflow interrupt: High Level
// Error interrupt: Disabled
TCC0.INTCTRLA=(TCC0.INTCTRLA & (~(TC0_ERRINTLVL_gm | TC0_OVFINTLVL_gm))) |
	TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_HI_gc;

// Compare/Capture channel A interrupt: Disabled
// Compare/Capture channel B interrupt: Disabled
// Compare/Capture channel C interrupt: Disabled
// Compare/Capture channel D interrupt: Disabled
TCC0.INTCTRLB=(TCC0.INTCTRLB & (~(TC0_CCDINTLVL_gm | TC0_CCCINTLVL_gm | TC0_CCBINTLVL_gm | TC0_CCAINTLVL_gm))) |
	TC_CCDINTLVL_OFF_gc | TC_CCCINTLVL_OFF_gc | TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;

// High resolution extension: Off
HIRESC.CTRL&= ~HIRES_HREN0_bm;

// Advanced Waveform Extension initialization
// Optimize for speed
#pragma optsize- 
// Disable locking the AWEX configuration registers just to be sure
n=MCU.AWEXLOCK & (~MCU_AWEXCLOCK_bm);
CCP=CCP_IOREG_gc;
MCU.AWEXLOCK=n;
// Restore optimization for size if needed
#pragma optsize_default

// Pattern generation: Off
// Dead time insertion: Off
AWEXC.CTRL&= ~(AWEX_PGM_bm | AWEX_CWCM_bm | AWEX_DTICCDEN_bm | AWEX_DTICCCEN_bm | AWEX_DTICCBEN_bm | AWEX_DTICCAEN_bm);

// Fault protection initialization
// Fault detection on OCD Break detection: On
// Fault detection restart mode: Latched Mode
// Fault detection action: None (Fault protection disabled)
AWEXC.FDCTRL=(AWEXC.FDCTRL & (~(AWEX_FDDBD_bm | AWEX_FDMODE_bm | AWEX_FDACT_gm))) |
	AWEX_FDACT_NONE_gc;
// Fault detect events: 
// Event channel 0: Off
// Event channel 1: Off
// Event channel 2: Off
// Event channel 3: Off
// Event channel 4: Off
// Event channel 5: Off
// Event channel 6: Off
// Event channel 7: Off
AWEXC.FDEVMASK=0b00000000;
// Make sure the fault detect flag is cleared
AWEXC.STATUS|=AWEXC.STATUS & AWEX_FDF_bm;

// Clear the interrupt flags
TCC0.INTFLAGS=TCC0.INTFLAGS;
// Set counter register
TCC0.CNT=0x0000;
// Set period register
TCC0.PER=0x00DF;
// Set channel A Compare/Capture register
TCC0.CCA=0x0000;
// Set channel B Compare/Capture register
TCC0.CCB=0x0000;
// Set channel C Compare/Capture register
TCC0.CCC=0x0000;
// Set channel D Compare/Capture register
TCC0.CCD=0x0000;

// Restore interrupts enabled/disabled state
SREG=s;
}

// Timer/counter TCC0 Overflow/Underflow interrupt service routine
interrupt [TCC0_OVF_vect] void tcc0_overflow_isr(void)
{
// write your code here
    glcd_timer_isr();
}

// Timer/Counter TCC1 initialization
void tcc1_init(void)
{
unsigned char s;

// Note: the correct PORTC direction for the Compare Channels outputs
// is configured in the ports_init function

// Save interrupts enabled/disabled state
s=SREG;
// Disable interrupts
#asm("cli")

// Disable and reset the timer/counter just to be sure
tc1_disable(&TCC1);
// Clock source: Peripheral Clock/1
TCC1.CTRLA=(TCC1.CTRLA & (~TC1_CLKSEL_gm)) | TC_CLKSEL_DIV1_gc;
// Mode: Normal Operation, Overflow Int./Event on TOP
// Compare/Capture on channel A: Off
// Compare/Capture on channel B: Off
TCC1.CTRLB=(TCC1.CTRLB & (~(TC1_CCAEN_bm | TC1_CCBEN_bm | TC1_WGMODE_gm))) |
	TC_WGMODE_NORMAL_gc;

// Capture event source: None
// Capture event action: None
TCC1.CTRLD=(TCC1.CTRLD & (~(TC1_EVACT_gm | TC1_EVSEL_gm))) |
	TC_EVACT_OFF_gc | TC_EVSEL_OFF_gc;

// Overflow interrupt: Medium Level
// Error interrupt: Disabled
TCC1.INTCTRLA=(TCC1.INTCTRLA & (~(TC1_ERRINTLVL_gm | TC1_OVFINTLVL_gm))) |
	TC_ERRINTLVL_OFF_gc | TC_OVFINTLVL_MED_gc;

// Compare/Capture channel A interrupt: Disabled
// Compare/Capture channel B interrupt: Disabled
TCC1.INTCTRLB=(TCC1.INTCTRLB & (~(TC1_CCBINTLVL_gm | TC1_CCAINTLVL_gm))) |
	TC_CCBINTLVL_OFF_gc | TC_CCAINTLVL_OFF_gc;

// High resolution extension: Off
HIRESC.CTRL&= ~HIRES_HREN1_bm;

// Clear the interrupt flags
TCC1.INTFLAGS=TCC1.INTFLAGS;
// Set counter register
TCC1.CNT=0x0000;
// Set period register
TCC1.PER=0xFFFF;
// Set channel A Compare/Capture register
TCC1.CCA=0x0000;
// Set channel B Compare/Capture register
TCC1.CCB=0x0000;

// Restore interrupts enabled/disabled state
SREG=s;
}

unsigned int InterruptCounter = 0;
// Timer/counter TCC1 Overflow/Underflow interrupt service routine
interrupt [TCC1_OVF_vect] void tcc1_overflow_isr(void)
{
// write your code here
    InterruptCounter++;
}

// Declare your global variables here
flash unsigned char  picture[1024] = {
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,192,248,255,255,255,255, 
 255,255,248,192,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,128,192,224,240,248,252,254,127, 63, 
  31,143,143,223,255,255,254,252,248,240,224,224,224,224,224,192, 
 192,192,192,224,224,240,240,240,248,248,248,248,248,248,248,240, 
 240,240,248,252,254,254,254,252,248,248,248,248,248,248,248,240, 
 240,240,224,192,192,128,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,192,248,252,254,254,252,248,192,  0,  0,  0,  0, 
 240,240,248,248,248,252,252,252,254,190,191,191, 31, 31,  3,  3, 
  31, 31,191,191,190,254,252,252,252,248,248,248,248,252,252,254, 
  62, 62, 31, 31, 31, 31, 31, 31, 31, 31, 31, 31, 63,127,254,255, 
 255,255,255,255,255,255,127, 63, 31, 15,  7,  3,  3,  3, 15, 31, 
  31, 31, 31, 15, 15,  3,  1,  1,  0, 28, 62,127,255,255,255,255, 
 255,239,207,143, 15,  7,  1,129,193,227,247,255,255,255,255,127, 
  63, 31,  7, 15, 63,127,127,126,124,252,248,248,240,252,254,190, 
  62,127,127,127,255,255,255,255,247,255,255,255,127,127,127, 62, 
   1,  1,  3,  3,  3,  7,  7,  7, 15, 15,127,255,255,255,248,248, 
 254,255,255,255,255,255,247,255,255,255,255,255,  3,  1,  1,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1, 
   1,  3,  3,  1,  1,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1,  3, 
   7, 15, 15, 31, 63, 63, 63, 31, 15, 15,  7,  3,  1,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,128,193,227,255,255,255,255, 
 254,  0,  0,  0,  1, 15, 31, 63, 63, 63, 15,  1,  0,  0,  0,  0, 
   0,  0,  0,  0,192,224,240,240,224,192,  0,  3, 31,127,255,255, 
 255,255,231,195,129,129,  1,  1,  1,  1,  1,  1,  0,  0,  0,  0, 
   0,128,225,255,159,129,193,127, 30,  0,112,248,156,148,148,220, 
  88,  0,128,129,241,255,143,128,  0,  0,224,240,148,148,244,252, 
 152,  0,  4, 28,252,196, 96, 60, 12,  4,  0,  0,  0,  0,  0,  0, 
   0,128,225,255,159, 17, 49,249,207,134,  0,  0,240,224,224,224, 
 192,128,128,  0,  0,  0,  0,128,199,207,207,143,135,247,255,255, 
 255,255,252,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
  62, 62, 62,127,255,255,255,255,255,255,127, 62, 62, 62,252,241, 
 251,255,255,255,255, 31, 31, 31, 31, 31, 31, 12,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  2,  2,  2,  3,  2,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  3,  3,  7,  7, 
  31,255,255,255,252,248,248,255,255,255,255,255,255,255,127, 63, 
 127,255,255,252,248,240,240,240,224,224,224,192,  0,  0,  0,  0, 
   0,  0,  0,  0,  1,  3,  7,  7, 55,121,252,252,252,254,255,255, 
 255,255,255,255,255,255,254,252,124,252,248,248,248,248,252,252, 
 252,252,184,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,192,224,224,224,192,128,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
 192,224,224,224,192,  0,  0,  0,  0,  0,  0,  0,  0,128,224,248, 
 252,252,252,248,224,224,224,224,224,224,224,240,240,240,248,252, 
 254,255,255,255,255,255,255,255,127, 15,127,255,255,255,255,254, 
 255,255,255,223,143,135,  7,  7,  7,  3,  3,  1,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  1, 31,127, 
 127,127, 63, 31,  1,  0,  0,  0,  0,128,192,249,255,255,255,255, 
 255,223,223,223,223,223,223,255,255,255,255,255, 31, 31, 31, 31, 
  31, 15, 15, 15, 15, 31, 31, 63,126,254,252,252,252,248,248,254, 
 255,255,255,255,255,254,248,248,252,252,254,254,127, 31, 31, 15, 
   7,131,129,131,131,131,195,195,251,255,255,255,255,255,255,255, 
 255,255,255,255,255,249,249,240,224,  0,224,240,249,255,255,255, 
 127,127, 63, 63, 31, 31, 15,  6,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0, 
   0,  0,  0,  0, 60,126,254,254,255,255,255,255,127,127, 63, 63, 
  63, 31, 31,  7,  7,  7,  7,  7,  7,  3,  3,  1,  0,  0,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,225,255,255,255,255, 
 255,127, 62,127,255,255,255,255,255,225,  1,  0,  0,  0,  0,  6, 
  15, 31, 31, 31, 31, 63, 63, 63,255,255,255,249,255,255,255,127, 
  63, 63, 31, 31, 31, 31,255,255,255,255,255,255,255, 31,  0,  0, 
   0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0,  0 
};






unsigned int CTRLA_value = 0x01;

inline void timer_stop (void)
{
  TCC0.CNT = 0x0000;
  TCC0.CTRLA = 0x00;
}

inline void timer_start (void)
{
  TCC0.CTRLA = CTRLA_value;
}

inline void set_7us (void)
{
  CTRLA_value = 0x01;
  TCC0.PER=0x00DF;
}

inline void set_10ms (void)
{
  CTRLA_value = 0x04;
  TCC0.PER=0x9C3F;
}

void main(void)
{
// Declare your local variables here
unsigned char n;
unsigned char str[22];

// Interrupt system initialization
// Optimize for speed
#pragma optsize- 
// Make sure the interrupts are disabled
#asm("cli")
// Low level interrupt: Off
// Round-robin scheduling for low level interrupt: Off
// Medium level interrupt: On
// High level interrupt: On
// The interrupt vectors will be placed at the start of the Application FLASH section
n=(PMIC.CTRL & (~(PMIC_RREN_bm | PMIC_IVSEL_bm | PMIC_HILVLEN_bm | PMIC_MEDLVLEN_bm | PMIC_LOLVLEN_bm))) |
	PMIC_MEDLVLEN_bm | PMIC_HILVLEN_bm;
CCP=CCP_IOREG_gc;
PMIC.CTRL=n;
// Set the default priority for round-robin scheduling
PMIC.INTPRI=0x00;
// Restore optimization for size if needed
#pragma optsize_default

// System clocks initialization
system_clocks_init();

// Ports initialization
ports_init();

// Virtual Ports initialization
vports_init();

// Timer/Counter TCC0 initialization
tcc0_init();
timer_stop;
timer_interrupt_enable = (void (*)())(timer_start);
timer_interrupt_disable = (void (*)())(timer_stop);
set_delay_7us = (void (*)())(set_7us);
set_delay_10ms = (void (*)())(set_10ms);

// Timer/Counter TCC1 initialization
tcc1_init();

// Globaly enable interrupts
#asm("sei")
delay_ms(500);
glcd_define2(&(PORTE.OUT), &(PORTD.OUT), 1, &(PORTD.OUT), 4, &(PORTD.OUT), 5, &(PORTF.OUT), 1, &(PORTF.OUT), 2, &(PORTF.OUT), 3);
glcd_init2();
TCC1.CNT = 0;
InterruptCounter = 0;
glcd_putbmp2 (picture);
delay_ms(1000);
TCC1.CTRLA = 0x00;
sprintf(str,"0x%04X%04X",InterruptCounter,TCC1.CNT);
glcd_clear2();
glcd_puts_center2(0,str);


while (1)
      {
      // Place your code here

      }
}
