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
