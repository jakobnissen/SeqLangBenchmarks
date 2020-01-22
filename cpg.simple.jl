dir = dirname(dirname(@__FILE__))
push!(LOAD_PATH, dir)

using SeqJL

const CPG_LUT = let
    bytes = zeros(UInt8, 256)
    bytes[UInt('G')+1] = 2
    bytes[UInt('g')+1] = 2
    bytes[UInt('C')+1] = 1
    bytes[UInt('c')+1] = 1
    Tuple(bytes)
end

function cpg(seq)
    lastbase = 0x00
    run = 1
    ncpg = 0
    longest = 0
    shortest = typemax(Int)
    @inbounds for i in eachindex(seq.data)
        base = CPG_LUT[seq.data[i]+1]
        if lastbase | base == 0x03
            ncpg += run == 1
            run += 1
            longest = max(longest, run)
            shortest = min(shortest, run)
        else
            run = 1
        end
        lastbase = base
    end
    shortest = ifelse(shortest == typemax(Int), 0, shortest)
    return ncpg, shortest, longest
end


function main(arg)
    f = open(arg)
    ncpg = 0
    Sh = typemax(Int)
    Ln = 0
    seq = Seq()
    for l in eachline(f)
        copy!(seq, l)
        n, sh, ln = cpg(seq)
        Sh = min(sh, Sh)
        Ln = max(ln, Ln)
        ncpg += n
    end
    close(f)
    println("$ncpg $Sh $Ln")
end

main(ARGS[1])
