//
//  ContentView.swift
//  HW3
//
//  Created by roykesydone on 2022/11/4.
//

import SwiftUI

struct ContentView: View {
    @State var page: String = "HomeView"
    
    var body: some View {
        if page == "HomeView"{
            HomeView(page: $page)
        }
        else if page == "GamingView"{
            GamingView(page: $page)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
