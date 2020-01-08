module SeqJL

const RC_LUT = let
   bytes = fill(UInt8('N'), 256)
   @inbounds for (i, j) in zip("-ACMGRSVTWYHKDBN", "-TGKCYSBAWRDMHVN")
      bytes[UInt8(i) + 1] = UInt8(j)
   end
   Tuple(bytes)
end

struct Seq
   data::Vector{UInt8}
end
Seq(s::String) = Seq(Vector{UInt8}(s))

function complement!(x::Seq)
   @inbounds for i in eachindex(x.data)
      x.data[i] = RC_LUT[x.data[i] + 1]
   end
   x
end
Base.reverse!(x::Seq) = (reverse!(x.data); x)
reverse_complement!(x::Seq) = reverse!(complement!(x))
Base.length(x::Seq) = length(x.data)
Base.eachindex(x::Seq) = eachindex(x.data)
Base.String(x::Seq) = String(copy(x.data))

function Base.getindex(x::Seq, i::Int)
   @boundscheck checkbounds(x.data, i)
   @inbounds x.data[i]
end

struct Kmer{K}
   x::UInt64
end

function reverse(m::Kmer{K}) where K
   x = m.x
   x = (x & 0x3333333333333333) <<  2 | (x & 0xCCCCCCCCCCCCCCCC) >>  2
   x = (x & 0x0F0F0F0F0F0F0F0F) <<  4 | (x & 0xF0F0F0F0F0F0F0F0) >>  4
   x = bswap(x)
   return Kmer{K}(x >> unsigned(64 - 2K))
end
complement(x::Kmer) = typeof(x)(~x.x)
reverse_complement(x::Kmer) = reverse(complement(x))
Base.length(::Kmer{K}) where K = K
mask(K) = UInt64(1 << 2K - 1)

struct KmerIterator{K}
   seq::Seq
end

kmers(s::Seq, ::Val{K}) where K = KmerIterator{K}(s)
Base.IteratorEltype(::Type{KmerIterator{K}}) where K = Base.HasEltype()
Base.eltype(::Type{KmerIterator{K}}) where K = Tuple{Int, Kmer{K}}

const KMER_LUT = let
   bytes = fill(0xff, 256)
   @inbounds for (char, val) in zip("ACGT", [0, 1, 2, 3])
      bytes[UInt8(char)+1] = val
      bytes[UInt8(lowercase(char))+1] = val
   end
   Tuple(bytes)
end

function Base.iterate(x::KmerIterator{K}, (pos, kmer, filled)=(1, typemin(UInt), 0)) where K
   @inbounds while pos ≤ length(x.seq.data)
      filled += 1
      byte = x.seq.data[pos]
      val = KMER_LUT[byte + 1]
      kmer = kmer << 2 | val
      if val == 0xff
         filled = 0
      end
      pos += 1
      if filled == K
         return ((pos-K, Kmer{K}(kmer & mask(K))), (pos, kmer, min(K-1, filled)))
      end
   end
   return nothing
end

export Seq, Kmer, reverse_complement, reverse_complement!, kmers

end # module
