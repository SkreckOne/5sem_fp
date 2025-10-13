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
