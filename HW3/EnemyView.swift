//
//  EnemyView.swift
//  HW3
//
//  Created by roykesydone on 2022/11/5.
//

import SwiftUI

struct Enemy: Identifiable{
    let id = UUID()
    var offsetX: Double
    var offsetY: Double
    var isDead = false
    
    func beingHitted(targetX: Double, targetY: Double, myX: Double, myY: Double) -> Bool{
        let diffX = targetX - myX
        let diffY = targetY - myY
        return (((diffX*diffX + diffY*diffY).squareRoot()<25) && !isDead) ? true : false
    }
    
    mutating func suicide(){
        isDead = true
    }
    
}

struct EnemyView: View {
    @Binding var enemy: Enemy
    @State private var timer: Timer?
    @State var floatOffsetCount: Int = 0
    @State var floatOffsetUp: Bool = true
    @State var opacity = 1.0
    @State var deadCount: Int = 0
    
    var body: some View {
        ZStack{
            
            ZStack{
                if !enemy.isDead{
                    Rectangle()
                        .frame(width: 3, height: 17)
                        .foregroundColor(Color("MyPink"))
                        .offset(x: -10, y: -5)
                    Rectangle()
                        .frame(width: 3, height: 17)
                        .foregroundColor(Color("MyPink"))
                        .offset(x: 5, y: -5)
                }
                else if enemy.isDead{
                    Rectangle()
                        .frame(width: 3, height: 17)
                        .foregroundColor(Color("MyPink"))
                        .rotationEffect(.degrees(45), anchor: .center)
                        .offset(x: -10, y: -5)
                    
                    Rectangle()
                        .frame(width: 3, height: 17)
                        .foregroundColor(Color("MyPink"))
                        .rotationEffect(.degrees(-45), anchor: .center)
                        .offset(x: -10, y: -5)
                    
                    
                    Rectangle()
                        .frame(width: 3, height: 17)
                        .foregroundColor(Color("MyPink"))
                        .rotationEffect(.degrees(45), anchor: .center)
                        .offset(x: 5, y: -5)
                    
                    Rectangle()
                        .frame(width: 3, height: 17)
                        .foregroundColor(Color("MyPink"))
                        .rotationEffect(.degrees(-45), anchor: .center)
                        .offset(x: 5, y: -5)
                    
                }
                Circle()
                    .stroke(Color("MyPink"), style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
                    .frame(width: 50, height: 50)
                    .offset(x: 0, y: 0)
            }.opacity(opacity)
            
        }
        .compositingGroup()
        .onAppear(){
            self.timer = Timer.scheduledTimer(withTimeInterval: 1/140, repeats: true, block: { _ in
                update()
            })
            
            
            func update(){
                // 漂浮機制
                floatOffsetCount += 1
                if floatOffsetCount == 160{
                    floatOffsetCount = 0
                    floatOffsetUp = !floatOffsetUp
                }
                else{
                    if floatOffsetUp{
                        enemy.offsetY -= 1/20
                    }
                    else{
                        enemy.offsetY += 1/20
                    }
                }
                
                // 死亡機制
                if enemy.isDead{
                    deadCount += 1
                    if deadCount >= 70{
                        opacity -= 1/140
                    }
                }
            }
        }
        .onDisappear(){
            self.timer?.invalidate()
        }
    }
}

struct EnemyView_Previews: PreviewProvider {
    @State static var enemy = Enemy(offsetX: 0, offsetY: 0)
    
    static var previews: some View {
        EnemyView(enemy: $enemy)
    }
}
