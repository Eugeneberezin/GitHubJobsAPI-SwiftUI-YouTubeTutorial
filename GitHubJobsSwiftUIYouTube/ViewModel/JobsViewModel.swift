//
//  JobsViewModel.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/14/21.
//

import SwiftUI

class JobsViewModel: ObservableObject {
    @Published var jobs = [Job]()
    
    init() {}
    
    func getJobs(description:String, location: String) {
        NetworkManager.shared.getJobs(description: description, location: location) { (result) in
            switch result {
            case .success(let jobs):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.jobs = jobs

                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
