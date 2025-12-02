function increment(position)
    updated = position == 99 ? 0 : position += 1
    return updated
end

function decrement(position)
    updated = position == 0 ? 99 : position -= 1
    return updated
end

function processline(position, line)
    if line[1] == 'R'
        operator = increment
    else
        operator = decrement
    end
    zeroclicks = 0
    clicks = parse(Int, line[2:end])
    for i = 1:clicks
        position = operator(position)
        if position == 0
            zeroclicks += 1
        end
    end
    return zeroclicks, position
end

function process(lines)
    password = 0
    position = 50
    for line in lines
        zeroclicks, position = processline(position, line)
        password += zeroclicks
    end
    return password
end
lines = readlines("input/day1.txt")

println(process(lines))
