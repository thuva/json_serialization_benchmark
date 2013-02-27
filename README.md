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

The results of a sample benchmark run is available
[here](https://gist.github.com/thuva/123b3282a37302c25be1)
