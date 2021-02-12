//
//  JobsViewModel.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/14/21.
//

import SwiftUI

class JobsViewModel: ObservableObject {
    @Published var jobs = [Job]()
    @Published var isAlertShowing = false
    var dataErrorAlert = false
    var somethingWentWrongAlert = false
    var serverErrorAlert = false
    var notFoundAlert = false
    
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
                DispatchQueue.main.async {[weak self] in
                    guard let self = self else {return}
                    switch error {
                    case .data:
                        self.dataErrorAlert = true
                        self.isAlertShowing = true
                    case .invalidURL:
                        self.somethingWentWrongAlert = true
                        self.isAlertShowing = true
                    case .serverError:
                        self.serverErrorAlert = true
                        self.isAlertShowing = true
                    case .notFound:
                        self.notFoundAlert = true
                        self.isAlertShowing = true
                    default:
                        self.somethingWentWrongAlert = true
                        self.isAlertShowing = true
                    }
                }
                
            }
        }
    }
    
}
