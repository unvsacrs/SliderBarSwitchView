//
//  ContentView.swift
//  SliderBarSwitchViewExample
//
//  Created by YASUSHI NOZAKI on R 5/01/26.
//

import SwiftUI
import SliderBarSwitchView
import AVFoundation

struct ContentView: View {
    @State private var counter = 0
    @State private var slideBarCaption = "スライド回数: 0回"
    
    func callback() {
        //クリックを発生
        AudioServicesPlaySystemSound(1519)

        self.counter += 1
        self.slideBarCaption = "スライド回数: \(self.counter)回"
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                Text(self.slideBarCaption)
                    .font(.largeTitle)
                    .padding()

                VStack {
                    Text("固定キャプション")
                        .padding()
                    SliderBarSwitchView(width: geometry.size.width, caption: "固定キャプション") {
                        callback()
                    }
                }

                VStack {
                    Text("可変キャプション")
                        .padding()
                    SliderBarSwitchView(width: geometry.size.width, backGroundColor: Color.blue, caption: $slideBarCaption) {
                        callback()
                    }
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
