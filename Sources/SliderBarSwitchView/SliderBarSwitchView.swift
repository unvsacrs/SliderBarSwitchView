import SwiftUI

public struct SliderBarSwitchView: View {
    let width: Double
    let circleRadius: CGFloat
    let staticCaption: String
    let circleColor: Color
    let textColor: Color
    let backGroundColor: Color
    let complete: ()->()
    @Binding var dynamicCaption: String

    @State private var dragOffset = CGSize.zero
    @State private var completed = false

    public init(width: Double, circleRadius: CGFloat = 36, circleColor: Color = Color.white, textColor: Color = Color.white, backGroundColor: Color = Color.green, caption: String, complete: @escaping(()->())) {
        self.width = width
        self.circleRadius = circleRadius
        self.staticCaption = caption
        self.circleColor = circleColor
        self.textColor = textColor
        self.backGroundColor = backGroundColor
        self.complete = complete
        self._dynamicCaption = Binding {
                return ""
            } set: { _ in
            }
    }

    public init(width: Double, circleRadius: CGFloat = 36, circleColor: Color = Color.white, textColor: Color = Color.white, backGroundColor: Color = Color.green, caption: Binding<String>, complete: @escaping(()->())) {
        self.width = width
        self.circleRadius = circleRadius
        self.staticCaption = ""
        self.circleColor = circleColor
        self.textColor = textColor
        self.backGroundColor = backGroundColor
        self.complete = complete
        self._dynamicCaption = caption
    }
    
    public var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: circleRadius, style: .continuous)
                .fill(self.backGroundColor)
                .frame(width: (self.width - (circleRadius - 2)) - self.dragOffset.width, height: circleRadius * 2)
                .offset(CGSize(width: self.dragOffset.width, height: 0))
            
            if self.dragOffset.width == 0 {
                Text((self.dynamicCaption == "") ? self.staticCaption : dynamicCaption)
                    .font(.title)
                    .foregroundColor(self.textColor)
                    .offset(CGSize(width: (circleRadius * 2) + 8, height: 0))
            }

            Circle()
                .offset(CGSize(width: self.dragOffset.width + 1, height: 0))
                .fill(self.circleColor)
                .frame(width: (circleRadius - 1) * 2, height: (circleRadius - 1) * 2)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width >= ((self.width - (circleRadius - 2)) - (circleRadius - 1) * 2) {
                                if self.completed == false {
                                    self.completed = true
                                    complete()
                                }

                            } else if gesture.translation.width >= 0 && gesture.translation.width < ((self.width - (circleRadius - 2)) - (circleRadius - 1) * 2) {
                                self.dragOffset = gesture.translation
                            }
                        }
                        .onEnded { gesture in
                            self.dragOffset = .zero
                            self.completed = false
                        }
                )
        }.padding(.leading)
        .padding(.bottom)
        .frame(maxWidth: .infinity, minHeight: circleRadius * 2, maxHeight: circleRadius * 2, alignment:.leading)
    }
}
