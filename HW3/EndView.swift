//
//  EndView.swift
//  HW3
//
//  Created by roykesydone on 2022/11/7.
//

import SwiftUI

struct EndView: View {
    @Binding var page: String
    @Binding var records: [Record]
    @Binding var showEnd: Bool
    
    @State var wantRecord = false
    @State var haveRecorded = false
    
    var shootCount: Int
    var curTimeString: String
    
    var body: some View {
        GeometryReader(content: {
            geometry in
            ScrollView {
                VStack{
                    ZStack{
                        Text("結果")
                            .font(.system(size: 40))
                            .foregroundColor(.white)
                    }.padding(EdgeInsets(top: 0, leading: 0, bottom: 20, trailing: 0))
                    
                    
                    VStack{
                        VStack{
                            HStack{
                                VStack(alignment: .leading){
                                    Text("射了幾支箭")
                                    Text("耗費時間")
                                }
                                VStack{
                                    Text("：")
                                    Text("：")
                                }
                                Spacer()
                                VStack(alignment: .trailing){
                                    Text(String(shootCount))
                                    Text(String(curTimeString))
                                }
                            }
                        }
                        .fontWeight(.light)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .sheet(isPresented: $wantRecord) {
                            RecordFormView(page: $page, records: $records,showEnd: $showEnd, shootCount: shootCount, curTimeString: curTimeString, wantRecord: $wantRecord)
                        }
                        
                        HStack{
                            Button {
                                page = "HomeView"
                            } label: {
                                HStack{
                                    Text("返回首頁")
                                        .foregroundColor(.white)
                                    Image(systemName: "door.left.hand.open")
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
                            
                            
                            if !wantRecord && !haveRecorded{
                                Button {
                                    wantRecord = true
                                    haveRecorded = true
                                } label: {
                                    HStack{
                                        Text("紀錄下來")
                                            .foregroundColor(.white)
                                        Image(systemName: "square.and.pencil")
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
                            }
                        }
                    }
                    .frame(width: geometry.size.width*0.6)
                    
                }
            }
            .frame(maxWidth: .infinity)
            .padding(20)
            .background(.black)
        }
        )
    }
}

struct EndView_Previews: PreviewProvider {
    @State static var page = ""
    @State static var curTimeString = "00:00"
    @State static var shootCount = 85
    @State static var records: [Record] = []
    @State static var showEnd: Bool = false
    
    static var previews: some View {
        EndView(page: $page, records: $records, showEnd: $showEnd, shootCount: shootCount, curTimeString: curTimeString)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
