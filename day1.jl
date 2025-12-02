
function pbc(value)
    while value < 0
        value += 100
    end
    while value > 99
        value -= 100
    end
    return value
end

function rotate(start, line)
    if line[1] == 'R'
        operator = +
    else
        operator = -
    end
    clicks = parse(Int, line[2:end])
    value = operator(start, clicks)
    pbcvalue =  pbc(value)
    println("Line $line: $start $operator $clicks = $value ($pbcvalue)")
    return pbcvalue
end

lines = readlines("input/day1.txt")
password = 0
position = 50
for line in lines
    global position = rotate(position, line)
    if position == 0
        global password += 1
    end
end
println(password)