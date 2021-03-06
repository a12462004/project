# encoding: utf-8
class WeatherController < ApplicationController
  def index
  	h = Time.now.strftime("%H").to_i #當前時間是幾點，轉換成INT
  	t = Time.now.change(hour: 6).iso8601 #當前時間
  	a=[]
  	#用for迴圈找出一週的日期，，判斷當前時間點是位於早上還是晚上，寫入a陣列裡
  	for i in 0..6
		if h < 18
  			t = Time.now + i.days
  			t = t.change(hour: 6).iso8601
  			a[i]=t
		else
			t = Time.now + i.days
  			t = t.change(hour: 18).iso8601
  			a[i] = t
		end	  		
  	end
  	# 只有當天
  	# t = Time.now.strftime("%Y-%m-%d")
  	# Weather.where("location_name = ? and date(time) = ?",location,t)
  	location = params[:location]
  	if location == nil then location = "臺北市" end
  	@weathers = Weather.where("location_name = ? and time IN (?) ",location,a)
  	@citys = Weather.group("location_name").select("MIN(id) AS id ,location_name")
    @locationName = location
    @weathers_Wx = Weather.where("location_name = ? and element = 'Wx' and time IN (?) ",location,a)
    @weathers_MinT = Weather.where("location_name = ? and element = 'MinT' and time IN (?) ",location,a)
    @weathers_MaxT = Weather.where("location_name = ? and element = 'MaxT' and time IN (?) ",location,a)
    @today = @weathers_Wx[0].time
    @today = @today.to_time.strftime("%m/%d")

  end
end
