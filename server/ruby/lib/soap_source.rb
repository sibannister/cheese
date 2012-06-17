require 'savon' 

class SoapSource
  def read start_date, channels
    Savon.configure { |config| config.log = false }

    sources = channels.map {|channel| '<SourceId>' + channel.code.to_s + '</SourceId>'}.join('')
    
    client = Savon::Client.new do
      wsdl.namespace = "http://services.macrovision.com/v9/common/types"
      wsdl.endpoint = "http://api.rovicorp.com/v9/listingsservice.asmx?apikey=4eb3ss7uuq43s42uhvrj46mp"
    end

    response = client.request :typ, "GetGridSchedule"  do
      http.headers["SOAPAction"] = "http://services.macrovision.com/v9/listings/GetGridSchedule"

      soap.input = [ 
        "GetGridSchedule", 
        {"xmlns" => "http://services.macrovision.com/v9/listings"}
      ]
      soap.header = {"typ:AuthHeader" => { "typ:UserName" => "spencerward4eb3ss7uuq43s42uhvrj46mp", 
        "typ:Password" => "eec71e29-2b15-4331-bfd4-1673e36dd6f4" } }
      soap.body = 
        '<request>' +
        '<Locale>en-GB</Locale>' +
        '<ServiceId>891296</ServiceId>' +
        '<StartDate>' + start_date.xmlschema + '</StartDate>' +
        '<Duration>240</Duration>' +
        '<SourceFilter>' +
        '<Sources>' + sources + '</Sources>' +
        '</SourceFilter>' +
        '</request>'

      puts soap.body
    end
    
    puts response.to_xml.to_s
    response.to_xml
  end
end

