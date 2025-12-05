using DSP

convert(char) = char == '@' ? 1 : 0

function tomatrix(lines)
    x, y = length(lines), length(lines[1])
    result = zeros(Int, length(lines), length(lines[1]))
    for i in 1:x
        for j in 1:y
            result[i, j] = convert(lines[i][j])
        end
    end
    return result
end

sumkernel = [1 1 1;
             1 0 1;
             1 1 1]

removepadding(matrix) = matrix[2:end-1, 2:end-1]

function removerolls(m)
    accessible = DSP.conv(m, sumkernel) |> removepadding |> x -> x .< 4
    removable = accessible .* (m .^ 1) |> sum
    newm =  m .* .!accessible
    return newm, removable
end

function process(lines)
    m = tomatrix(lines)
    totalremoved = 0
    while true
        m, removed = removerolls(m)
        if removed == 0
            break
        end
        totalremoved += removed
    end
    return totalremoved
end

(
    readlines("input/day4.txt")
    |> process
    |> println
)