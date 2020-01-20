using BioSequences

function cpg(seq)
   lastbase = 0x00
   run = 1
   ncpg = 0
   longest = 0
   shortest = typemax(Int)
   @inbounds for i in eachindex(seq)
      base = seq[i]
      iscpg = ifelse(base == DNA_C, lastbase == DNA_G, ifelse(base == DNA_G, lastbase == DNA_C, false))
      if iscpg
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
   seq = dna""
   for l in eachline(f)
      seq = copy!(seq, l)
      n, sh, ln = cpg(seq)
      Sh = min(sh, Sh)
      Ln = max(ln, Ln)
      ncpg += n
   end
   close(f)
   println("$ncpg $Sh $Ln")
end

main(ARGS[1])
