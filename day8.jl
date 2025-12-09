using DelimitedFiles

sqdistance(p1, p2) = (p2 - p1).^2 |> sum

function sqdistances(m)
    n = size(m, 1)
    npair = (n * (n - 1)) ÷ 2
    sqdistances = zeros(Int64, npair, 3) # distance, index1, index2
    idx = 1
    for i in 1:n
        for j in (i + 1):n
            sqdistances[idx, 1] = sqdistance(m[i,:], m[j,:])
            sqdistances[idx, 2] = i
            sqdistances[idx, 3] = j
            idx += 1
        end
    end
    return sqdistances
end

function connect!(connections, x, y)
    groupyidx = connections.indexes[y]
    groupxidx = connections.indexes[x]

    if groupyidx == groupxidx
        return
    end

    groupy = connections.groups[groupyidx]
    for idx in groupy
        connections.indexes[idx] = groupxidx
    end
    push!(connections.groups[groupxidx], groupy ...)
    connections.groups[groupyidx] = []
end

mutable struct Connections
    groups::Vector{Vector{Int64}}
    indexes::Vector{Int64}
    Connections(n) = new(map(x->[x], 1:n), collect(1:n))
end

function process(m)
    rawdist = sqdistances(m)
    sqd = rawdist |> x-> x[sortperm(x[:,1]), :]
    n = size(m, 1)
    connections = Connections(n)
    nconnect = 1000
    for i in 1:nconnect
        connect!(connections, sqd[i, 2], sqd[i, 3])
    end
    length.(connections.groups) |> (x -> sort(x, rev=true)) |> (x -> x[1:3]) |> x -> *(x ...)
end

readdlm("input/day8.txt", ',', Int64) |> process |> println