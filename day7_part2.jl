mutable struct Node
    npaths::Int64
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
    Node() = new(1, nothing, nothing)
    Node(n) = new(n, nothing, nothing)
end

function process(lines)
    root = Node()
    state = Array{Node}(undef, length(lines[1]))
    idx = findfirst(x -> x == 'S', lines[1])
    state[idx] = root
    for line in lines[3:2:end]
        newstate = Array{Node}(undef, length(line))
        for i in eachindex(line)
            if line[i] == '^' && isassigned(state, i)
                left =  if isassigned(newstate, i - 1)
                            newstate[i - 1].npaths += state[i].npaths
                            newstate[i - 1]
                        else
                            Node(state[i].npaths)
                        end
                right = if isassigned(newstate, i + 1)
                            newstate[i + 1].npaths += state[i].npaths
                            newstate[i + 1]
                        else
                            Node(state[i].npaths)
                        end
                state[i].left = left
                state[i].right = right
                newstate[i - 1] = left
                newstate[i + 1] = right
            elseif isassigned(state, i)
                if isassigned(newstate, i)
                    newstate[i].npaths += state[i].npaths
                    state[i].right = newstate[i] # Copy new split in right
                else
                    newstate[i] = state[i] # Copy down tachyons that haven't hit yet
                end
            end
        end
        state = newstate
    end
    sum = 0
    for i in eachindex(state)
        if isassigned(state, i)
            sum += state[i].npaths
        end
    end
    return sum
end

readlines("input/day7.txt") |> process |> println