

function process(lines)
    state = lines[1] |> collect |> x -> x .== 'S'
    splits = 0
    for line in lines[2:end]
        hitsplitters = line |> collect |> (x-> x .== '^') |> x -> x .* state
        splits += sum(hitsplitters)
        for i in eachindex(hitsplitters)
            if hitsplitters[i] == true
                state[i] = false
                if i > 1
                    state[i - 1] = true
                end
                if i < length(state)
                    state[i + 1] = true
                end
            end
        end
    end
    return splits
end

readlines("input/day7.txt") |> process |> println