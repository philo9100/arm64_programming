/* 无法直接将一个字符串加载进寄存器 */
/*
.global load_string_test1
load_string_test1:
	string1:
		.string "Hello World"

	ldr x0, string1
	ldr x1, =string1

	ret
*/

/* 通过地址取值的方式分别把字节一个一个的加载进寄存器 */
.section .data
string2:
	.ascii "Hello World"

.section .text
.global load_string_test2
load_string_test2:
	// 先将数据段的数据 string1 的地址加载进通用寄存器 x0
	ldr x0, =string2

	// 通过寄存器 x0 中保存的地址值找到string1在内存中首字节的位置
	// 从该位置开始连续加载第一个 8 bytes（characters）进通用寄存器 x1
	ldr x1, [x0]

	// 通过寄存器 x0 中保存的地址值再偏移 8 个bytes作为新的地址值找到该位置
	// 从该位置开始连续加载第二个8 bytes（remaining characters）进通用寄存器 x2
	ldr x2, [x0, #8]

	// 通过这种方式，x1 包含 'H','e','l','l','o',' ','W','o'
	// x2 包含 'r','l','d','0','0','0','0','0'

	// 如果还有要加载的的字符，接着在首地址上进行偏移
	// ldr x3, [x0, #16]

	ret
