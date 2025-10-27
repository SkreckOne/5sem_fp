let rec calc_matrix n cur_sum =
  if n = 1 then cur_sum + 1
  else calc_matrix (n - 2) (cur_sum + (4 * n * n) - (6 * n) + 6)

let () =
  let n = 1001 in
  let answ = calc_matrix n 0 in
  Printf.printf "%d\n" answ
