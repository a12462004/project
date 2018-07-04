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
  			t = t.change(hour: 6).iso8601
  			a[i] = t
		end	  		
  	end
  	# 只有當天
  	# t = Time.now.strftime("%Y-%m-%d")
  	# Weather.where("location_name = ? and date(time) = ?",location,t)
  	location = params[:location]
  	if location == nil then location = "臺北市" end
  	# @weathers = Weather.where("location_name = ? and time IN (?) ",location,a)
  	@citys = Weather.group("location_name")
    @locationName = location
    @weathers_Wx = Weather.where("location_name = ? and time IN (?) and element = 'Wx' ",location,a)
    @weathers_MinT = Weather.where("location_name = ? and time IN (?) and element = 'MinT' ",location,a)
    @weathers_Max = Weather.where("location_name = ? and time IN (?) and element = 'Max' ",location,a)

  end
end
