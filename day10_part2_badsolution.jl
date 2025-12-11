 # We are trying to solve

makebuttoniterator(goal, x) = 0:minimum(goal[x])

function makebutton(n, x)
    button = zeros(Int, n)
    for idx in x
        button[idx] = 1
    end
    return button
end

function processline(line)
    goal =  (
                match(r"\{.*\}", line).match 
                |> (x -> x[2:end-1]) # Get rid of braces
                .|> (x -> split(x, ','))
                .|> x -> parse.(Int, x)
            )
    rawbuttons = (
                match(r"\(.*\)", line).match
                |> (x -> replace(x, r"[\(\)]" => ""))
                |> split
                .|> (x -> split(x, ','))
                .|> (x -> parse.(Int, x))
                .|> (x -> x .+= 1) # Adjust indices
            )

    buttons = map(x->makebutton(length(goal), x), rawbuttons)

    buttoniter = map(x->makebuttoniterator(goal, x), rawbuttons)

    combos = Iterators.product(buttoniter ...) .|> collect |> vec |> x -> sort(x, by=sum)
    for combo in combos
        value = buttons .* combo |> sum
        if goal == value
            println("Found match $combo")
            return sum(combo)
        end
    end
    println("not good")
end

function process(lines)
    map(processline, lines)
end

readlines("input/day10test.txt") |> process |> sum |> println