using BioSequences

function process(s)
   length(s)
end

function is_sym(k)
   return k == reverse_complement(k)
end

function main(arg)
   f = open(arg)
   t1, t2, t3 = 0, 0, 0
   seq = dna""
   for l in eachline(f)
      copy!(seq, l)
      for mer in each(DNAMer{16}, seq)
         t1 += process(mer.fw)
         t2 += 1
         t3 += is_sym(mer.fw)
      end
   end
   println("$t1 $t2 $t3")
end

main(ARGS[1])
