//
//  ArrowView.swift
//  HW3
//
//  Created by roykesydone on 2022/11/4.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        return path
    }
}

struct ArrowTail: Shape{
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))

        return path
    }
}

struct Arrow: Identifiable{
    let id = UUID()
    var offsetX: Double
    var offsetY: Double
    var initSpeed: Double = 1150
    var speedX: Double = 0
    var speedY: Double = 0
    var degree: Double = -45
    var moveFlag: Bool = false
    var accY: Double = 3000
    var accX: Double = 0
    var shoot: Bool = false
    
    func checkGroundCollision(ground: Double) -> Bool{
        if 25 * sin(degree * Double.pi / 180) + offsetY >= ground {
            return true
        }
        return false
    }
    
    mutating func computeSpeedXY(){
        if degree < 0{
            speedX = initSpeed * cos(-degree * Double.pi / 180)
            speedY = -initSpeed * sin(-degree * Double.pi / 180)
        }
        else{
            speedX = initSpeed * cos(degree * Double.pi / 180)
            speedY = initSpeed * sin(degree * Double.pi / 180)
        }
        
        
    }
    
    mutating func move(time: Double){
        if !moveFlag{
            computeSpeedXY()
        }
        
        self.moveFlag = true
        self.offsetX += speedX * time
        self.offsetY += speedY * time
        self.speedY += accY * time
        self.speedX += accX * time
        
//        self.speedX = max(0, speedX)
        if speedX >= 0{
            self.degree = atan(speedY / speedX) * 180 / Double.pi
        }
        else{
            self.degree = atan(speedY / speedX) * 180 / Double.pi + 180
        }
    }
}

struct ArrowView: View {
    @Binding var arrow: Arrow
    @State var arrowScale: Double = 0.75
    
    var body: some View {
        ZStack{
            ArrowTail()
                .stroke(.white, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                .frame(width: 20*arrowScale, height: 15*arrowScale)
                .offset(x:-25*arrowScale)
            Rectangle()
                .frame(width: 50*arrowScale, height: 3*arrowScale)
                .foregroundColor(.white)
            Triangle()
                .stroke(.white, style: StrokeStyle(lineWidth: 3*arrowScale, lineCap: .round, lineJoin: .round))
                .frame(width: 20*arrowScale, height: 15*arrowScale)
                .offset(x: (25+10)*arrowScale, y: 0)
//            Circle()
//                .frame(width: 3, height: 3)
//                .foregroundColor(.red)
//                .offset(x: 0, y: 0)
        }
        .compositingGroup()
        .rotationEffect(.degrees(arrow.degree))
    }
}

struct ArrowView_Previews: PreviewProvider {
    @State static var arrow = Arrow(offsetX: 0, offsetY: 0)
    
    static var previews: some View {
        ArrowView(arrow: $arrow)
    }
}
