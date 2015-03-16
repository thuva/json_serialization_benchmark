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

                                               real      allocations      memsize
RABL 0.9.3 Ultra Simple: Member            1.942870               89         6801
AMS 0.8.1 Ultra Simple: Member             0.257143               26          650
Presenters Ultra Simple: Member            0.156714               24          650
ApiView Ultra Simple: Member               0.181024               12          842
Jbuilder 2.2.11 Ultra Simple: Member       3.340908              181         8640
-----------------------------------------------------------------------------------
RABL 0.9.3 Simple: Member                111.432498              503        43569
AMS 0.8.1 Simple: Member                   1.388026              105         2726
Presenters Simple: Member                  0.728749               98         2918
ApiView Simple: Member                     0.308433               15         1862
Jbuilder 2.2.11 Simple: Member             9.622516              464        27536
-----------------------------------------------------------------------------------
RABL 0.9.3 Complex: Member               223.439803             1079       100953
AMS 0.8.1 Complex: Member                  3.025917              209         5851
Presenters Complex: Member                 1.712620              201         7395
ApiView Complex: Member                    0.525296               17         3667
Jbuilder 2.2.11 Complex: Member          116.529994              829        52404


Collection tests:

                                                real      allocations      memsize
RABL 0.9.3 Ultra Simple: Collection         1.718125             6788       619869
AMS 0.8.1 Ultra Simple: Collection          0.181958             1914        47786
Presenters Ultra Simple: Collection         0.131301             3508        67594
ApiView Ultra Simple: Collection            0.045919              112        46986
Jbuilder 2.2.11 Ultra Simple: Collection    1.339586             6433       517065
-----------------------------------------------------------------------------------
RABL 0.9.3 Simple: Collection               9.714368            47991      4285587
AMS 0.8.1 Simple: Collection                1.171377             9714       236186
Presenters Simple: Collection               0.715395            16108       380794
ApiView Simple: Collection                  0.121223              610       148986
Jbuilder 2.2.11 Ultra Simple: Collection  112.021925            61353      4277513
-----------------------------------------------------------------------------------
RABL 0.9.3 Complex: Collection            221.352403           104799     10044956
AMS 0.8.1 Complex: Collection               2.527508            20114       548686
Presenters Complex: Collection              1.725166            34408       960494
ApiView Complex: Collection                 0.295662              810       329486
Jbuilder 2.2.11 Ultra Simple: Collection  113.617486            68659      4765953
```

## Extending

Data for the benchmarks is stored in [lib/models](lib/models).

## Furtherwork
* Switch out bixby-bench for benchmark-ips w/ allocation stats to get standard deviation.
