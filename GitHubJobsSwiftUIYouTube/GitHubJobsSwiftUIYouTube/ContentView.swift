//
//  ContentView.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/1/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct ContentView: View {
    @State private var locationSearchTerm = ""
    @State private var positionSearchTerm = ""
    @State private var isEditing = false
    @StateObject private var viewModel = JobsViewModel()
    let gridItem = GridItem(.flexible(minimum: 300, maximum: 400), spacing: 5, alignment: .leading)
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    DoubleSearchBarView(positionSearchTerm: $positionSearchTerm, locationSearchTerm: $locationSearchTerm)
                        .onChange(of: positionSearchTerm, perform: { value in
                            if positionSearchTerm != "" {
                                isEditing = true
                            } else {
                                isEditing = false
                            }
                    })
                    if isEditing {
                        Button(action: {
                            viewModel.getJobs(description: positionSearchTerm, location: locationSearchTerm)
                        }, label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(.systemBackground))
                                    .cornerRadius(12)
                                    .shadow(color: Color.blue.opacity(0.3), radius: 6, x: 0.0, y: 6.0)
                                    .frame(width: 45, height: 50)
                                Image(systemName: "doc.text.magnifyingglass")
                                    .font(.largeTitle)
                            }
                        })
                    }
                    
                }
                ScrollView {
                    LazyVGrid(columns: [gridItem]) {
                        if viewModel.jobs.isEmpty {
                            Text("Looking for a job? \nPlease enter job title and location to see what's available. ")
                                .italic()
                                .font(.title)
                                .padding()

                        }
                        ForEach(viewModel.jobs) { job in
                            JobView(job: job, image: WebImage(url: URL(string: job.companyLogo ?? "")), buttonColor: .gray)
                            
                        }
                    }
                }


                
            }

        }

    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
