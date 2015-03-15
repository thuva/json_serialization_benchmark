# Benchmarking common (and not so common) Ruby JSON Serializers

This grew out of [a blog post](http://techblog.thescore.com/benchmarking-json-generation-in-ruby/), which wisely pointed that it's not all about the numbers in a benchmark: feature sets, maintainability and extensibility all must be weighed. If an app already has an approach, then the marginal effort of switching to a new approach should be weighed against the benefits.

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
