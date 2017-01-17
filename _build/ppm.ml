(* TODO: unit test formally *)
(* TODO: refactor modular interface *)
(* TODO: generate interface file *)
(* TODO: idiomatically document *)
(* TODO: seek criticism *)

(* ppm grammar specification as type *)

type color = char (*in range 0 255*)

type pixel = color * color * color

type ppm_body = pixel list

type ppm_header = {
    file_type: string; (* "p3" *)
    columns: int;
    rows: int;
    max: char}

type ppm = {
    header: ppm_header;
    body: ppm_body}

(* native ppm to string *)

let header_to_str (a:ppm):string =
    let header = a.header in
        let file_type_str = header.file_type and
        column_str = (string_of_int header.columns) and
        row_str = (string_of_int header.rows) and
        max_str = (string_of_int (Char.code header.max)) in
            file_type_str ^ " " ^ column_str ^ " " ^ row_str ^ " " ^ max_str

let pixel_to_str ((x, y, z):pixel):string =
    (string_of_int (Char.code x)) ^ " " ^ (string_of_int (Char.code y)) ^ " " ^ (string_of_int (Char.code z))

let body_to_str (a:ppm):string =
    let body = a.body in
        String.concat " " (List.map pixel_to_str body)

let ppm_to_string (a: ppm):string =
    let header_str = (header_to_str a) and body_str = (body_to_str a) in
        header_str ^ " " ^ body_str


(* generative component *)

let rand_color ():color = (Char.chr (97 + (Random.int 26)))

let rand_pixel ():pixel = (rand_color (), rand_color (), rand_color ())

(* TODO: error case, no values less than 0 *)
(* TODO: tail call optimize? *)
let rec rand_ppm_body (n: int):ppm_body =
    if n < 0 then (raise Exit) else
        if n = 0 then []
        else rand_pixel () :: rand_ppm_body (n - 1)

let find_max_pixel ((x, y, z): pixel):color =
    if x >= y && x >= y then x
    else if y >= x && y >= z then y
    else z

let list_max l =
  match l with
  [] -> failwith "None"
  |h::t ->  let rec helper (seen,rest) =
              match rest with
              [] -> seen
              |h'::t' -> let seen' = if h' > seen then h' else seen in
                         let rest' = t'
              in helper (seen',rest')
            in helper (h,t)

let find_max_ppm_body (b:ppm_body):char =
    let largest_per_pixel = (List.map find_max_pixel b) in
       list_max largest_per_pixel

let rand_ppm (max_dim:int):ppm =
    let c = (Random.int max_dim) and r = (Random.int max_dim) in
        let b = rand_ppm_body (c * r) in
                { header =
                    { file_type = "p3";
                    columns = c;
                    rows = r;
                    max = (find_max_ppm_body b);};
                body = b;}

(* modular interface *)

module PPM =
    struct
        let rand_ppm_string (max_dim:int):string =
            ppm_to_string (rand_ppm max_dim)
end
