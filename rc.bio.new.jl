using BioSequences

function main(arg)
        f = open(arg)
        total = 0
        seq = dna""
        for l in eachline(f)
           seq = reverse_complement!(copy!(seq, l))
           total += length(seq)
           println(seq)
        end
        close(f)
        println("$total")
end

main(ARGS[1])
