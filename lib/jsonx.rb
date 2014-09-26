#!/usr/bin/env ruby

# file: jsonx.rb

require 'json'
require 'rexle'


class JSONx

  attr_reader :to_s, :to_json

  def initialize(obj)
    
    if obj.is_a?(String) then
      
      if obj.lstrip[0] == '<' then
        jsonx_to_json obj
      else
        json_to_jsonx JSON.parse(obj)
      end
      
    else
      json_to_jsonx obj # transform the hash
    end


  end
  
  def json_to_jsonx(h)
    types = {
      Hash:     ->(k, h){
        type = 'json:object'
        [type, '', (k.empty? ? {} : {name: k}), 
          *h.map {|k2,v| types[v.class.to_s.to_sym].call(k2, v)}
        ]
      },
      FalseClass: ->(k, b){ ['json:boolean', 
                                b.to_s, k.empty? ? {} : {name: k}]},
      TrueClass:  ->(k, b){ ['json:boolean', 
                                b.to_s, k.empty? ? {} : {name: k}]},
      Fixnum:     ->(k, n){ ['json:number', n, k.empty? ? {} : {name: k}]},
      NilClass:   ->(k, n){ ['json:null',  '', k.empty? ? {} : {name: k}]},
      String:     ->(k, s){ ['json:string', s, k.empty? ? {} : {name: k}]},
      Array:      ->(k, a){ 
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
  
  def jsonx_to_json(xml)

    doc = Rexle.new xml

    types = {
      boolean: ->(e){ e.text.downcase == 'true' },
      string: ->(e){e.text},
      null: ->(e){nil},
      number: ->(e){ s = e.text; s.to_i == s.to_f ? s.to_i : s.to_f},
      array: ->(e){
        e.elements.map {|x| types[x.name[/\w+$/].to_sym].call x }
      },
      object: ->(e){
        e.elements.inject({}) do |r, x| 
          name = x.name[/\w+$/]
          r.merge(x.attributes[:name] => types[name.to_sym].call(x))
        end
      }
    }
    @to_json = types[:object].call doc.root
    
  end
  

end

if __FILE__ == $0 then

  JSONx.new(ARGV[0]).to_s

end