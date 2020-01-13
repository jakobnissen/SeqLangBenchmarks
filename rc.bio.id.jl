using BioSequences

function main(arg)
        f = open(arg)
        total = 0
        for l in eachline(f)
           seq = reverse_complement!(DNASequence(l))
           total += length(seq)
           println(seq)
        end
        close(f)
        println("$total")
end

main(ARGS[1])
