# SliderBarSwitchView - iOS(SwiftUI) 向け スライドバー型スイッチ
===============
[![Swift Package Manager compatible](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)

SliderBarSwitchView は **iOS**, **iPadOS** 向けに、スライド型のインタラクションインタフェースを提供します。 
以下を使用可能です。

* [`SliderBarSwitchView`](Sources/SliderBarSwitchView.swift)

Installation
------------

* use SPM: add `https://github.com/unvsacrs/SliderBarSwitchView` and set "Up to Next Major" with "12.0.0"

Usage
-----

```swift
import SliderBarSwitchView

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

```
