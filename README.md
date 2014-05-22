# RABL vs. ActiveModel Serializers vs. Plain Ruby Presenters

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
