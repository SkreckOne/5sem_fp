let rec calc_matrix n =
  if n = 1 then 1 else (4 * n * n) - (6 * n) + 6 + (n - 2 |> calc_matrix)

let () =
  let n = 1001 in
  let answ = calc_matrix n in
  Printf.printf "%d\n" answ
