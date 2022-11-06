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
    
    var eyeCount: Int = 0
    var eyeWidth: Double = 3.0
    var eyeHeight: Double = 17.0
    var eyeDelayCount: Int = 0
    var eyeDelay: Int = Int.random(in: 140...140*4)
    
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
    @Binding var pausing: Bool
    @State private var timer: Timer?
    @State var floatOffsetCount: Int = 0
    @State var floatOffsetUp: Bool = true
    @State var opacity = 1.0
    @State var deadCount: Int = 0
    
    
    
    var body: some View {
        ZStack{
            
            ZStack{
                if !enemy.isDead{
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: enemy.eyeWidth, height: enemy.eyeHeight)
                        .foregroundColor(Color("MyPink"))
                        .offset(x: -10, y: -5)
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: enemy.eyeWidth, height: enemy.eyeHeight)
                        .foregroundColor(Color("MyPink"))
                        .offset(x: 5, y: -5)
                }
                else if enemy.isDead{
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 3, height: 17)
                            .foregroundColor(Color("MyPink"))
                            .rotationEffect(.degrees(45), anchor: .center)
                            .offset(x: -10, y: -5)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 3, height: 17)
                            .foregroundColor(Color("MyPink"))
                            .rotationEffect(.degrees(-45), anchor: .center)
                            .offset(x: -10, y: -5)
                        
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 3, height: 17)
                            .foregroundColor(Color("MyPink"))
                            .rotationEffect(.degrees(45), anchor: .center)
                            .offset(x: 5, y: -5)
                        
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 3, height: 17)
                            .foregroundColor(Color("MyPink"))
                            .rotationEffect(.degrees(-45), anchor: .center)
                            .offset(x: 5, y: -5)
                    }
                    .compositingGroup()
                    
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
                if pausing{
                    return
                }
                
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
                
                enemy.eyeDelayCount += 1
                // 眨眼
                if enemy.eyeDelayCount >= enemy.eyeDelay{
                    enemy.eyeCount += 1
                    
                    if enemy.eyeCount >= 140{
                        // 閉眼中
                        if enemy.eyeCount < 140+20{
                            enemy.eyeHeight -= (17.0-3.0)/20
                        }
                        
                        // 睜眼中
                        else if enemy.eyeCount < 140+20+20{
                            enemy.eyeHeight += (17.0-3.0)/20
                        }
                        
                        // 結束
                        else{
                            enemy.eyeHeight = 17
                            enemy.eyeWidth = 3
                            enemy.eyeCount = 0
                            enemy.eyeDelay = Int.random(in: 140...140*4)
                            enemy.eyeDelayCount = 0
                        }
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
            print("delete enemy")
            self.timer?.invalidate()
        }
    }
}

struct EnemyView_Previews: PreviewProvider {
    @State static var enemy = Enemy(offsetX: 0, offsetY: 0)
    @State static var pausing = false
    
    static var previews: some View {
        EnemyView(enemy: $enemy, pausing: $pausing)
    }
}
