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
  
  alias to_jsonx to_s
  alias to_xml to_s

  private
  
  def json_to_jsonx(h)
    
    types = {
      
            Hash:  ->(k, h) {
        type = 'json:object'
        [type, (k.empty? ? {} : {name: k}), '',
          *h.map {|k2,v| types[v.class.to_s.to_sym].call(k2, v)}
        ]
      },
      FalseClass: ->(k, b){ ['json:boolean', 
                                k.empty? ? {} : {name: k}, b.to_s ]},
       TrueClass: ->(k, b){ ['json:boolean', 
                                k.empty? ? {} : {name: k}, b.to_s]},
         Integer: ->(k, n){ ['json:number', k.empty? ? {} : {name: k}, n]},
          Fixnum: ->(k, n){ ['json:number', k.empty? ? {} : {name: k}, n]},
           Float: ->(k, n){ ['json:number', k.empty? ? {} : {name: k}, n]},
        NilClass: ->(k, n){ ['json:null',  k.empty? ? {} : {name: k}, '']},
          String: ->(k, s){ ['json:string', k.empty? ? {} : {name: k}, s]},
           Array: ->(k, a){ 
        ['json:array', {name: k}, '', 
          *a.map{|y| types[y.class.to_s.to_sym].call('', y)}
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
       string: ->(e){ e.text },
         null: ->(e){ nil },
       number: ->(e){ s = e.text; s.to_i == s.to_f ? s.to_i : s.to_f},
        array: ->(e){
        e.elements.map {|x| types[x.name[/\w+$/].to_sym].call x }
      },
       object: ->(e){
        e.elements.inject({}) do |r, x| 
          r.merge(x.attributes[:name] => types[x.name[/\w+$/].to_sym].call(x))
        end
      }
    }
    
    @to_json = types[:object].call(doc.root).to_json
    
  end
  

end

if __FILE__ == $0 then

  JSONx.new(ARGV[0]).to_s

end
