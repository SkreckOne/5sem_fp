module S = Seq

let layer_sizes = S.unfold (fun i -> Some (i, i + 2)) 3

let calc_matrix n =
  let sum_of_corners =
    layer_sizes
    |> S.take_while (fun k -> k <= n)
    |> S.map (fun k -> (4 * k * k) - (6 * k) + 6)
    |> S.fold_left ( + ) 0
  in
  sum_of_corners + 1

let () =
  let n = 1001 in
  let answ = calc_matrix n in
  Printf.printf "%d\n" answ
