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
