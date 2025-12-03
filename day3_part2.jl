function max(line)
    start = 1
    result = ""
    for remaining in 11:-1:0
        digit, index = findmax(line[start:end-remaining])
        result *= digit
        start += index
    end
    parse(Int, result)
end

readlines("input/day3.txt") |> lines->reduce(+, max.(lines)) |> println