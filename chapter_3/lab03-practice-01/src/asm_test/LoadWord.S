/* 无法直接加载一个word进寄存器 */
/*
.global load_word_test1
load_word_test1:
	my_data1:
		.word 0x40

	ldr x0, my_data1
	ldr x1, =my_data1

	ret
*/

.section .data
my_data2:
	.word 0x40	// 一个 word 占4个字节

.section .text
.global load_word_test2
load_word_test2:
	// 先将 my_data 首字节的地址加载进通用寄存器 x0
	ldr x0, =my_data2

	// 通过 x0 寄存器中存的地址值找到对应的内存位置，将该位置的数据加载进 x1 寄存器的低 32 位（低 4 bytes）
	ldr w1, [x0]	// w1 表示第二个通用寄存器的低 32 位（低 4 bytes），x1 表示第二个通用寄存器的全部 64 位（8 bytes）

	ret
