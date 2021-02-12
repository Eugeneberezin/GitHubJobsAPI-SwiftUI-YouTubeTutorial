//
//  SavedJobs.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/28/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct SavedJobs: View {
    @EnvironmentObject var manager: PersistenceManager
    @State var searchTerm = ""
    let gridItem = GridItem(.flexible(minimum: 300, maximum: 400), spacing: 5, alignment: .leading)
    var body: some View {
        NavigationView {
            VStack {
                SearchBarView(text: $searchTerm, placeHolder: "Job title")
                ScrollView {
                    LazyVGrid(columns: [gridItem]) {
                        if manager.savedItems.isEmpty {
                            VStack {
                                Text("No saved jobs yet.")
                                    .italic()
                                    .font(.title)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 400, height: 200, alignment: .center)
                            .background(Color(.systemBlue))
                            .cornerRadius(12)
                            .shadow(color: Color.black.opacity(0.6), radius: 6, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 3.0)
                            .shadow(color: Color.black.opacity(0.5), radius: 4, x: 0, y: 0.2)

                            

                        }
                        ForEach(manager.savedItems.filter {"\($0)".contains(searchTerm.lowercased()) || searchTerm.isEmpty}) { job in
                            JobView(job: job, image: WebImage(url: URL(string: job.companyLogo ?? "")), buttonColor: manager.savedItems.contains(job) ? Color.yellow : Color.gray)
                            
                        }
                    }
                }
                
            }
        }
        .listOnlyView()
    }
}

struct SavedJobs_Previews: PreviewProvider {
    static var previews: some View {
        SavedJobs()
    }
}
