import Combinatorics as Comb

function makebutton(n, x)
    button = zeros(Bool, n)
    for idx in x
        button[idx + 1] = true
    end
    return BitVector(button)
end

function processline(line)
    goal =  (
                match(r"\[.*\]", line).match 
                |> (x -> x[2:end-1]) # Get rid of brackets
                |> collect
                |> x -> x .== '#' # find on positions
            )
    rawbuttons = (
                match(r"\(.*\)", line).match
                |> (x -> replace(x, r"[\(\)]" => ""))
                |> split
                .|> (x -> split(x, ','))
                .|> x -> parse.(Int, x)
            )

    buttons = map(x->makebutton(length(goal), x), rawbuttons)

    combos = Comb.combinations(buttons)
    for combo in combos
        if goal == reduce(.⊻, combo)
            println("Found match $combo")
            return length(combo)
        end
    end
end

function process(lines)
    map(processline, lines) |> sum
end

readlines("input/day10.txt") |> process |> println