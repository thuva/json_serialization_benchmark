# Benchmarking common (and not so common) Ruby JSON Serializers

This grew out of [a blog post](http://techblog.thescore.com/benchmarking-json-generation-in-ruby/), which wisely pointed that it's not all about the numbers in a benchmark: feature sets, maintainability and extensibility all must be weighed. If an app already has an approach, then the marginal effort of switching to a new approach should be weighed against the benefits. [Beauty is in the eye of the beholder](http://en.wikipedia.org/wiki/Lies,_damned_lies,_and_statistics).

The serializers measured include:
* [RABL](https://github.com/nesquena/rabl/)
* [ActiveModel Serializers](https://github.com/rails-api/active_model_serializers)
* Plain Ruby presenters
* [apiview](https://github.com/mindreframer/api_view) (a serializer by [chetan](https://github.com/chetan), [for comparison to other solutions](https://github.com/chetan/json_serialization_benchmark/tree/api_view/lib/api_view))
* [JBuilder](https://github.com/rails/jbuilder) (some trickery to get jbuilder rendering was drawn from [kirillplatonov's work](https://github.com/kirillplatonov/blog_content/blob/master/ams_vs_jbuilder/lib/tasks/benchmarks.rake))

## Setup

1. Clone the repo

        git clone git@github.com:phillbaker/json-serialization-benchmark.git

2. Change directory to json-serialization-benchmark

        cd json-serialization-benchmark

3. Install required gems

        bundle install

## Usage

* Run the benchmarks

        bundle exec ruby benchmark.rb

## Results

(Condensed to not show user, system, or total timings, run the benchmarks to see them.)

```
Using Ruby version: 2.1.5-p273


Member tests:

                                                real       allocations      memsize
RABL 0.11.6 Ultra Simple: Member            1.660713                96         6777
AMS 0.8.1 Ultra Simple: Member              0.256485                26          650
Presenters Ultra Simple: Member             0.202106                24          650
ApiView Ultra Simple: Member                0.148704                12          842
Jbuilder 2.2.11 Ultra Simple: Member        2.673416               181         8640
------------------------------------------------------------------------------------
RABL 0.11.6 Simple: Member                 10.926647               532        44049
AMS 0.8.1 Simple: Member                    1.702242               105         2726
Presenters Simple: Member                   0.617263                98         2918
ApiView Simple: Member                      0.362970                15         1862
Jbuilder 2.2.11 Simple: Member              9.511615               464        27536
------------------------------------------------------------------------------------
RABL 0.11.6 Complex: Member                22.996604              1128       101785
AMS 0.8.1 Complex: Member                   3.018892               209         5851
Presenters Complex: Member                  1.951265               201         7395
ApiView Complex: Member                     0.553835                17         3667
Jbuilder 2.2.11 Complex: Member            16.051573               829        52404


Collection tests:

                                                real       allocations      memsize
RABL 0.11.6 Ultra Simple: Collection        1.542945              7658       647885
AMS 0.8.1 Ultra Simple: Collection          0.163877              1914        47786
Presenters Ultra Simple: Collection         0.129554              3508        67594
ApiView Ultra Simple: Collection            0.027478               112        46986
Jbuilder 2.2.11 Ultra Simple: Collection    1.399595              6433       517065
-------------------------------------------------------------------------------------
RABL 0.11.6 Simple: Collection             10.112471             50962      4364003
AMS 0.8.1 Simple: Collection                1.445987              9714       236186
Presenters Simple: Collection               0.756828             16108       380794
ApiView Simple: Collection                  0.165724               610       148986
Jbuilder 2.2.11 Ultra Simple: Collection   12.456138             61353      4277513
-------------------------------------------------------------------------------------
RABL 0.11.6 Complex: Collection            23.481465            109770     10158572
AMS 0.8.1 Complex: Collection               2.790749             20114       548686
Presenters Complex: Collection              1.791040             34408       960494
ApiView Complex: Collection                 0.355639               810       329486
Jbuilder 2.2.11 Ultra Simple: Collection   14.026351             68659      4765953
```

## Extending

Data for the benchmarks is stored in [lib/models](lib/models).

## Furtherwork
* Switch out bixby-bench for benchmark-ips w/ allocation stats to get standard deviation.
