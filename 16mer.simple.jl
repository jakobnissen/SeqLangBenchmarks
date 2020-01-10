dir = dirname(dirname(@__FILE__))
push!(LOAD_PATH, dir)

using SeqJL

is_sym(k) = k == reverse_complement(k)

function main(arg)
   f = open(arg)
   t1, t2, t3 = 0, 0, 0
   for l in eachline(f)
      s = Seq(l)
      k = 16
      for kmer in kmers(s, Val(k))
         t1 += length(kmer)
         t3 += is_sym(kmer)
         t2 += 1
      end
   end
   println("$t1  $t2  $t3")
end

main(ARGS[1])
