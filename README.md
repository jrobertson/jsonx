# Introducing the JSONx gem

    require 'jsonx'

    h = {f100: 'fff', g100: 'ggg', n100: nil, a100: [3, 5], h100: {y100: 'yyy'}}
    puts JSONx.new(h).to_s

<pre>
&lt;?xml version='1.0' encoding='UTF-8'?&gt;
&lt;json:object xsi:schemaLocation='http://www.datapower.com/schemas/json jsonx.xsd' xmlns:xsi='http://www.w3.org/2001/XMLSchema-instance' xmlns:json='http://www.ibm.com/xmlns/prod/2009/jsonx'&gt;
  &lt;json:string name='f100'&gt;fff&lt;/json:string&gt;
  &lt;json:string name='g100'&gt;ggg&lt;/json:string&gt;
  &lt;json:null name='n100'&gt;&lt;/json:null&gt;
  &lt;json:array name='a100'&gt;
    &lt;json:number&gt;3&lt;/json:number&gt;
    &lt;json:number&gt;5&lt;/json:number&gt;
  &lt;/json:array&gt;
  &lt;json:object name='h100'&gt;
    &lt;json:string name='y100'&gt;yyy&lt;/json:string&gt;
  &lt;/json:object&gt;
&lt;/json:object&gt;
</pre>

## Resources

* [jsonx](https://rubygems.org/gems/jsonx)
* [JSONx](http://pic.dhe.ibm.com/infocenter/wsdatap/v6r0m0/index.jsp?topic=%2Fcom.ibm.dp.xm.doc%2Fjson_jsonx.html)
* [JSONx conversion example](http://pic.dhe.ibm.com/infocenter/wsdatap/v6r0m0/topic/com.ibm.dp.xm.doc/json_jsonxconversionexample.html)

jsonx gem json xml
