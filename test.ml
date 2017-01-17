open PPM
open Str

let test_ppm_str_pixel_count =
    let entry_counter =
        (fun x -> List.length (Str.split (Str.regexp " +") x)); in
            QCheck.(Test.make
                ~name:"random ppm: valid count of color channels?"
                ~count:100
                Arbitrary.(int)
                (fun x -> (((entry_counter (rand_ppm_str x)) - 4) mod 3) = 0))

let test_ppm_str_dimensions =
    QCheck.(Test.make
        ~name:"random ppm: accurate header dimensions?"
        ~count:100
        Arbitrary.(int)
        (fun x ->
            let r = (Str.split (Str.regexp " +") rand_ppm_str x) in
                let w = List.nth r 1 and
                    h = List.nth r 2 and
                    d = (List.Length r - 4) in
                        (w * h = d)))

let test_ppm_str_label =
    QCheck.(Test.make
        ~name:"random ppm: expected header label??"
        ~count:1000
        Arbitrary.(int)
        (fun x ->
            let label =
                List.nth (Str.split (Str.regex " +" (rand_ppm_str x))) 0 in
                    (label = "p6")))

(* TODO: valid integers in range *)
(* TODO: max finds max? *)


let () =
    QCheck_runner.run_tests [test_rand_color]
