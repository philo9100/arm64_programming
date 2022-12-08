#include "uart.h"

extern void ldr_test(void);
extern void my_memcpy_test(void);

extern void load_bigValue_test1();
extern void load_bigValue_test2();

//extern void load_complexValue_test1();
extern void load_complexValue_test2();

//extern void load_string_test1();
extern void load_string_test2();

//extern void load_word_test1();
extern void load_word_test2();

void my_ldr_str_test(void)
{

	ldr_test();
	my_memcpy_test();

	memset(0x200004, 0x55, 102);
}

/*
 * 程序入口，在入口内编写测试函数
 */
void kernel_main(void)
{
	uart_init();
	uart_send_string("Welcome BenOS!\r\n");

	/* my test*/
	my_ldr_str_test();

	/* 测试加载一个很大的数值进通用寄存器	*/
	//load_bigValue_test1();
	load_bigValue_test2();

	/* 测试加载一个复杂的数值进通用寄存器 */
	//load_complexValue_test1();
	load_complexValue_test2();

	/* 测试加载一个字符串进通用寄存器 */
	//load_string_test1();
	load_string_test2();

	/* 测试加载一个字（word）进通用寄存器 */
	//load_word_test1();
	load_word_test2();

	while (1) {
		uart_send(uart_recv());
	}
}
