# Introducing the JSONx gem

    require 'jsonx'

    h = {f100: 'fff', g100: 'ggg', n100: nil, a100: [3, 5], h100: {y100: 'yyy'}}
    puts JSONx.new(h).to_s

<pre>
<?xml version='1.0' encoding='UTF-8'?>
<json:object xsi:schemaLocation='http://www.datapower.com/schemas/json jsonx.xsd'
 xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' 
xmlns:json='http://www.ibm.com/xmlns/prod/2009/jsonx'>
  <json:string name='f100'>fff</json:string>
  <json:string name='g100'>ggg</json:string>
  <json:null name='n100'></json:null>
  <json:array name='a100'>
    <json:number>3</json:number>
    <json:number>5</json:number>
  </json:array>
  <json:object name='h100'>
    <json:string name='y100'>yyy</json:string>
  </json:object>
</json:object>
</pre>

## Resources

* [jsonx](https://rubygems.org/gems/jsonx)
* [JSONx](http://pic.dhe.ibm.com/infocenter/wsdatap/v6r0m0/index.jsp?topic=%2Fcom.ibm.dp.xm.doc%2Fjson_jsonx.html)
* [JSONx conversion example](http://pic.dhe.ibm.com/infocenter/wsdatap/v6r0m0/topic/com.ibm.dp.xm.doc/json_jsonxconversionexample.html)

jsonx gem json xml
