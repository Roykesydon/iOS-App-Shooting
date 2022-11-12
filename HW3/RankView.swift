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
            ForEach(records) { record in
                VStack(alignment: .leading){
                    Text("暱稱: \(record.nickname)")
                    Text("時間: \(record.curTimeString)")
                    Text("射幾發: \(String(record.shootCount))")
                    Text("性別: \(record.gender)")
                    Text("年齡: \(String(record.age))")
                    Text("補充文字: \(record.note)")
                }.foregroundColor(.white)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        
    }
}

struct RankView_Previews: PreviewProvider {
    @State static var page: String = "RankView"
    @State static var records: [Record] = [
        Record(nickname: "test", note: "Test", age: 20, gender: "男性", shootCount: 20, curTimeString: "00:00"),
        Record(nickname: "test", note: "Test", age: 20, gender: "男性", shootCount: 20, curTimeString: "00:00"),]
    
    static var previews: some View {
        RankView(page: $page, records: $records)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
