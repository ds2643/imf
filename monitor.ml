(* observe system under test fed random ppm data *)
open Sys

let verify_sut_exec (sut:string):bool =

(* TODO: fuzz_sut, error case for non-existent ppm file *)
let exec_sut (sut:string)(ppm_path:string):int =
    let cmd = sut ^ " " ^ ppm_path in
        if (Sys.file_exists ppm_path)
            then Sys.command cmd
        else raise ``
module Monitor =
    struct

end
