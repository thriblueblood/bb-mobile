//
//  ContentView.swift
//  bbmobile
//
//  Created by Thirayut Sriphochang on 31/3/2564 BE.
//

import SwiftUI

struct ContentView: View {
    init(){
        UITabBar.appearance().barTintColor = UIColor(Color("MainColor"))
        UITabBar.appearance().isTranslucent = false
    }
    
    var body: some View {
        

        TabView{
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                }.tag(0)
            SearchView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }.tag(1)
            Text("BookMark")
                .tabItem {
                    Image(systemName: "bookmark.fill")
                }.tag(2)
        }.accentColor(Color("SecondaryColor"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
