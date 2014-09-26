#!/usr/bin/env ruby

# file: jsonx.rb

require 'rexle'


class JSONx

  attr_reader :to_s

  def initialize()

    types = {
      Hash:     ->(x, k, h){
        type = 'json:object'
        [type, '', {name: k}, 
          *h.map {|k,v| types[v.class.to_s.to_sym].call(x, k, v)}
        ]
      },
      Fixnum:   ->(x, k, n){ ['json:number', n, {name: k}]},
      NilClass: ->(x, k, n){ ['json:null',  '', {name: k}]},
      String:   ->(x, k, s){ ['json:string', s, {name: k}]},
      Array:    ->(x, k, a){ 
        ['json:array', '', {name: k}, 
          *a.map{|y| p y; types[y.class.to_s.to_sym].call(x, k, y)}
        ]
      }
    }

    a =  types[:Hash].call xml, '', h
    @to_s Rexle.new(a).xml pretty: true
  end

end

if __FILE__ == $0 then

  JSONx.new(ARGV[0]).to_s

end
