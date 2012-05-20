require 'savon'

client = Savon::Client.new do
  wsdl.document = "http://api.rovicorp.com/v9/listingsservice.asmx?WSDL&apikey=4eb3ss7uuq43s42uhvrj46mp"
end

client.request "GetServices" do
  soap.header = {"AuthHeader" => { "UserName" => "spencerward", "Password" => "atheistr1" } }
end

