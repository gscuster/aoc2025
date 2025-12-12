import Graphs as G

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
    allpaths = G.all_simple_paths(g, dict["you"], n)
    return allpaths |> collect |> x -> size(x, 1)
end

readlines("input/day11.txt") |> process |> sum |> println