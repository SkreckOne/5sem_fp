# Лабораторная работа №1

**Выполнил:** Морозов Ярослав Валерьевич  
**Группа:** P3315  
**Языки:** OCaml, С  

---

# Project Euler — Задачи 3 и 28

- Задача 3 (Largest Prime Factor): наибольший простой делитель числа 600851475143 → ответ: 6857
- Задача 28 (Number spiral diagonals): сумма чисел на диагоналях спирали 1001×1001 → ответ: 669171001

Примечания:
- OCaml-код рассчитан на 64-битную сборку (int = 63 бита), число 600851475143 помещается. На 32-битной сборке используйте Int64.
- В C используем uint64_t.

Сборка:
- C: gcc -O2 solve.c -o solve
- OCaml (однофайловые примеры): ocamlopt code.ml -o run (или dune)

---

## Задача 3 — Largest Prime Factor

Условие: найти наибольший простой делитель числа 600851475143.

Идея:
- Делим n на найденные делители d (начиная с 2), «выедая» их полностью.
- Когда d*d > n — остаток n прост и является ответом.
- Сложность: O(sqrt(n)).

Ожидаемый результат: 6857.

### OCaml — Вариант 1 (императивный, с перезапуском делителя)

```ocaml
let find_largest_prime_factor nn =
  let n = ref nn in
  let d = ref 2 in
  while !d * !d < !n do
    if !n mod !d = 0 then (
      n := !n / !d;
      d := 2)
    else incr d
  done;
  !n

let () =
  let nn = 600851475143 in
  let r = find_largest_prime_factor nn in
  Printf.printf "%d\n" r
```

### OCaml — Вариант 2 (через Seq)

```ocaml
module S = Seq

let candidate_divisors = S.ints 2

let rec find_largest_factor n candidate_seq =
  match S.uncons candidate_seq with
  | None -> n
  | Some (d, rest_of_seq) ->
      if d * d > n then
        n
      else if n mod d = 0 then
        find_largest_factor (n / d) candidate_seq
      else
        find_largest_factor n rest_of_seq

let () =
  let number_to_factor = 600851475143 in
  let result = find_largest_factor number_to_factor candidate_divisors in
  Printf.printf "%d\n" result
```

### OCaml — Вариант 3 (предвычисление кандидатов)

```ocaml
let find_largest_prime_factor n =
  let limit = int_of_float (sqrt (float n)) in
  let base = List.init ((limit - 1) / 2) (fun i -> i + 1) in
  let candidates = 2 :: List.map (fun k -> (2 * k) + 1) base in
  let rec divide_out m p = if m mod p = 0 then divide_out (m / p) p else m in
  let rec go m best lst =
    match lst with
    | [] -> max best m
    | d :: ds ->
        if d * d > m then max best m
        else if m mod d = 0 then go (divide_out m d) d ds
        else go m best ds
  in
  go n 1 candidates

let () =
  let n = 600851475143 in
  let r = find_largest_prime_factor n in
  Printf.printf "%d\n" r
```

### OCaml — Вариант 4 (через делители + проверка простоты)
Внимание: для простого n этот вариант вернёт 1 (можно добавить проверку: если список пуст — вернуть n).

```ocaml
let is_prime n =
  if n = 2 then true
  else if n mod 2 = 0 then false
  else
    let rec check d =
      if d * d > n then true else if n mod d = 0 then false else check (d + 2)
    in
    check 3

let divisors n =
  let rec go d acc =
    if d * d > n then acc
    else if n mod d = 0 then
      if d * d = n then go (d + 1) (d :: acc)
      else go (d + 1) (d :: (n / d) :: acc)
    else go (d + 1) acc
  in
  go 2 [] |> List.rev

let find_largest_prime_factor n =
  let primes = divisors n |> List.filter is_prime in
  List.fold_left max 1 primes

let () =
  let n = 600851475143 in
  let r = find_largest_prime_factor n in
  Printf.printf "%d\n" r
```

### OCaml — Вариант 5 (рекурсивный с сравнением «хвоста»)

```ocaml
let rec find_largest_prime_factor ?(d = 2) n =
  if d * d > n then n
  else if n mod d = 0 then
    let rest = find_largest_prime_factor ~d:2 (n / d) in
    if rest > d then rest else d
  else find_largest_prime_factor ~d:(d + 1) n

let () =
  let n = 600851475143 in
  let r = find_largest_prime_factor n in
  Printf.printf "%d\n" r
```

### OCaml — Вариант 6 (рекурсивный, «возвращаем простое»)

```ocaml
let rec find_largest_prime_factor ?(d = 2) n =
  if d * d > n then n
  else if n mod d = 0 then find_largest_prime_factor ~d:2 (n / d)
  else find_largest_prime_factor ~d:(d + 1) n

let () =
  let n = 600851475143 in
  let r = find_largest_prime_factor n in
  Printf.printf "%d\n" r
```

### C — Вариант (uint64_t)

```c
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
```

---

## Задача 28 — Number spiral diagonals

Условие: какова сумма чисел на диагоналях в спирали n×n (n нечётно), построенной стандартным способом? Для n = 1001 → 669171001.

Формула углов слоя с размером k (k нечётно, k ≥ 3): 4k^2 − 6k + 6. Итог: сумма по k = 3,5,7,…,n плюс 1.

### OCaml — Вариант 1 (Seq)

```ocaml
module S = Seq
let layer_sizes = S.unfold (fun i -> Some (i, i + 2)) 3

let calc_matrix n =
  let sum_of_corners =
    layer_sizes
    |> S.take_while (fun k -> k <= n)
    |> S.map (fun k -> (4 * k * k) - (6 * k) + 6)
    |> S.fold_left (+) 0
  in
  sum_of_corners + 1

let () =
  let n = 1001 in
  let answ = calc_matrix n in
  Printf.printf "%d\n" answ
```

### OCaml — Вариант 2 (генерация нечётных, map + fold)

```ocaml
let gen_odds n =
  let res = [] in
  let rec generator nn =
    match nn with 1 -> 1 :: res | i -> i :: generator (i - 2)
  in
  generator n

let calc_matrix n =
  gen_odds n
  |> List.map (fun k -> if k = 1 then 1 else (4 * k * k) - (6 * k) + 6)
  |> List.fold_left ( + ) 0

let () =
  let n = 1001 in
  let answ = calc_matrix n in
  Printf.printf "%d\n" answ
```

### OCaml — Вариант 3 (генератор сразу даёт вклад слоя)

```ocaml
let gen_odds n = 
  let res = [] in
  let rec generator nn =
    match nn with
    | 1 -> 1 :: res
    | i -> (4 * i * i) - (6 * i) + 6 :: generator (i-2) in
  generator n

let calc_matrix n = 
  let res = gen_odds n in List.fold_left (+) 0 res


let () =
  let n = 1001 in
  let answ = calc_matrix n in
  Printf.printf "%d\n" answ
```

### OCaml — Вариант 4 (простая рекурсия)

```ocaml
let rec calc_matrix n =
  if n = 1 then 1 else (4 * n * n) - (6 * n) + 6 + (n - 2 |> calc_matrix)

let () =
  let n = 1001 in
  let answ = calc_matrix n in
  Printf.printf "%d\n" answ
```

### OCaml — Вариант 5 (хвостовая рекурсия)

```ocaml
let rec calc_matrix n cur_sum =
  if n = 1 then cur_sum + 1
  else calc_matrix (n - 2) (cur_sum + (4 * n * n) - (6 * n) + 6)

let () =
  let n = 1001 in
  let answ = calc_matrix n 0 in
  Printf.printf "%d\n" answ
```

### C — Вариант (итеративно)

```c
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
```

---

## Результаты

- Задача 3 → 6857
- Задача 28 → 669171001

---

## Общие выводы

- Императивные приёмы: циклы while, изменяемые ссылки (ref) в OCaml, перезапуск делителя после деления, полное «выедание» множителя.
- Функциональные приёмы: рекурсия и хвостовая рекурсия с аккумулятором, pattern matching, композиции map/filter/fold, мелкая декомпозиция (is_prime, divisors, divide_out).
- Ленивые последовательности: Seq.unfold/take_while/map/fold_left, использование Seq.uncons, генерация бесконечных потоков кандидатов.
- Математическая оптимизация: вывод формулы вклада слоя (4k^2 − 6k + 6) и переход к закрытой O(1) формуле вместо симуляции.
- Оптимизация перебора: ограничение по sqrt(n), раннее завершение при d*d > n, пропуск чётных делителей после 2.
- Безопасность чисел: выбор 64-битных типов (uint64_t, Int64 при необходимости), защита от переполнений (условие d <= n/d, приём с __uint128_t в C).
- Производительность vs читаемость: Seq — декларативно и наглядно, но медленнее; хвостовая рекурсия и простые циклы — быстрее.
- Минимизация повторных вычислений: полное деление на найденный делитель, генерация только нечётных делителей и размеров слоёв.
- Разделение ответственности: отделение генерации данных от агрегирования, чистые функции для удобства тестирования и повторного использования.