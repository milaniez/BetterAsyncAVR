#pragma used+

// define GLCD
void glcd_define (unsigned char *glcd_data_port_address,
                  unsigned char *glcd_rs_port_address,  unsigned char glcd_rs_pin,
                  unsigned char *glcd_rw_port_address,  unsigned char glcd_rw_pin,
                  unsigned char *glcd_en_port_address,  unsigned char glcd_en_pin,
                  unsigned char *glcd_cs1_port_address, unsigned char glcd_cs1_pin,
                  unsigned char *glcd_cs2_port_address, unsigned char glcd_cs2_pin,
                  unsigned char *glcd_rst_port_address, unsigned char glcd_rst_pin);

// Timer function pointers

extern void (*timer_interrupt_enable) (void);
extern void (*timer_interrupt_disable) (void);
extern void (*set_delay_7us) (void);
extern void (*set_delay_10ms) (void);

extern unsigned char StackPointer;
#define glcd_status() (~StackPointer)

// GLCD interrupt function
void glcd_timer_isr (void);

// GLCD initializing function
void glcd_init (void);

// GLCD write byte in specific column and page function
void glcd_writebyte (unsigned char clmn, unsigned char pg, unsigned char data);

// GLCD clear page function
void glcd_clear_page (unsigned char page);

// GLCD put character function
void glcd_putchar (unsigned char column, unsigned char page, unsigned char ch);

// GLCD put string function
void glcd_puts (unsigned char column, unsigned char page, unsigned char *str);

// GLCD put string in center function
void glcd_puts_center (unsigned char page, unsigned char *str);

// GLCD put flash string function
void glcd_putsf (unsigned char column, unsigned char page, flash unsigned char *str);
// GLCD put flash string in center function
void glcd_putsf_center (unsigned char page, flash unsigned char *str);

// GLCD clear function
void glcd_clear (void);

// GLCD put bitmap function
void glcd_putbmp (flash unsigned char *bmp);

#pragma used-
#pragma library glcd128x64tdV2b.lib