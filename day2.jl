function isvalid(value)
    s = string(value)
    result = false
    if length(s) % 2 == 0
        mid = length(s) ÷ 2
        if s[1:mid] == s[mid+1:end]
            result = true
        end
    end
    return result
end

function process(ranges)
    total = 0
    for pair in ranges
        println("Testing pair $pair")
        x, y = pair
        for value in x:y
            if isvalid(value)
                total += value
            end
        end
    end
    return total
end

ranges = (
    readlines("input/day2.txt")
    |> first
    |> x -> split(x, ',')
    .|> (x -> split(x, '-') .|> val -> parse(Int, val))
)

println(process(ranges))
