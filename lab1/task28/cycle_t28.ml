let calc_matrix nn =
  let n = ref nn in
  let sum = ref 0 in
  while !n > 0 do
    if !n = 1 then incr sum else sum := !sum + (4 * !n * !n) - (6 * !n) + 6;
    n := !n - 2
  done;
  !sum

let () =
  let n = 1001 in
  let answ = calc_matrix n in
  Printf.printf "%d\n" answ
