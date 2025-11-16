# encoding: utf-8

##
# This file is auto-generated. DO NOT EDIT!
#
require 'protobuf'

module Prometheus
  ::Protobuf::Optionable.inject(self) { ::Google::Protobuf::FileOptions }

  ##
  # Message Classes
  #
  class WriteRequest < ::Protobuf::Message; end
  class ReadRequest < ::Protobuf::Message; end
  class ReadResponse < ::Protobuf::Message; end
  class Query < ::Protobuf::Message; end
  class QueryResult < ::Protobuf::Message; end
  class Label < ::Protobuf::Message; end
  class Sample < ::Protobuf::Message; end
  class TimeSeries < ::Protobuf::Message; end
  class Labels < ::Protobuf::Message; end
  class LabelMatcher < ::Protobuf::Message
    class Type < ::Protobuf::Enum
      define :EQ, 0
      define :NEQ, 1
      define :RE, 2
      define :NRE, 3
    end

  end

  class ReadHints < ::Protobuf::Message; end


  ##
  # File Options
  #
  set_option :go_package, "prompb"


  ##
  # Message Fields
  #
  class WriteRequest
    repeated ::Prometheus::TimeSeries, :timeseries, 1
  end

  class ReadRequest
    repeated ::Prometheus::Query, :queries, 1
  end

  class ReadResponse
    repeated ::Prometheus::QueryResult, :results, 1
  end

  class Query
    optional :int64, :start_timestamp_ms, 1
    optional :int64, :end_timestamp_ms, 2
    repeated ::Prometheus::LabelMatcher, :matchers, 3
    optional ::Prometheus::ReadHints, :hints, 4
  end

  class QueryResult
    repeated ::Prometheus::TimeSeries, :timeseries, 1
  end

  class Label
    optional :string, :name, 1
    optional :string, :value, 2
  end

  class Sample
    optional :double, :value, 1
    optional :int64, :timestamp, 2
  end

  class TimeSeries
    repeated ::Prometheus::Label, :labels, 1
    repeated ::Prometheus::Sample, :samples, 2
  end

  class Labels
    repeated ::Prometheus::Label, :labels, 1
  end

  class LabelMatcher
    optional ::Prometheus::LabelMatcher::Type, :type, 1
    optional :string, :name, 2
    optional :string, :value, 3
  end

  class ReadHints
    optional :int64, :step_ms, 1
    optional :string, :func, 2
    optional :int64, :start_ms, 3
    optional :int64, :end_ms, 4
  end

end

