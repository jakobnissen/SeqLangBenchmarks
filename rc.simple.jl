dir = dirname(dirname(@__FILE__))
push!(LOAD_PATH, dir)

using SeqJL
using BufferedStreams

function main(arg)
        f = open(arg)
        o = BufferedOutputStream(stdout)
        total = 0
        for l in eachline(f)
           seq = reverse_complement!(Seq(l))
           total += length(seq)
           println(o, seq)
        end
        close(f)
        flush(o)
        println("$total")
end

main(ARGS[1])
