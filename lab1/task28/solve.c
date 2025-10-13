#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>

uint64_t calc_square(uint64_t n) {
  uint64_t sum = 0;
  while (n > 0) {
    if (n == 1) {
      sum++;
      break;
    }
    sum += (4 * n * n) - (6 * n) + 6;
    n -= 2;
  }
  return sum;
}

int main(void) {
  uint64_t n = UINT64_C(1001);
  printf("%" PRIu64 "\n", calc_square(n));
  return 0;
}

// gcc -o ../_build/default/task28/solve.exe solve.c