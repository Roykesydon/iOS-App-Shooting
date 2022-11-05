//
//  GamingView.swift
//  HW3
//
//  Created by roykesydone on 2022/11/4.
//

import SwiftUI

struct GamingView: View {
//    @State var arrow = Arrow(offsetX: -200, offsetY: 100)
    @State var arrows: [Arrow] = [Arrow(offsetX: -250, offsetY: 100)]
    @State var pull: Bool = true
    @State private var timer: Timer?
    @State var shootDegree: Double = -45
    @State var shootSpeed: Double = 1150
    @State var lasttimeGetArrow = 0
    
    var body: some View {
        GeometryReader(content: {
            geometry in
            HStack(spacing: 0){
                VStack(spacing: 0){
                    ZStack{
                        ForEach($arrows){
                            $arrow in
                            ArrowView(arrow: $arrow)
                                .offset(x: arrow.offsetX, y: arrow.offsetY)
                        }
                        
                        BowView(pull: $pull, degree: $shootDegree)
                            .offset(x: -250, y: 100)
                    }
                    .frame(width: geometry.size.width*0.8, height: geometry.size.height*0.9)
                    .background(Color(red: 10/255, green: 10/255, blue: 10/255))
                    
                    VStack{}
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.white)
                }
                VStack(alignment: .center){
                    Spacer()
                    
                    HStack{
                        Text("力度")
                            .foregroundColor(.white)
                        Slider(value: $shootSpeed, in: 300...1150)
                            .accentColor(.purple)
                    }
                    
                    HStack{
                        Text("角度")
                            .foregroundColor(.white)
                        Slider(value: $shootDegree, in: -90...0)
                            .accentColor(.purple)
                    }
                    
                    
                    Button {
                        arrows[arrows.endIndex-1].degree = shootDegree
                        arrows[arrows.endIndex-1].shoot = true
                        pull = false
                    } label: {
                        Text("發射")
                            .frame(width: 50)
                            .foregroundColor(pull ? .white : .gray)
                            .padding(8)
                            .overlay(
                                Rectangle()
                                    .stroke(pull ? .purple : .gray, lineWidth: 2)
                            )
                            .padding(10)
                    }
                    .disabled(!pull)
                }
                .padding(10)
                .frame(width: geometry.size.width*0.2, height: geometry.size.height*1.0)
                .background(Color(red: 30/255, green: 30/255, blue: 30/255))
            }
            .onAppear(){
                self.timer = Timer.scheduledTimer(withTimeInterval: 1/140, repeats: true, block: { _ in
                    update()
                })
                
                
                func update(){
                    if !arrows.last!.shoot{
                        arrows[arrows.endIndex-1].degree = shootDegree
                        arrows[arrows.endIndex-1].initSpeed = shootSpeed
                    }
                    else if arrows.last!.shoot{
                        lasttimeGetArrow += 1
                        
                        if !arrows.last!.checkGroundCollision(ground: geometry.size.height*0.9 / 2){
                            arrows[arrows.endIndex-1].move(time: 1/140)
                        }
                        else{
                            if lasttimeGetArrow == 210{
                                pull = true
                                arrows.append(Arrow(offsetX: -250, offsetY: 100))
                                lasttimeGetArrow = 0
                            }
                        }
                    }
                }
            }
            .onDisappear(){
                self.timer?.invalidate()
            }
        })
    }
}

struct GamingView_Previews: PreviewProvider {
    static var previews: some View {
        GamingView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
