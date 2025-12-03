function max(line)
    digit1, digit1idx = findmax(line[1:end-1])
    digit2 = maximum(line[digit1idx+1:end])
    parse(Int, digit1 * digit2)
end

readlines("input/day3.txt") |> lines->reduce(+, max.(lines)) |> println