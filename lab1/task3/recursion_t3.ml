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