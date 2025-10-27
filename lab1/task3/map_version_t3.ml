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
