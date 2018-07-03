require 'json'
require 'net/http'
require 'time'
namespace :db do
	namespace :meteorological do
	desc "update meteorological info from city"
	task :update => :environment do
		# step1 抓到網址資料
        resp = Net::HTTP.get_response(URI.parse('http://opendata.cwb.gov.tw/govdownload?dataid=F-C0032-005&authorizationkey=rdec-key-123-45678-011121314')).body
        # step2 將抓到的XML資料轉換成hash
        result = Hash.from_xml(resp)
        # step3 將資料做整理，整理成一筆一筆寫入我們自己的資料表
        result["cwbopendata"]["dataset"]["location"].each do |data|
        	data["weatherElement"].each do |element|
        		element["time"].each do |time|
                    #判斷是不是天氣狀況，是的話parameter_value給parameterValue，不是的話給parameterUnit
        			if element["elementName"] == "Wx"
        				value = time["parameter"]["parameterValue"]
        			else
        				value = time["parameter"]["parameterUnit"]
        			end
        			weather_data = {
        				location_name: data["locationName"],
	        			element: element["elementName"],
	        			time: time["startTime"],
	        			parameter: time["parameter"]["parameterName"],
	        			parameter_value: value
        			}
                    #進行比對，若是已有的資料則不要新增，若是沒有的要新增到Weather資料表
        			weather = Weather.find_or_initialize_by(location_name: data["locationName"], element: element["elementName"], time: time["startTime"])
                    weather.update(weather_data)
        			weather.save
                    # puts weather_data
        		end  		
        	end
        end
     end
  end
end