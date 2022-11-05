//
//  BowView.swift
//  HW3
//
//  Created by roykesydone on 2022/11/5.
//

import SwiftUI

struct AimingString: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX-2, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX-2, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX-2, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))

        return path
    }
}

struct BowView: View {
    @Binding var pull: Bool 
    @Binding var degree: Double
    @Namespace private var bowStringSpace
    
    var body: some View {
        ZStack{
            if !pull{
                Rectangle()
                    .matchedGeometryEffect(id: "bowString", in: bowStringSpace)
                    .frame(width: 50, height: 2)
                    .foregroundColor(.white)
                    .offset(x: 0, y: 10)
            }
            else{
                AimingString()
                    .matchedGeometryEffect(id: "bowString", in: bowStringSpace)
                    .frame(width: 50, height: 50)
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(90))
                    .offset(x: 0, y: -10)
            }
            Circle()
                .trim(from: 0, to: 0.5)
                .stroke(.white, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                .frame(width: 50, height: 50)
                .offset(x: 0, y: 10)
        }
        .compositingGroup()
        .rotationEffect(.degrees(degree - 90))
    }
}

struct BowView_Previews: PreviewProvider {
    @State static var pull = false
    @State static var degree: Double = 45
    
    static var previews: some View {
        BowView(pull: $pull,degree: $degree)
    }
}
