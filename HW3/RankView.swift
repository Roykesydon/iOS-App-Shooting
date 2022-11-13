//
//  RankView.swift
//  HW3
//
//  Created by roykesydone on 2022/11/13.
//

import SwiftUI

struct RankView: View {
    @Binding var page: String
    @Binding var records: [Record]
    
    var body: some View {
        VStack {
            ZStack{
                HStack{
                    Button {
                        page = "HomeView"
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
                Text("紀錄")
                    .font(.system(size: 40))
                    .foregroundColor(.white)
            }
            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
            
            ScrollView{
                ForEach(records) { record in
                    HStack(alignment: .top, spacing: 8){
                        VStack(alignment: .leading){
                            Text("暱稱")
                            Text("時間")
                            Text("射幾支箭")
                            Text("性別")
                            Text("年齡")
                            Text("補充文字")
                        }
                        VStack(alignment: .leading){
                            Text(": \(record.nickname)")
                            Text(": \(record.curTimeString)")
                            Text(": \(String(record.shootCount))")
                            Text(": \(record.gender)")
                            Text(": \(String(record.age))")
                            Text(": \(record.note)")
                        }
                        Spacer()
                    }
                    .foregroundColor(.white)
                    .frame(width: 450)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.purple, lineWidth: 2)
                    )
                    .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        
    }
}

struct RankView_Previews: PreviewProvider {
    @State static var page: String = "RankView"
    @State static var records: [Record] = [
        Record(nickname: "test", note: "TestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTestTest", age: 20, gender: "男性", shootCount: 20, curTimeString: "00:00"),
        Record(nickname: "test", note: "Test", age: 20, gender: "男性", shootCount: 20, curTimeString: "00:00"),]
    
    static var previews: some View {
        RankView(page: $page, records: $records)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
