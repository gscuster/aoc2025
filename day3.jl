function max(line)
    digit1, digit1idx = findmax(line[1:end-1])
    digit2 = maximum(line[digit1idx+1:end])
    return parse(Int, digit1 * digit2)
end

function process(lines)
    reduce(+, max.(lines))
end

lines = readlines("input/day3.txt")

process(lines) |> println