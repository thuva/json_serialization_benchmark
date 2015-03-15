# Benchmarking common (and not so common) Ruby JSON Serializers

This grew out of [a blog post](http://techblog.thescore.com/benchmarking-json-generation-in-ruby/), which wisely pointed that it's not all about the numbers in a benchmark: feature sets, maintainability and extensibility all must be weighed. If an app already has an approach, then the marginal effort of switching to a new approach should be weighed against the benefits. [Beauty is in the eye of the beholder](http://en.wikipedia.org/wiki/Lies,_damned_lies,_and_statistics).

The serializers measured include:
* [RABL](https://github.com/nesquena/rabl/)
* [ActiveModel Serializers](https://github.com/rails-api/active_model_serializers)
* Plain Ruby presenters
* [apiview](https://github.com/mindreframer/api_view) (a serializer by [chetan](https://github.com/chetan), [for comparison to other solutions](https://github.com/chetan/json_serialization_benchmark/tree/api_view/lib/api_view))
* [JBuilder](https://github.com/rails/jbuilder)

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

(Only showing real time):

```
Using Ruby version: 2.1.5-p273


Member tests:

                                                real      allocations      memsize
RABL 0.9.3 Ultra Simple                     1.735658               89         6801
AMS 0.8.1 Ultra Simple                      0.369409               26          650
Presenters Ultra Simple                     0.162508               24          650
ApiView Ultra Simple                        0.162315               12          842
-----------------------------------------------------------------------------------
RABL 0.9.3 Simple                          10.937403              503        43569
AMS 0.8.1 Simple                            1.471106              105         2726
Presenters Simple                           0.752444               98         2918
ApiView Simple                              0.344884               15         1862
-----------------------------------------------------------------------------------
RABL 0.9.3 Complex                         21.713861             1080       100953
AMS 0.8.1 Complex                           3.018386              209         5851
Presenters Complex                          1.486575              201         7395
ApiView Complex                             0.495160               17         3667


Collection tests:

                                                real      allocations      memsize
RABL 0.9.3 Ultra Simple: Collection         1.377958             6788       619869
AMS 0.8.1 Ultra Simple: Collection          0.227806             1914        47786
Presenters Ultra Simple: Collection         0.131572             3508        67594
ApiView Ultra Simple: Collection            0.026567              112        46986
-----------------------------------------------------------------------------------
RABL 0.9.3 Simple: Collection               9.057806            47991      4285587
AMS 0.8.1 Simple: Collection                1.544582             9714       236186
Presenters Simple: Collection               0.738036            16108       380794
ApiView Simple: Collection                  0.118144              610       148986
-----------------------------------------------------------------------------------
RABL 0.9.3 Complex: Collection             21.018691           104800     10044956
AMS 0.8.1 Complex: Collection               3.428050            20114       548686
Presenters Complex: Collection              1.934186            34408       960494
ApiView Complex: Collection                 0.304686              810       329486
```

## Extending

Data for the benchmarks is stored in [lib/models](lib/models).

