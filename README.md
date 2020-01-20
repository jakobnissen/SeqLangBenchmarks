# Seq language benchmarks

This is a code repository for an (as of 2019-01-20), upcoming blog post about the Seq language versus BioJulia.

### Description of files
* `\*.bio.id.jl`: Idiomatic code for BioSequences v1.1 benchmark
* `\*.bio.new.jl`: Idiomatic code for BioSequences v2.1 benchmark
* `\*.bio.simple.jl`: Code for SeqJL benchmark
* `SeqJL.jl`: Entire SeqJL module.

### Benchmarks
* `Seq BioSequences`: The [BioJulia code used by the Seq authors in their paper.](https://github.com/seq-lang/benchmarks/tree/master/paper/idiomatic)
* `BioSequences v1.1`: As we would write Julia code using BioSequences v1.1.
* `BioSequences v2.1`: Using the upcoming version of BioJulia with performance improvements.
* `Seq`: Using the idiomatic Seq code provided by Seq authors
* `Julia SeqJL.jl`: Our Julia implementation of Seq-like datatypes

Shown is mean number of seconds across 5 runs of processing 2^24 lines of 76 bp random DNA sequences.
```
Benchmark: 16-mer
Language           Rel  Abs
Seq BioSequences   3.0  33.5
BioSequences v1.1  3.1  34.2
BioSequences v2.1  0.9  10.0
Seq                1.0  11.1
Julia SeqJL.jl     0.4   4.6  

Benchmark: CpG
Language           Rel  Abs
Seq BioSequences   3.9  35.1
BioSequences v1.1  3.6  32.3
BioSequences v2.1  1.0   9.4  
Seq                1.0   9.1  
Julia SeqJL.jl     0.3   3.1  

Benchmark: RC
Language           Rel  Abs
Seq BioSequences   9.1  47.8
BioSequences v1.1  8.5  45.0
BioSequences v2.1  1.9  10.3
Seq                1.0   5.3  
Julia SeqJL.jl     1.0   5.3  
```  
