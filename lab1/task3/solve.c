#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>

uint64_t find_largest_prime_factor(uint64_t n) {
  uint64_t d = 2;
  while (d * d < n) {
    if (n % d == 0) {
      n /= d;
      d = 2;
    } else {
      d++;
    }
  }
  return n;
}

int main(void) {
  uint64_t n = UINT64_C(600851475143);
  printf("%" PRIu64 "\n", find_largest_prime_factor(n));
  return 0;
}

// gcc -o ../_build/default/task3/solve.exe solve.c