function isvalid(value)
    s = string(value)
    result = false
    len = length(s)
    mid = len ÷ 2
    for last = 1:mid
        len % last != 0 && continue
        if s[1:last]^(len ÷ last) == s
            result = true
            break
        end
    end
    return result
end

(
    readlines("input/day2.txt")
    |> first
    |> x -> split(x, ',')
    .|> (x -> split(x, '-') .|> val -> parse(Int, val)) # Get ranges
    .|> (((x, y),) -> filter(isvalid, x:y) |> sum) # Sum valid values per range
    |> sum
    |> println
)
