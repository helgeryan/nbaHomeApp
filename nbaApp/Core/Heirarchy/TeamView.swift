//
//  TeamView.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/1/23.
//

import Foundation
import SwiftUI

class TeamViewModel: ObservableObject {
    @Published var team: Team
    
    init(team: Team) {
        self.team = team
    }
    
    func fetchTeam() {
        NBAService().getTeam(teamId: team.id, completion: { teamResponse in
            if let teamResponse = teamResponse {
                self.team = teamResponse
            }
        })
    }
}

struct TeamView: View {
    @StateObject var model: TeamViewModel
    
    var body: some View {
        let foregroundColor = Color(hex: model.team.team_colors?[0].hex_color ?? "000000")
        let backgroundColor = Color(hex: model.team.team_colors?[1].hex_color ?? "FFFFFF")
        HStack {
            Spacer()
            VStack(spacing: 0) {
                Image(model.team.name)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 176, height: 176)
                    .clipped()
                    .cornerRadius(88)
                Text("\(model.team.market) \(model.team.name)")
                    .foregroundColor(foregroundColor)
                    .font(.title)
                    .bold()
                    .padding(4)
                if let venue = model.team.venue {
                    Text("\(venue.name) \(venue.city), \(venue.state)")
                        .foregroundColor(foregroundColor)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                
                if let conference = model.team.conference {
                    Text(conference.name)
                        .foregroundColor(foregroundColor)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                
                if let division = model.team.division {
                    Text(division.name)
                        .foregroundColor(foregroundColor)
                        .font(.system(size: 16))
                        .fontWeight(.semibold)
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                }
                
                List {
                    Section(content: {
                        ForEach(model.team.getRosterSorted(), id: \.id) { player in
                            NavigationLink(destination: {
                                FreeAgentView(freeAgent: player)
                            }, label: {
                                HStack {
                                    Text(player.jersey_number ?? "00")
                                    Text(player.getName() + " \u{2022} " + player.position)
                                    Spacer()
                                }
                            })
                        }
                    }, header: {
                        HStack {
                            Text("Players")
                                .foregroundColor(foregroundColor)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    })
                    
                    Section(content: {
                        ForEach(model.team.coaches ?? [], id: \.id) { coach in
                            Text(coach.full_name)
                        }
                    }, header: {
                        HStack {
                            Text("Coaches")
                                .foregroundColor(foregroundColor)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .multilineTextAlignment(.center)
                            Spacer()
                        }
                    })
                }
                .scrollContentBackground(.hidden)
                Spacer()
            }
            Spacer()
        }
        .onAppear {
            model.fetchTeam()
        }
        .background(backgroundColor)
    }
}
