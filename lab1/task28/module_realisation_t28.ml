let gen_odds n =
  let res = [] in
  let rec generator nn =
    match nn with
    | 1 -> 1 :: res
    | i -> ((4 * i * i) - (6 * i) + 6) :: generator (i - 2)
  in
  generator n

let calc_matrix n =
  let res = gen_odds n in
  List.fold_left ( + ) 0 res

let () =
  let n = 1001 in
  let answ = calc_matrix n in
  Printf.printf "%d\n" answ
