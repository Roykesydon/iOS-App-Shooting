//
//  SettingView.swift
//  HW3
//
//  Created by roykesydone on 2022/11/6.
//

import SwiftUI

struct SettingView: View {
    @Binding var showSetting: Bool
    @Binding var enemyColor: Color
    @State var pausing = false
    @State var enemy = Enemy(offsetX: 0, offsetY: 0)
    
    var body: some View {
        GeometryReader(content: {
            geometry in
            VStack{
                ZStack{
                    HStack{
                        Button {
                            showSetting = false
                        } label: {
                            HStack{
                                Image(systemName: "arrow.left")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                            }
                            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                        }
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                        Spacer()
                    }
                    Text("設定")
                        .font(.system(size: 40))
                        .foregroundColor(.white)
                }
                
                VStack{
                    HStack{
                        Text("設定怪物顏色：")
                            .foregroundColor(.white)
                        ColorPicker("", selection: $enemyColor, supportsOpacity: false)
                        EnemyView(enemy: $enemy, pausing: $pausing, enemyColor: $enemyColor)
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 4, trailing: 0))
                    
                }
                .frame(width: geometry.size.width*0.6)
                Spacer()
            }
            .padding(20)
            .background(.black)
        }
        )
    }
}

struct SettingView_Previews: PreviewProvider {
    @State static var showSetting: Bool = true
    @State static var enemyColor: Color = Color("MyPink")
    
    static var previews: some View {
        SettingView(showSetting: $showSetting, enemyColor: $enemyColor)
            .previewInterfaceOrientation(.landscapeRight)
    }
    
}

