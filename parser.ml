open Angstrom
open PPM

let is_digit = function
    | '0' .. '9' -> true
    | _ -> false

let digits =
    let char_of_string = (fun x -> (char_of_int (int_of_string x))) in
        take_while1 (is_digit) >>=
            (fun x -> return (char_of_string x))

let is_ws = function
  | '\x20' | '\x0a' | '\x0d' | '\x09' -> true
  | _ -> false

let spaces = skip_while is_ws

let pixel =
    let digits_ = (digits <* spaces) in
        lift3 (fun b g r -> (b, g, r)) digits_ digits_ digits_

let eval (str:bytes):(char * char * char) = (* replace signature output with ppm pixel type... *)
    match parse_only pixel (`String str) with
        | Result.Ok v -> v
        | Result.Error msg -> failwith msg

