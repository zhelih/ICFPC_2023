open Devkit
open Problem_t

let solve p =
  Array.iter (fun inst ->
    let (x_opt, y_opt) = Numeric.almost_optimal_musician inst p in
    printfn "%f\t%f" x_opt y_opt
  ) p.musicians
