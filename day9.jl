using DelimitedFiles

area(p1, p2) = (p2 - p1) .|> abs |> (x -> x .+ 1) |> (x -> *(x ...))

function process(m)
    maxarea = 0
    n = size(m, 1)
    for i in 1:n
        for j in (i + 1):n
            a = area(m[i,:], m[j,:])
            if a > maxarea
                maxarea = a
            end
        end
    end
    return maxarea
end

readdlm("input/day9.txt", ',', Int64) |> process |> println