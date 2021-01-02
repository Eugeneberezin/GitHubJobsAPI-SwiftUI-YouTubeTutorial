//
//  ContentView.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/1/21.
//

import SwiftUI

struct ContentView: View {
    @State private var locationSearchTerm = ""
    @State private var positionSearchTerm = ""
    @State private var isEditing = false
    
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
                            //add code later
                        }, label: {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(Color(.systemBackground))
                                    .cornerRadius(12)
                                    .shadow(color: Color.blue.opacity(0.3), radius: 6, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 6.0)
                                    .frame(width: 45, height: 50)
                                Image(systemName: "doc.text.magnifyingglass")
                                    .font(.largeTitle)
                            }
                        })
                    }
                    
                       
                       
                    
                }
                Spacer()

                
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
