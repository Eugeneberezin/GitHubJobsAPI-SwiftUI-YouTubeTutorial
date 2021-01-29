//
//  SavedJobs.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/28/21.
//

import SwiftUI

struct SavedJobs: View {
    @EnvironmentObject var manager: PersistenceManager
    var body: some View {
        List {
            ForEach(manager.savedItems) { job in
                Text(job.company)
            }
        }
    }
}

struct SavedJobs_Previews: PreviewProvider {
    static var previews: some View {
        SavedJobs()
    }
}
