shouldmerge((x1, y1), (x2, y2)) = (x2 <= y1 <= y2) || (x1 <= y2 <= y1)

mergerange(x, y) = [minimum([x[1], y[1]]), maximum([x[2], y[2]])] 

function combine(ranges)
    new = []
    r = []
    removed = Set{Int}()
    for i in eachindex(ranges)
        i in removed && continue # Skip i if we removed it
        r = ranges[i]
        for j in i:length(ranges)
            if shouldmerge(r, ranges[j])
                r = mergerange(r, ranges[j])
                push!(removed, j)
            end
        end
        push!(new, r)
    end
    return new
end

function process(s::String)
    (
        split(s, r"(\r?\n){2}")
        |> first # Fresh ranges
        |> (x -> split(x, r"\r?\n"))
        .|> (x -> split(x, "-"))
        .|> (x -> parse.(Int, x))
        |> (x -> sort(x, by=y->y[2])) # Optional sorting
        |> sort # Optional sorting
        |> combine
        .|> (((x, y),) -> y - x + 1)
        |> sum
    )
end

(
    read("input/day5.txt", String)
    |> process
    |> println
)