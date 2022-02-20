//
//  ContentView.swift
//  SwiftUIColorSlider
//
//  Created by Михаил Зверьков on 20.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var redSliderValue = 50.0
    @State private var greenSliderValue = 30.0
    @State private var blueSliderValue = 20.0

    var body: some View {
        ZStack {
            Color.init(red: 0.15, green: 0.6, blue: 1).ignoresSafeArea()
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 130)
                    .foregroundColor(Color(
                                           red: Double(redSliderValue / 100),
                                           green: Double(greenSliderValue / 100),
                                           blue: Double(blueSliderValue) / 100))
                    .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 4))
                    .padding()
                
                sliderStack(sliderValue: $redSliderValue, color: .red).padding(.top, 80)
                sliderStack(sliderValue: $greenSliderValue, color: .green)
                sliderStack(sliderValue: $blueSliderValue, color: .blue)
            }
        }
    }
}

struct sliderStack: View {
    @Binding var sliderValue: Double
    @State var alertPresented = false
    let color: Color
    @FocusState var keyboardActive: Bool
    
    var body: some View {
        HStack {
            Text("\(lround(sliderValue))")
                .font(.title3)
                .foregroundColor(.white)
            Slider(value: $sliderValue, in: 0...100, step: 1)
                .accentColor(color)
            TextField("", value: $sliderValue, format: .number)
                .frame(width: 40)
                .multilineTextAlignment(.center)
                .background(Color.white).cornerRadius(40)
                .keyboardType(.asciiCapableNumberPad)
                .focused($keyboardActive)
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button("Done") {
                            if sliderValue > 100 {
                                alertPresented.toggle()
                                sliderValue = 100
                                return
                            }
                            keyboardActive = false
                        }.alert("Значение должно быть от 0 до 100", isPresented: $alertPresented, actions: {})
                    }
                }
        }.padding(.horizontal, 17.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
