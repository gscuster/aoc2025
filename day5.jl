inrange((x, y), val) = x <= val <= y

function isfresh(fresh, id)
    any(arr -> inrange(arr, id), fresh)
end

function process(s::String)
    rawfresh, rawids = split(s, r"(\r?\n){2}")
    fresh = (
                split(rawfresh, r"\r?\n")
                .|> x -> split(x, "-")
                .|> x -> parse.(Int, x)
            )
    ids =   (
                split(rawids, r"\r?\n")
                |> x -> filter(!isempty, x)
                .|> x -> parse(Int, x)
            )
    count(x->isfresh(fresh, x), ids)
end

(
    read("input/day5.txt", String)
    |> process
    |> println
)