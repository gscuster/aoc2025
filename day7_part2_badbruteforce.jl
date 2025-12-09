mutable struct Node
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    Node() = new(nothing, nothing)
end

function buildtree(lines)
    root = Node()
    state = Array{Node}(undef, length(lines[1]))
    idx = findfirst(x -> x == 'S', lines[1])
    state[idx] = root
    for line in lines[3:2:end]
        newstate = Array{Node}(undef, length(line))
        for i in eachindex(line)
            if line[i] == '^' && isassigned(state, i)
                left = isassigned(newstate, i - 1) ? newstate[i - 1] : Node()
                right =  isassigned(newstate, i + 1) ? newstate[i + 1] : Node()
                state[i].left = left
                state[i].right = right
                newstate[i - 1] = left
                newstate[i + 1] = right
            elseif isassigned(state, i)
                if isassigned(newstate, i)
                    state[i].right = newstate[i] # Copy new split in right
                else
                    newstate[i] = state[i] # Copy down tachyons that haven't hit yet
                end
            end
        end
        state = newstate
    end
    return root
end

function countpaths(node)
    if isnothing(node.left) && isnothing(node.right)
        return 1
    elseif isnothing(node.left)
        return countpaths(node.right) #happens when tachyons branch in to existing path
    else
        return countpaths(node.left) + countpaths(node.right)
    end
end

# this is way too slow to run on the whole dataset, complexity is 2^n
# (where n is lines with splitters)
readlines("input/day7_test.txt") |> buildtree |> countpaths |> println