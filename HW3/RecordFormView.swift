//
//  RecordFormView.swift
//  HW3
//
//  Created by roykesydone on 2022/11/7.
//

import SwiftUI

struct Record: Identifiable {
    var id = UUID()
    var nickname: String
    var note: String
    var age: Int
    var gender: String
    var shootCount: Int
    var curTimeString: String
}

struct RecordFormView: View {
    @Binding var page: String
    @Binding var records: [Record]
    @Binding var showEnd: Bool
    
    @State var nickname: String = "guest"
    @State var note: String = ""
    @State var age: Int = 20
    @State private var birthday = Date()
    @State var gender: String = "男性"
    @State var needNickname: Bool = false
    
    var shootCount: Int
    var curTimeString: String
    
    @Binding var wantRecord: Bool
    
    var body: some View {
        Form{
            Section(header: Text("身份資料")) {
                Toggle(isOn: $needNickname) {
                    Text("是否要輸入暱稱（預設為 guest）")
                }
                .onChange(of: needNickname) { newValue in
                    if newValue == false{
                        nickname = "guest"
                    }
                }
                if needNickname{
                    TextField("輸入暱稱", text: $nickname)
                }
                
                DisclosureGroup("生日（計算年齡）") {
                    DatePicker("生日", selection: $birthday, displayedComponents: .date)
                        .onChange(of: birthday) { newValue in
                            let diffs = Calendar.current.dateComponents([.year], from: birthday, to: Date())
                            age = diffs.year!
                        }
                    Stepper("你的年齡 \(age)", onIncrement: {
                        age += 1
                    }, onDecrement: {
                        age -= 1
                    })
                }
                
                Picker(selection: $gender) {
                    Text("男生").tag("男性")
                    Text("女生").tag("女性")
                } label: {
                    Text("選擇性別")
                }
            }
            Section(header: Text("其他")) {
                VStack(alignment: .leading, spacing: 0){
                    Text("想説的話：")
                    TextEditor(text: $note)
                        .frame(height: 60)
                        .padding()
                }
                
            }
            Section(header: Text("選項")) {
                HStack(alignment: .center, spacing: 0){
                    Spacer()
                    Button {
                        records.append(Record(nickname: nickname, note: note, age: age, gender: gender, shootCount: shootCount, curTimeString: curTimeString))
//                        showEnd = false
                        wantRecord = false
//                        page = "HomeView"
                    } label: {
                        Text("完成")
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
        .fontWeight(.light)
        .font(.system(size: 20))
    }
}

struct RecordFormView_Previews: PreviewProvider {
    @State static var page = ""
    @State static var records: [Record] = []
    @State static var showEnd: Bool = false
    @State static var wantRecord: Bool = false
    
    static var previews: some View {
        RecordFormView(page: $page, records: $records, showEnd: $showEnd, shootCount: 0, curTimeString: "00:00", wantRecord: $wantRecord)
            .previewInterfaceOrientation(.landscapeRight)
    }
}
