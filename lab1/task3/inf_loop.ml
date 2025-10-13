module S = Seq

let candidate_divisors = S.ints 2

let rec find_largest_factor n candidate_seq =
  match S.uncons candidate_seq with
  | None -> n
  | Some (d, rest_of_seq) ->
      if d * d > n then
        n
      else if n mod d = 0 then
        find_largest_factor (n / d) candidate_seq
      else
        find_largest_factor n rest_of_seq

let () =
  let number_to_factor = 600851475143 in
  let result = find_largest_factor number_to_factor candidate_divisors in
  Printf.printf "%d\n" result