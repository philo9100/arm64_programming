ARMGNU ?= aarch64-linux-gnu

board ?= rpi4

ifeq ($(board), rpi3)
COPS += -DCONFIG_BOARD_PI3B
QEMU_FLAGS  += -machine raspi3
else ifeq ($(board), rpi4)
COPS += -DCONFIG_BOARD_PI4B
QEMU_FLAGS  += -machine raspi4
endif

COPS += -g -Wall -nostdlib -nostdinc -Iinclude
ASMOPS = -g -Iinclude 

BUILD_DIR = build
SRC_DIR = src

all : benos.bin

clean :
	rm -rf $(BUILD_DIR) *.bin *.elf

# Find all C and Assembly files recursively in the SRC_DIR
C_FILES = $(shell find $(SRC_DIR) -name "*.c")
ASM_FILES = $(shell find $(SRC_DIR) -name "*.S")
#C_FILES = $(wildcard $(SRC_DIR)/*.c)
#ASM_FILES = $(wildcard $(SRC_DIR)/*.S)

# Generate object files paths in the BUILD_DIR, preserving directory structure
#OBJ_FILES = $(C_FILES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%.o)
#OBJ_FILES += $(ASM_FILES:$(SRC_DIR)/%.S=$(BUILD_DIR)/%.o)
OBJ_FILES = $(C_FILES:$(SRC_DIR)/%.c=$(BUILD_DIR)/%_c.o)
OBJ_FILES += $(ASM_FILES:$(SRC_DIR)/%.S=$(BUILD_DIR)/%_s.o)

# Generate list of directories to be created
DIRS = $(sort $(dir $(OBJ_FILES)))

# Rule to create necessary directories
create_dirs:
	mkdir -p $(DIRS)
	
# Dependency files
DEP_FILES = $(OBJ_FILES:%.o=%.d)
-include $(DEP_FILES)
#DEP_FILES = $(OBJ_FILES:%.o=%.d)
#-include $(DEP_FILES)

# Pattern rules for compiling C and Assembly files
#$(BUILD_DIR)/%.o: $(SRC_DIR)/%.c
#	mkdir -p $(@D)
#	$(ARMGNU)-gcc $(COPS) -MMD -c $< -o $@
#
#$(BUILD_DIR)/%.o: $(SRC_DIR)/%.S
#	mkdir -p $(@D)
#	$(ARMGNU)-gcc $(ASMOPS) -MMD -c $< -o $@
$(BUILD_DIR)/%_c.o: $(SRC_DIR)/%.c | create_dirs
	$(ARMGNU)-gcc $(COPS) -MMD -c $< -o $@

$(BUILD_DIR)/%_s.o: $(SRC_DIR)/%.S | create_dirs
	$(ARMGNU)-gcc $(ASMOPS) -MMD -c $< -o $@

benos.bin: $(SRC_DIR)/linker.ld $(OBJ_FILES)
	$(ARMGNU)-ld -T $(SRC_DIR)/linker.ld -o $(BUILD_DIR)/benos.elf  $(OBJ_FILES)
	$(ARMGNU)-objcopy $(BUILD_DIR)/benos.elf -O binary benos.bin
	cp $(BUILD_DIR)/benos.elf benos.elf

QEMU_FLAGS  += -nographic

run:
	qemu-system-aarch64 $(QEMU_FLAGS) -kernel benos.bin
debug:
	qemu-system-aarch64 $(QEMU_FLAGS) -kernel benos.bin -S -s
