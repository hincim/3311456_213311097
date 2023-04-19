
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:kelimeezberle/constants/api_key.dart';
import 'package:kelimeezberle/global_widget/toast.dart';

import 'location.dart';


class WeatherDisplayData{

  Icon weatherIcon;
  AssetImage weatherImage;

  WeatherDisplayData({required this.weatherIcon, required this.weatherImage});
}

class WeatherData{

  LocationHelper locationData;

  WeatherData({required this.locationData});

  late double currentTemperature;
  late int currentCondition;
  late String city;

  Future<void> getCurrentTemperature() async{

    var url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=$apiKey&unit=metric");
    Response response = await get(url);

    if(response.statusCode == 200){
      // başarılı bir şekilde cevap varsa yani web sitesi varsa

      String data = response.body;

      var currentWeather = jsonDecode(data);



      try{
        currentTemperature = currentWeather["main"]["temp"];
        // mainin altındaki tempi alırım.
        currentCondition = currentWeather["weather"][0]["id"];
        // bulutlu mu olduğunu alırım.
        city = currentWeather["name"];
      }catch(e){
        print(e);
      }
    }else{
      showToast("Hava durumu bilgisi alınamadı.");
    }
  }

  WeatherDisplayData getWeatherDisplayData(){
    if(currentCondition<600){
      // bana havanın bulutlu olduğunu söylüyor.
      return WeatherDisplayData(weatherIcon: Icon(FontAwesomeIcons.cloud,size: 75.0,color: Colors.white)
          ,weatherImage: AssetImage("assets/images/cloudy.png"));
    }else{
      var now = new DateTime.now();
      if(now.hour >= 19){
        // saat akşamsa
        return WeatherDisplayData(weatherIcon: Icon(FontAwesomeIcons.moon,size: 75.0,color: Colors.white)
            ,weatherImage: AssetImage("assets/images/night.png"));
      }else{
        return WeatherDisplayData(weatherIcon: Icon(FontAwesomeIcons.sun,size: 75.0,color: Colors.white)
            ,weatherImage: AssetImage("assets/images/sunny.png"));
      }
    }
  }
}