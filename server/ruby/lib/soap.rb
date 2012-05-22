require 'savon'

client = Savon::Client.new do
  wsdl.namespace = "http://api.rovicorp.com/v9/listings"
  wsdl.endpoint = "http://api.rovicorp.com/v9/listingsservice.asmx&apikey=4eb3ss7uuq43s42uhvrj46mp"
end


client.request "GetServices" do
  soap.header = {"ins1:AuthHeader" => { "ins1:UserName" => "spencerward4eb3ss7uuq43s42uhvrj46mp", 
    "ins1:Password" => "eec71e29-2b15-4331-bfd4-1673e36dd6f4" } }
  soap.body = '<ins0:request>' +
           '<ins0:Locale>en-US</ins0:Locale>' +
           '<ins0:ServiceSearch>' +
            '<ins0:PostalCode>90210</ins0:PostalCode>' +
             '<ins0:CountryCode>US</ins0:CountryCode>' +
             '</ins0:ServiceSearch>            ' +
            '<ins0:StartDate xsi:nil="true" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"/>' +
            '<ins0:Duration>263520</ins0:Duration>' +
            '</ins0:request>'
end

