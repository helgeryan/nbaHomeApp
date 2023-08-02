//
//  DraftView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import SwiftUI

struct HomeView: View {
    @State var presentSideMenu: Bool = false
    @State var selectedSideMenuTab: Int = 0
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
                .foregroundColor(Color.nba)
            switch selectedSideMenuTab {
            case 0:
                VStack {
                    HeaderView(presentSideMenu: $presentSideMenu)
                    
                    Text(verbatim: "NBA Home")
                        .font(.title)
                        .bold()
                        .foregroundColor(.white)
                    Image("nbaLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .frame(width: 176, height: 176)
                        .cornerRadius(88)
                    Text("Welcome to the NBA Home App")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top)
                    Text("Your home to all information NBA")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
            case 1:
                DraftView(presentSideMenu: $presentSideMenu)
            default:
                FreeAgentListView(presentSideMenu: $presentSideMenu)
            }
            
            
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}

struct DraftView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}


struct DraftView: View {
    @Binding var presentSideMenu: Bool
    @StateObject var model: DraftViewModel = DraftViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                if let draft = model.draft {
                    VStack {
                        HeaderView(presentSideMenu: $presentSideMenu)
                        
                        Text(verbatim: "NBA Draft \(draft.draft.year)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                        
                        Text(verbatim: "\(draft.draft.venue.name) \(draft.draft.venue.city), \(draft.draft.venue.state)")
                            .font(.title2)
                            .foregroundColor(.gray)
                        
                        List {
                            ForEach(draft.rounds, id: \.id, content: { round in
                                Section("Round \(round.number)") {
                                    ForEach(round.picks, id: \.id) { pick in
                                        ProspectRowView(round: round, pick: pick)
                                    }
                                }
                            })
                        }
                        .tint(.clear)
                    }
                }
            }
        }
    }
}
