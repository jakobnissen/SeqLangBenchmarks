# Seq language benchmarks

This is a code repository for an (as of 2019-01-20), upcoming blog post about the Seq language versus BioJulia.

### Description of files
* `\*.bio.id.jl`: Idiomatic code for BioSequences v1.1 benchmark
* `\*.bio.new.jl`: Idiomatic code for BioSequences v2.1 benchmark
* `\*.bio.simple.jl`: Code for SeqJL benchmark
* `SeqJL.jl`: SeqJL module.

### Benchmarks
* `Seq BioSequences`: The [BioJulia code used by the Seq authors in their paper.](https://github.com/seq-lang/benchmarks/tree/master/paper/idiomatic)
* `BioSequences v1.1`: As we would write Julia code using BioSequences v1.1.
* `BioSequences v2.1`: Using the upcoming version of BioSequences with performance improvements.
* `Seq`: Using the idiomatic Seq code provided by Seq authors
* `SeqJL.jl`: Our base Julia implementation of Seq-like datatypes

Shown is mean number of seconds across 5 runs of processing 2^24 lines of 76 bp random DNA sequences.
```
Benchmark: 16-mer
Language           Rel  Abs   µs/seq
Seq BioSequences   3.0  33.5  1.99  
BioSequences v1.1  3.1  34.2  2.04  
BioSequences v2.1  0.9  10.0  0.59  
Seq                1.0  11.1  0.66  
SeqJL.jl           0.4  4.6   0.27  

Benchmark: CpG
Language           Rel  Abs   µs/seq
Seq BioSequences   3.9  35.1  2.09  
BioSequences v1.1  3.6  32.3  1.92  
BioSequences v2.1  1.0  9.4   0.56  
Seq                1.0  9.1   0.54  
SeqJL.jl           0.3  3.1   0.18  

Benchmark: RC
Language           Rel  Abs   µs/seq
Seq BioSequences   9.1  47.8  2.85  
BioSequences v1.1  8.5  45.0  2.68  
BioSequences v2.1  1.9  10.3  0.61  
Seq                1.0  5.3   0.31  
SeqJL.jl           1.0  5.3   0.31  
```  
