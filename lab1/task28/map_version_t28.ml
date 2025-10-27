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
