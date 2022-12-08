.section .data
my_data0:
	.quad 0x8a4b2c1d

my_data1:
	.quad 0x8a

my_data2:
	.quad 0x8a4b

my_data3:
	.quad 0x8a4b2c1d

.section .text
.global load_variation_test
load_variation_test:

	ldr x0, =my_data0

	// 测试将 [x0] 内存中的值分别加载进 w1 和 x1 的区别
	ldr w1, [x0]
	ldr x1, [x0]

	ldr x0, =my_data1

	// 测试将 [x0] 内存中的值分别加载一个 byte 进 w1 和 x1 的区别
	ldrb w2, [x0]	// 加载一个byte（默认是无符号）
	// ldrb x2, [x0]	// 这么写汇编时会报错，因为加载一个 byte 只用到了第三个通用寄存器的低 32 位
	ldrsb w3, [x0]	// 加载一个有符号的 byte（signed byte）
	ldrsb x3, [x0]	//

	ldr x4, =my_data2

	ldrh w5, [x4]	// ldr halfword
	// ldrh x5, [x4]
	ldrsh w6, [x4]	// ldr signed halfword
	ldrsh x6, [x4]

	// ldrw w6, [x0]	// ldr word 直接使用 ldr wn
	ldrsw x7, [x0]	// ldr signed word
	ldrsw x7, [x4]

	ldr x8, =my_data3
	ldrsw x7, [x8]
	// ldrsw w7, [x8]	// 这么写会报错

	// ldrdw x8, [x0]	// ldr double word 直接使用 ldr xn
	// ldrsdw x9, [x0]	// 因为目标寄存器最大只有64位，因此没有 ldrswd 这个指令

	/************************************************************/

	// strb x7, [x8, #8]!	// 这么写会报错
	strb w7, [x8, #8]!

	// strh x7, [x8, #8]!	// 这么写会报错
	strh w7, [x8, #8]!

	str w7, [x8, #8]!

	str x7, [x8, #8]!

	ret








