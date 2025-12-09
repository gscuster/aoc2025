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
    println("Merging group $groupxidx with $groupyidx")
    xsize = length(connections.groups[groupxidx])
    ysize = length(connections.groups[groupyidx])
    println("Connecting $xsize circuits with $ysize circuits")

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

function connectall(sqd, connections)
    n = size(sqd, 1)
    goal = length(connections.indexes)
    conn = 0
    for i in 1:n
        conn += 1
        x = sqd[i, 2]
        y = sqd[i, 3]
        connect!(connections, x, y)
        println("Connected $x, $y. There are $conn connections")
        if length(connections.groups[connections.indexes[x]]) == goal
            println("There are $conn connections between $goal circuits, last was $x, $y")
            return x, y
        end
    end
end

function process(m)
    rawdist = sqdistances(m)
    sqd = rawdist |> x-> x[sortperm(x[:,1]), :]
    n = size(m, 1)
    connections = Connections(n)
    i, j = connectall(sqd, connections)
    display(m[i, :])
    display(m[j, :])
    m[i, 1] * m[j, 1]
end

readdlm("input/day8.txt", ',', Int64) |> process |> println