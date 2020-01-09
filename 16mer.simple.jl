dir = dirname(dirname(@__FILE__))
push!(LOAD_PATH, dir)

using SeqJL

function process(s)
   length(s)
end

function is_sym(k)
   return k == reverse_complement(k)
end

function main(arg)
   f = open(arg)
   t1, t2, t3 = 0, 0, 0
   for l in eachline(f)
      s = Seq(l)
      k = 16
      for (_, codon) in kmers(s, Val(k))
         t1 += process(codon)
         t3 += is_sym(codon)
         t2 += 1
      end
   end
   println("$t1  $t2  $t3")
end

main(ARGS[1])
