using DelimitedFiles

tomatrix(s) = replace(s, r"\s*\r?\n" => "\n") |> IOBuffer |> readdlm

operator = Dict("+" => +, "*" => *)

processcol(col) = operator[col[end]](col[1:end-1] ...)

process(s) = tomatrix(s) |> (x -> mapslices(processcol, x; dims=1)) |> sum

read("input/day6.txt", String) |> process |> println