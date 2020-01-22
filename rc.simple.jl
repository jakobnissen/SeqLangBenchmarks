dir = dirname(dirname(@__FILE__))
push!(LOAD_PATH, dir)

using SeqJL

function main(arg)
    f = open(arg)
    total = 0
    seq = Seq()
    for l in eachline(f)
        seq = reverse_complement!(copy!(seq, l))
        total += length(seq)
        println(seq)
    end
    close(f)
    println("$total")
end

main(ARGS[1])
