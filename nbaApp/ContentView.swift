//
//  ContentView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI


struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor(Color.nba)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.white)
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(Color.nba)
        UITabBar.appearance().standardAppearance = appearance
    }
    var body: some View {
        TabView {
            HomeView()
                .tabItem{
                    Label("Draft", systemImage: "house")
                }
            HeirarchyView()
                .tabItem{
                    Label("Teams", systemImage: "basketball.fill")
                }
            
            LeagueLeadersView()
                .tabItem{
                    Label("Leaders", systemImage: "trophy.fill")
                }
            
        }
        .tint(.basketball)
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

