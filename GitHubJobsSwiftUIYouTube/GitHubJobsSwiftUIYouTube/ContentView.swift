//
//  ContentView.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/1/21.
//

import SDWebImageSwiftUI
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: PersistenceManager
    @State private var locationSearchTerm = ""
    @State private var positionSearchTerm = ""
    @State private var isEditing = false
    @StateObject private var viewModel = JobsViewModel()
    @State private var isAlertShowing = false
    @State private var isNetworkAlertShowing = false
    @State private var isActivityIndicatorShowing = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
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
                            fetchJobs(description: positionSearchTerm, location: locationSearchTerm)
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
                        .alert(isPresented: $isNetworkAlertShowing, content: {
                            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("Ok")))
                        })
                    }
                    
                }
                ScrollView {
                    if isActivityIndicatorShowing {
                        ProgressView()
                            .padding()
                            .progressViewStyle(CircularProgressViewStyle.init(tint: Color(.systemBlue)))
                    }
                    LazyVGrid(columns: [gridItem]) {
                        if viewModel.jobs.isEmpty {
                            VStack {
                                Text("Looking for a job? \nPlease enter job title and location to see what's available. ")
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
                        ForEach(viewModel.jobs) { job in
                            JobView(job: job, image: WebImage(url: URL(string: job.companyLogo ?? "")), buttonColor: manager.savedItems.contains(job) ? Color.yellow : Color.gray)
                            
                        }
                    }
                    .alert(isPresented: $isAlertShowing, content: {
                        Alert(title: Text("No jobs found"), message: Text("We couldn't find any jobs with your criteria, please try different location or position."), dismissButton: .default(Text("Ok")))
                    })

                    
                }


                
            }
            

        }
        .listOnlyView()

    }
    
    private func configureErrorAlert() {
        if viewModel.dataErrorAlert {
            alertTitle = "Something went wrong!"
            if let message = NetworkError.data.errorDescription {
                alertMessage = message
            }
        } else if viewModel.serverErrorAlert {
            alertTitle = "There was a problem with the server."
            if let message = NetworkError.serverError.errorDescription {
                alertMessage = message
            }
        } else if viewModel.somethingWentWrongAlert {
            alertTitle = "Something went wrong"
            alertMessage = "Please try again"
        } else if viewModel.notFoundAlert {
            alertTitle = "Not found"
            if let message = NetworkError.notFound.errorDescription {
                alertMessage = message
            }
            
        }
 
    }
    
    private func fetchJobs(description: String, location: String) {
        isActivityIndicatorShowing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            isNetworkAlertShowing = viewModel.isAlertShowing
            configureErrorAlert()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            viewModel.getJobs(description: description, location: location)
            isActivityIndicatorShowing.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                if !viewModel.jobs.isEmpty {
                    isNetworkAlertShowing = false
                }
                if viewModel.jobs.isEmpty && viewModel.isAlertShowing == false  {
                    isAlertShowing = true
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
