//
//  GamingView.swift
//  HW3
//
//  Created by roykesydone on 2022/11/4.
//

import SwiftUI

struct GamingView: View {
    // 遊戲結束
    @State var showEnd = false
    
    // 暫停
    @State var pausing = false
    @State var pausingTime: Int = 0
    @State var lastTime: Int = 0
    
    // 分頁
    @Binding var page: String
    @State var quitAlert: Bool = false
    @State var showSetting: Bool = false
    
    @Binding var records: [Record]
    
    // 射箭
    @State var arrows: [Arrow] = [Arrow(offsetX: -250, offsetY: 100)]
    @State var pull: Bool = true
    @State private var timer: Timer?
    @State var shootDegree: Double = -45
    @State var shootSpeed: Double = 1150
    @State var lasttimeGetArrow = 0
    @State var level = 0
    @State var shootCount: Int = 0
    
    // 敵人
    @State var enemys: [Enemy] = []
    @State var enemyDeadCount = 210
    @State var enemyColor = Color("MyPink")
    
    // 計時
    @State var startTime: Int = 0
    @State var endTime: Int = 0
    @State var curTimeString: String = "00:00:00"
    
    var body: some View {
        GeometryReader(content: {
            geometry in
            HStack(spacing: 0){
                ZStack {
                    VStack(spacing: 0){
                        ZStack{
                            VStack{
                                HStack{
                                    Text("第 \(level) 波")
                                        .font(.largeTitle)
                                        .fontWeight(.light)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Text("射 \(shootCount) 支箭")
                                        .font(.largeTitle)
                                        .fontWeight(.light)
                                        .foregroundColor(.white)
                                    
                                    Spacer()
                                    
                                    Text(curTimeString)
                                        .font(.largeTitle)
                                        .fontWeight(.light)
                                        .foregroundColor(.white)
                                        .frame(width: 150)
                                }
                                .padding(30)
                                Spacer()
                                
                            }
                            
                            ForEach($arrows){
                                $arrow in
                                ArrowView(arrow: $arrow)
                                    .offset(x: arrow.offsetX, y: arrow.offsetY)
                            }
                            
                            BowView(pull: $pull, degree: $shootDegree)
                                .offset(x: -250, y: 100)
                            ForEach($enemys){
                                $enemy in
                                EnemyView(enemy: $enemy, pausing: $pausing, enemyColor: $enemyColor)
                                    .offset(x: enemy.offsetX, y: enemy.offsetY)
                            }
                        }
                        .frame(width: geometry.size.width*0.8, height: geometry.size.height*0.9)
                        .background(Color(red: 10/255, green: 10/255, blue: 10/255))
                        
                        VStack{}
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(.white)
                    }
                    
                    Image(systemName: "pause.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                        .opacity((pausing) ? 1.0 : 0.0)
                }
                // 右邊面板
                VStack(alignment: .center){
                    if !pausing{
                        Button {
                            pausing = true
                        } label: {
                            HStack{
                                Text("暫停")
                                    .foregroundColor(.white)
                                Image(systemName: "pause.fill")
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.purple, lineWidth: 2)
                            )
                        }
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
                    }
                    else{
                        Button {
                            pausing = false
                        } label: {
                            HStack{
                                Text("繼續")
                                    .foregroundColor(.white)
                                Image(systemName: "play.fill")
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.purple, lineWidth: 2)
                            )
                        }
                        .padding(EdgeInsets(top: 20, leading: 10, bottom: 0, trailing: 10))
                    }
                    
                    Button {
                        pausing = true
                        showSetting = true
                    } label: {
                        HStack{
                            Text("設定")
                                .foregroundColor(.white)
                            Image(systemName: "gearshape")
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.purple, lineWidth: 2)
                        )
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    .sheet(isPresented: $showSetting) {
                        SettingView(showSetting: $showSetting, enemyColor: $enemyColor)
                    }
                    
                    Button {
                        quitAlert = true
                    } label: {
                        HStack{
                            Text("離開")
                                .foregroundColor(.white)
                            Image(systemName: "door.left.hand.open")
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.red, lineWidth: 2)
                        )
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    .alert("確定要離開嗎", isPresented: $quitAlert, actions: {
                        Button("取消", role: .cancel) {
                        }
                        Button("離開", role: .destructive) {
                            page = "HomeView"
                        }
                    }, message: {
                    })
                    .fullScreenCover(isPresented: $showEnd) {
                        EndView(page: $page, records: $records, showEnd: $showEnd, shootCount: shootCount, curTimeString: curTimeString)
                    }
                    
                        
                    //                    Button {
                    //                        showEnd = true
                    //                        pausing = true
                    //                    } label: {
                    //                        HStack{
                    //                            Text("勝利")
                    //                                .foregroundColor(.white)
                    //                            Image(systemName: "door.left.hand.open")
                    //                                .foregroundColor(.white)
                    //                        }
                    //                        .frame(maxWidth: .infinity)
                    //                        .padding(8)
                    //                        .overlay(
                    //                            RoundedRectangle(cornerRadius: 10)
                    //                                .stroke(.purple, lineWidth: 2)
                    //                        )
                    //                    }
                    //                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    
                    
                    Spacer()
                    
                    HStack{
                        Text("力度")
                            .foregroundColor(.white)
                        Slider(value: $shootSpeed, in: 300...1150)
                            .accentColor((pausing) ? .gray : .purple)
                            .disabled(pausing)
                    }
                    
                    HStack{
                        Text("角度")
                            .foregroundColor(.white)
                        Slider(value: $shootDegree, in: -90...0)
                            .accentColor((pausing) ? .gray : .purple)
                            .disabled(pausing)
                    }
                    
                    
                    Button {
                        shootCount += 1
                        arrows[arrows.endIndex-1].degree = shootDegree
                        arrows[arrows.endIndex-1].shoot = true
                        pull = false
                    } label: {
                        Text("發射")
                            .frame(width: 50)
                            .foregroundColor(pull ? .white : .gray)
                            .padding(8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
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
                startTime = Int(NSDate().timeIntervalSince1970 * 100);
                
                self.timer = Timer.scheduledTimer(withTimeInterval: 1/140, repeats: true, block: { _ in
                    update()
                })
                
                
                func update(){
                    if pausing{
                        pausingTime += Int(NSDate().timeIntervalSince1970 * 100) - lastTime
                        lastTime = Int(NSDate().timeIntervalSince1970 * 100)
                        return
                    }
                    
                    // 計時機制
                    endTime = Int(NSDate().timeIntervalSince1970 * 100)
                    let timeDiff: Int = Int(endTime - startTime) - pausingTime
                    curTimeString = "\(String(format: "%02d", timeDiff/6000)):\(String(format: "%02d", timeDiff/100%60))"
                    lastTime = endTime
                    
                    // 怪物出現機制
                    var enemy_all_dead = true
                    for i in 0..<enemys.count{
                        if !enemys[i].isDead{
                            enemy_all_dead = false
                        }
                    }
                    
                    if enemy_all_dead{
                        enemyDeadCount += 1
                        if enemyDeadCount >= 210{
                            enemyDeadCount = 0
                            enemys = []
                            level += 1
                            
                            let enemyCountInLevel = [1, 2, 2, 3, 3, 3, 3, 3, 3, 3]
                            var pastPosition: [Double] = []
                            
                            if level > 1{
                                showEnd = true
                                pausing = true
                                level = 10
                            }
                            
                            for _ in 0..<enemyCountInLevel[level-1]{
                                while true{
                                    let position = 50 + Double.random(in: -100...200)
                                    var flag = true
                                    
                                    for j in 0..<pastPosition.count{
                                        if abs(pastPosition[j] - position) < 70{
                                            flag = false
                                        }
                                    }
                                    if flag{
                                        pastPosition.append(position)
                                        enemys.append(Enemy(offsetX: position, offsetY: 130))
                                        break
                                    }
                                }
                            }
                        }
                    }
                    
                    // 檢查 arrow 和 bow, ground 互動
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
                                if arrows.count > 30{
                                    arrows.removeFirst()
                                }
                            }
                        }
                    }
                    
                    // 檢查 arrow 和 enemy 互動
                    if enemys.count != 0 {
                        for index in 0..<enemys.count {
                            let targetX = 25 * cos(arrows[arrows.endIndex-1].degree * Double.pi / 180) + arrows[arrows.endIndex-1].offsetX
                            let targetY = 25 * sin(arrows[arrows.endIndex-1].degree * Double.pi / 180) + arrows[arrows.endIndex-1].offsetY
                            let myX = enemys[index].offsetX
                            let myY = enemys[index].offsetY
                            
                            if enemys[index].beingHitted(targetX: targetX, targetY: targetY, myX: myX, myY: myY){
                                enemys[index].suicide()
                                
                                if targetX < myX && targetY <= myY{
                                    arrows[arrows.endIndex-1].speedY = -300 + Double.random(in: 0...200)
                                    arrows[arrows.endIndex-1].speedX = -600 + Double.random(in: 0...200)
                                }
                                else if targetX >= myX && targetY <= myY{
                                    arrows[arrows.endIndex-1].speedY = -300 + Double.random(in: 0...200)
                                    arrows[arrows.endIndex-1].speedX = 600 + Double.random(in: -200...0)
                                }
                                else if targetX < myX && targetY > myY{
                                    arrows[arrows.endIndex-1].speedX = -600 + Double.random(in: 0...200)
                                }
                                else if targetX >= myX && targetY > myY{
                                    arrows[arrows.endIndex-1].speedX = 600 + Double.random(in: -200...0)
                                }
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
    @State static var page: String = "GamingView"
    @State static var records: [Record] = []
    
    static var previews: some View {
        GamingView(page: $page, records: $records)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
