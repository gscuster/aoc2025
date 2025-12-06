
operator = Dict("+" => +, "*" => *)

processeq(eq) = parse.(Int, eq[2:end]) |> x -> operator[eq[1]](x ...)

function toequations(lines)
    n = length(lines)
    eqregex = Regex("\\s{" * string(n + 1) * "}")
    (
        reduce(hcat, collect.(lines)) # get columns for equations
        |> cols -> hcat(cols[:,n], fill(" ", length(lines[1])), cols[:,1:n-1]) # rearrange
        |> (x -> mapslices(y-> *(y ...), x; dims=2)) # combine elements in the columns
        |> (x -> *(x ...)) # combine everything
        |> (x -> split(x, eqregex)) # Split each equation apart
        .|> split # Split the values in each equation apart
    )
end

process(s) = toequations(s) .|> processeq |> sum

readlines("input/day6.txt") |> process |> println
