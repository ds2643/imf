Open OUnit2
Open QCheck

let test_rand_color =
    QCheck.(Test.make
        ~name:"random_color produces output of type color"
        ~count:1000
        Arbitrary.(unit)
        (fun x -> (PPM.rand_color x) ))
    (* assert rand_color () produces a result of type color *)

let test_max_pixel =


test_max_pixel (x, y, z)
test_find_max_ppm_body b
test list_max l

let _ =
    QCheck_runner.run_tests [test_rand_color]
