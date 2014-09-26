#!/usr/bin/env ruby

# file: jsonx.rb

require 'json'
require 'rexle'


class JSONx

  attr_reader :to_s

  def initialize(obj)
    
    h = obj.is_a?(String) ? JSON.parse(obj) : obj

    types = {
      Hash:     ->(k, h){
        type = 'json:object'
        [type, '', (k.empty? ? {} : {name: k}), 
          *h.map {|k2,v| types[v.class.to_s.to_sym].call(k2, v)}
        ]
      },
      Fixnum:   ->(k, n){ ['json:number', n, k.empty? ? {} : {name: k}]},
      NilClass: ->(k, n){ ['json:null',  '', k.empty? ? {} : {name: k}]},
      String:   ->(k, s){ ['json:string', s, k.empty? ? {} : {name: k}]},
      Array:    ->(k, a){ 
        ['json:array', '', {name: k}, 
          *a.map{|y| types[y.class.to_s.to_sym].call('', y.to_s)}
        ]
      }
    }

    a =  types[:Hash].call '', h
    a[2] = {'xsi:schemaLocation' => "http://www.datapower.com/schemas/json jsonx.xsd",
    'xmlns:xsi' => "http://www.w3.org/2001/XMLSchema-instance",
    'xmlns:json' => "http://www.ibm.com/xmlns/prod/2009/jsonx"}
    @to_s = Rexle.new(a).xml pretty: true
  end

end

if __FILE__ == $0 then

  JSONx.new(ARGV[0]).to_s

end