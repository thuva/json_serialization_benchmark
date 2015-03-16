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
RABL 0.11.6 Ultra Simple: Member           1.790659                97         6969
AMS 0.9.3 Ultra Simple: Member             0.575352                65         1995
Presenters Ultra Simple: Member            0.189294                26          930
ApiView Ultra Simple: Member               0.193702                12          842
Jbuilder 2.2.11 Ultra Simple: Member       2.935206               181         8640
-----------------------------------------------------------------------------------
RABL 0.11.6 Simple: Member                10.916639               533        44241
AMS 0.9.3 Simple: Member                   1.751082               165         5437
Presenters Simple: Member                  0.769148               100         3492
ApiView Simple: Member                     0.309702                15         1862
Jbuilder 2.2.11 Simple: Member             8.930129               464        27536
-----------------------------------------------------------------------------------
RABL 0.11.6 Complex: Member               23.028273              1129       101977
AMS 0.9.3 Complex: Member                  3.432730               326        11085
Presenters Complex: Member                 1.822263               203         8454
ApiView Complex: Member                    0.447377                17         3667
Jbuilder 2.2.11 Complex: Member           17.234950               829        52404


Collection tests:

                                                real       allocations      memsize
RABL 0.11.6 Ultra Simple: Collection        1.682465              7654       648077
AMS 0.9.3 Ultra Simple: Collection          0.484903              3630       130055
Presenters Ultra Simple: Collection         0.017488               303        27594
ApiView Ultra Simple: Collection            0.035248               112        46986
Jbuilder 2.2.11 Ultra Simple: Collection    1.575983              6433       517065
------------------------------------------------------------------------------------
RABL 0.11.6 Simple: Collection             10.754574             50958      4364195
AMS 0.9.3 Simple: Collection                1.184653              7530       358455
Presenters Simple: Collection               0.131570              1603       167994
ApiView Simple: Collection                  0.130317               610       148986
Jbuilder 2.2.11 Ultra Simple: Collection   12.160535             61353      4277513
------------------------------------------------------------------------------------
RABL 0.11.6 Complex: Collection            21.628849            109766     10158764
AMS 0.9.3 Complex: Collection               2.110718             14630       742755
Presenters Complex: Collection              0.324508              2903       483694
ApiView Complex: Collection                 0.317623               810       329486
Jbuilder 2.2.11 Ultra Simple: Collection   13.338282             68659      4765953
```

## Extending

Data for the benchmarks is stored in [lib/models](lib/models).

## Furtherwork
* Switch out bixby-bench for benchmark-ips w/ allocation stats to get standard deviation.
