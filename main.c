#include "gc_stack.h"

extern value body(struct thread_info *);
extern value get_Coq_nat(value);

#define UART0BASE 0x4000C000

// Redirect output to UART
void uart_send(char c) {
    *(volatile unsigned int *)(UART0BASE + 0x00) = c;
}

void print_int(int num) {

  if (num < 0) {
    uart_send('-');  // Print negative sign
    num = -num;      // Convert to positive
  }


  if (num >= 10) print_int(num/10);

  // output the last digit
  uart_send((num % 10) + 0x30);

}


int main() {

  struct thread_info* tinfo;
  value val;
  int i;
  
  tinfo = make_tinfo();
  // make the call to CertiCoq code
  val = body(tinfo);
  // print the result
  i = get_Coq_nat(val);
  print_int(i);
  uart_send('\n');

  return 0;
}
