let test_task3_cycle () = Alcotest.(check int) "task3 cycle" 6857 (Task3_lib.Cycle_t3.find_largest_prime_factor 600851475143)
let test_task3_inf_loop () = Alcotest.(check int) "task3 inf_loop" 6857 (Task3_lib.Inf_loop_t3.find_largest_factor 600851475143 Task3_lib.Inf_loop_t3.candidate_divisors)
let test_task3_map_version () = Alcotest.(check int) "task3 map_version" 6857 (Task3_lib.Map_version_t3.find_largest_prime_factor 600851475143)
let test_task3_module_realisation () = Alcotest.(check int) "task3 module_realisation" 6857 (Task3_lib.Module_realisation_t3.find_largest_prime_factor 600851475143)
let test_task3_recursion () = Alcotest.(check int) "task3 recursion" 6857 (Task3_lib.Recursion_t3.find_largest_prime_factor 600851475143)
let test_task3_tail_recursion () = Alcotest.(check int) "task3 tail_recursion" 6857 (Task3_lib.Tail_recursion_t3.find_largest_prime_factor 600851475143)

let test_task28_cycle () = Alcotest.(check int) "task28 cycle" 669171001 (Task28_lib.Cycle_t28.calc_matrix 1001)
let test_task28_inf_loop () = Alcotest.(check int) "task28 inf_loop" 669171001 (Task28_lib.Inf_loop_t28.calc_matrix 1001)
let test_task28_map_version () = Alcotest.(check int) "task28 map_version" 669171001 (Task28_lib.Map_version_t28.calc_matrix 1001)
let test_task28_module_realisation () = Alcotest.(check int) "task28 module_realisation" 669171001 (Task28_lib.Module_realisation_t28.calc_matrix 1001)
let test_task28_recursion () = Alcotest.(check int) "task28 recursion" 669171001 (Task28_lib.Recursion_t28.calc_matrix 1001)
let test_task28_tail_recursion () = Alcotest.(check int) "task28 tail_recursion" 669171001 (Task28_lib.Tail_recursion_t28.calc_matrix 1001 0)

let task3_suite = [
    ("Cycle_t3", `Quick, test_task3_cycle);
    ("Inf_loop_t3", `Quick, test_task3_inf_loop);
    ("Map_version_t3", `Quick, test_task3_map_version);
    ("Module_realisation_t3", `Quick, test_task3_module_realisation);
    ("Recursion_t3", `Quick, test_task3_recursion);
    ("Tail_recursion_t3", `Quick, test_task3_tail_recursion);
]

let task28_suite = [
    ("Cycle_t28", `Quick, test_task28_cycle);
    ("Inf_loop_t28", `Quick, test_task28_inf_loop);
    ("Map_version_t28", `Quick, test_task28_map_version);
    ("Module_realisation_t28", `Quick, test_task28_module_realisation);
    ("Recursion_t28", `Quick, test_task28_recursion);
    ("Tail_recursion_t28", `Quick, test_task28_tail_recursion);
]

let () = Alcotest.run "Project Tests" [
    ("Task 3", task3_suite);
    ("Task 28", task28_suite)
]