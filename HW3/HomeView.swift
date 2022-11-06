//
//  HomeView.swift
//  HW3
//
//  Created by roykesydone on 2022/11/6.
//

import SwiftUI

struct HomeView: View {
    @Binding var page: String
    
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                Text("射箭遊戲")
                    .font(.system(size: 60))
                    .fontWeight(.black)
                    .foregroundColor(.white)
            }.offset(y: -20)
            
            
            Spacer()
            
            Button {
                page = "GamingView"
            } label: {
                Text("開始遊戲")
                    .frame(width: 100)
                    .foregroundColor(.purple)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.purple, lineWidth: 2)
                    )
                    .padding(10)
            }.offset(y: -50)
            
//            Spacer()
            
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

struct HomeView_Previews: PreviewProvider {
    @State static var page: String = "HomeView"
    
    static var previews: some View {
        HomeView(page: $page)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
