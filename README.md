# RABL vs. ActiveModel Serializers vs. Presenters

Performance benchmark of RABL, ActiveModel Serializers, and plain Ruby
presenters for JSON serialization.

## Setup

1. Clone the repo

        git clone git@github.com:scoremedia/json-serialization-benchmark.git

2. Change directory to json-serialization-benchmark

        cd json-serialization-benchmark

3. Install required gems

        bundle install

## Usage

* Run the benchmarks

        bundle exec ruby benchmark.rb

## Results

First of all, the performance of plain Ruby presenters and ActiveModel
Serializers (AMS) is about the same. This is not much of a surprise
since AMS is a very thin abstraction (and DSL) on top of regular Ruby
object model.

On the other hand, RABL is about 4 times slower compared to AMS. However,
if you turn on template lookup caching for RABL (`config.cache_sources = true`),
the performance doubles. As a result, it's only twice as slower compared
to AMS.

The detailed results of a sample benchmark run is available
[here](https://gist.github.com/thuva/123b3282a37302c25be1)
