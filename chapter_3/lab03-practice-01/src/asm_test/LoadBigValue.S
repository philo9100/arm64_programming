/*
在有些机器上不能加载一个很大的数到寄存器中，在我这台主机上却可以

例如，下面的程序
*/
.global load_bigValue_test1
load_bigValue_test1:
	mov x0, #0xffffffff0000ffff
	// 将 1111 1111 1111 1111 1111 1111 1111 1111 0000 0000 0000 0000 1111 1111 1111 1111 加载进 x1 寄存器

	ret

/*
可以将一个很大的数分为小的部分加载进寄存器，使用 movz movk 指令
*/
.global load_bigValue_test2
load_bigValue_test2:
	movz x0, #0x9abc			// 在 x0 寄存器中加载低 16 位
	movk x0, #0x5678, lsl #16	// 在 x0 寄存器中左移 16 位后再加载 16 位
	movk x0, #0x1234, lsl #32	// 在 x0 寄存器中左移 32 位后再加载 16 位

	ret

