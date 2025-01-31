COQOPTS = -R ../../plugin CertiCoq.Plugin -I ../../plugin -R ./ CertiCoq.Benchmarks -R ../lib CertiCoq.Benchmarks.lib

ARMGNU = arm-none-eabi

AOPS = --warn --fatal-warnings -mcpu=cortex-m3 -mthumb
COPS = -Wall -O2 -nostdlib -nostartfiles -ffreestanding -mcpu=cortex-m3 -mthumb

OFILES = main.o glue.o gc_stack.o test.o

INCLUDE=./runtime

.PHONY=all clean

all : main.bin

CertiCoq.Benchmarks.tests.test.c: tests.v
	coqc $(COQOPTS) tests.v

vectors.o : vectors.s
	$(ARMGNU)-as $(AOPS) vectors.s -o vectors.o

main.o : main.c
	$(ARMGNU)-gcc $(COPS) -I$(INCLUDE) -c main.c -o main.o

gc_stack.o : $(INCLUDE)/gc_stack.c
	$(ARMGNU)-gcc $(COPS) -I$(INCLUDE) -c $(INCLUDE)/gc_stack.c -o gc_stack.o

test.o : CertiCoq.Benchmarks.tests.test.c
	$(ARMGNU)-gcc $(COPS) -I$(INCLUDE) -c CertiCoq.Benchmarks.tests.test.c -o test.o

glue.o : glue.c
	$(ARMGNU)-gcc $(COPS) -I$(INCLUDE) -c glue.c -o glue.o

main.bin : memmap vectors.o $(OFILES)
	$(ARMGNU)-gcc -nostartfiles -o main.elf -T memmap vectors.o $(OFILES)
	$(ARMGNU)-objdump -D main.elf > main.list
	$(ARMGNU)-objcopy main.elf main.bin -O binary

clean:
	rm -f *.bin
	rm -f *.o
	rm -f *.elf
	rm -f *.list
	rm -f CertiCoq.Benchmarks.tests.*.c
	rm -f CertiCoq.Benchmarks.tests.*.h
	rm -f ./*.vo
	rm -f ./*.vos
	rm -f ./*.vok
	rm -f ./*.glob
