/* mov 指令不能直接处理复杂的表达式 */
/*
.global load_complexValue_test1
load_complexValue_test1:
	mov x1, (1<<0)|(1<<2)|(1<<20)|(1<<40)|(1<<55)
	// Error: immediate cannot be moved by a single instruction

	ret
*/

/*	可以使用或指令 orr */
.global load_complexValue_test2
load_complexValue_test2:
	mov x1, #1
	orr x1, x1, #0x4				// 1 << 2 = 0x4
	orr	x1, x1, #0x100000			// 1 << 20 = 0x10 0000
	orr x1, x1, #0x10000000000		// 1 << 40 = 0x1 00 00 00 00 00
	orr x1, x1, #0x80000000000000	// 1 << 55 = 0x80 00 00 00 00 00 00

	ret
