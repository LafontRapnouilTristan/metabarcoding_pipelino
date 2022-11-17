# Benchmark
rule benchmark:
  input:
    "benchmarks/{run}/"
  output:
    report("benchmarks/{run}/{run}_benchmark.png")
  log:
    "log/{run}_benchmark.log"
  conda:
    "../envs/R_env.yaml"
  script:
    "../scripts/benchmark.R"