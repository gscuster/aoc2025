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
isaccessible(val) = 0 < val < 4

function process(lines)
    m = tomatrix(lines)
    summed = DSP.conv(m, sumkernel) |> removepadding
    accessible = summed .< 4
    masked = accessible .* (m .^ 1)
    sum(masked)
end

(
    readlines("input/day4.txt")
    |> process
    |> println
)