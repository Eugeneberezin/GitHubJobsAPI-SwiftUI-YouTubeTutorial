//
//  Job.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/8/21.
//

import Foundation

struct Job: Codable, Identifiable, Equatable {
    var id = UUID()
    var type: String?
    var url: String?
    var createdAt: String?
    var company: String
    var companyUrl: String?
    var location: String?
    var title: String
    var description: String?
    var howToApply: String?
    var companyLogo: String?
}
