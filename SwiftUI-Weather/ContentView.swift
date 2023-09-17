//
//  ContentView.swift
//  SwiftUI-Weather
//
//  Created by Cristóbal Contreras on 15-09-23.
//

import SwiftUI

struct DayTemperature {
  var day: String
  var icon: String
  var temp: Int

    init(day: String, icon: String, temp: Int) {
        self.day = day
        self.icon = icon
        self.temp = temp
    }
}
struct ContentView: View {
    let fiveDaysTemperatures: [DayTemperature] = [
        DayTemperature(
            day: "TUE",
            icon: "cloud.sun.fill",
            temp: 74),
        DayTemperature(
            day: "WED",
            icon: "sun.max.fill",
            temp: 88),
        DayTemperature(
            day: "THU",
            icon: "wind.snow",
            temp: 55),
        DayTemperature(
            day: "FRI",
            icon: "sunset.fill",
            temp: 60),
        DayTemperature(
            day: "SAT",
            icon: "snow",
            temp: -12)
    ]
    
    @State private var isNight = false
    
    var body: some View {
        ZStack {
            BackgroundView(isNight: isNight)
            VStack {
                CityTextView(cityName: "Cuppertino, CA")
                MainWeatherStatusView(isNight: $isNight)
                
                HStack(spacing: 20) {
                    for day in fiveDaysTemperatures {
                        WeatherDayView(
                            dayOfWeek: day.day,
                            imageName: day.icon,
                            temperature: day.temp)
                    }
                }
                
                Spacer()
                Button {
                    print("tapped")
                    isNight.toggle()
                } label: {
                    WeatherButton(
                        title: "Change Day Time",
                        textColor: .white,
                        backgroundColor: .mint )
                }
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct WeatherDayView: View {
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing: 6) {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .symbolRenderingMode(.multicolor)
                .resizable()
                // .foregroundStyle( .pink, .orange)
                // .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            Text("\(temperature)°")
                .font(.system(size: 28, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    // var topColor: Color
    // var bottomColor: Color
    
    var isNight: Bool
    
    var body: some View {
//        LinearGradient(gradient: Gradient(
//            colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
//            startPoint: .topLeading,
//            endPoint: .bottomTrailing)
//        .ignoreSafeArea(.all)
        ContainerRelativeShape()
            .fill(isNight ? Color.black.gradient : Color.blue.gradient)
            .ignoresSafeArea()
    }
}

struct CityTextView: View {
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    // var imageName: String
    // var temperature: Int
    
    @Binding var isNight: Bool
    
    var body: some View {
        VStack(spacing: 10){
            Image(systemName: isNight ? "moon.stars.fill" : "cloud.sun.fill")
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            Text("\(isNight ? 20 : 76)°")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(.white)
        }
        .padding(.bottom, 40)
    }
}
