import Graphs as G

function isvalid(x, y)
    count = 0
    for i in x
        if i == y[1] || i == y[2]
            count += 1
            if count == 2
                return true
            end
        end
    end
    return false
end

function process(lines)
    n = length(lines) + 1
    labels = lines .|> (x -> replace(x, ":"=>"") .|> split)
    dict = labels .|> first |> enumerate .|> reverse |> Dict
    dict["out"] = n
    g = G.SimpleDiGraph(n)
    for label in labels
        for node in label[2:end]
            G.add_edge!(g, dict[label[1]], dict[node])
        end
    end
    requirement = [dict["dac"], dict["fft"]]
    return count(x -> isvalid(x, requirement), G.all_simple_paths(g, dict["svr"], n))
end

@time readlines("input/day11.txt") |> process |> println