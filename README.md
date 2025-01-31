# Rocq on Bare Metal

This directory contains preliminary experiments on running Rocq
 (formerly known as Coq) qcode on ARM embedded processors. The code is
 compiled to C using the CertiCoq compiler.

## Dependencies

To compile and run the code, you will need the following tools:

- [CertiCoq](https://github.com/CertiCoq/certicoq)
- [GNU Arm Embedded Toolchain](https://developer.arm.com/downloads/-/gnu-rm)
- [QEMU](https://www.qemu.org/)

## Machine and Processor Details

The experiments target the ARM Cortex-M3 processor, a 32-bit RISC
processor. The machine model used in emulation is the Stellaris
LM3S6965 Evaluation Board (`lm3s6965evb`).

## Running the Experiments

The Coq code is located in `tests.c`. To compile it and link it with
the necessary libraries, run:

```sh
make all
```

To execute the generated code using `qemu`, use:

```sh
qemu-system-arm -M lm3s6965evb -m 64K -nographic -kernel main.bin
```
