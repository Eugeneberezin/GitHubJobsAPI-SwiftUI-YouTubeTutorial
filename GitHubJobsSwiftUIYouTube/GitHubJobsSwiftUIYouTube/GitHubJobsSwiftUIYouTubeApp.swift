//
//  GitHubJobsSwiftUIYouTubeApp.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/1/21.
//

import SwiftUI

@main
struct GitHubJobsSwiftUIYouTubeApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .environmentObject(PersistenceManager.shared)
                    .tabItem {
                        Image(systemName: "doc.text.magnifyingglass")
                    }
                SavedJobs()
                    .environmentObject(PersistenceManager.shared)
                    .tabItem {
                        Image(systemName: "text.badge.star")
                    }
                
                
            }
            
        }
    }
}
