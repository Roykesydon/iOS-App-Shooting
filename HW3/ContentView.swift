//
//  ContentView.swift
//  HW3
//
//  Created by roykesydone on 2022/11/4.
//

import SwiftUI

struct ContentView: View {
    @State var page: String = "HomeView"
    
    @State var pull = false
    @State var degree: Double = 45
    @State var records: [Record] = []
    
    
    var body: some View {
        if page == "HomeView"{
            HomeView(page: $page)
        }
        
        else if page == "GamingView"{
            GamingView(page: $page, records: $records)
        }
        
        else if page == "RankView"{
            RankView(page: $page, records: $records)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
