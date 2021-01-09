//
//  NetworkManager.swift
//  GitHubJobsSwiftUIYouTube
//
//  Created by Eugene Berezin on 1/8/21.
//

import Foundation

enum NetworkError: LocalizedError {
    case response
    case data
    case decoding
    case invalidURL
    case notFound
    case serverError
    
    var errorDescription: String? {
        switch self {
        case .response:
            return "Something went wrong. Please try again"
        case .data:
            return "There was a problem with your request. Please try again"
        case .decoding:
            return "Something went wrong. Please try again"
        case .invalidURL:
            return "Sorry we couldn't find anything. Please try a different search search phrase"
        case .notFound:
            return "Sorry we couldn't find what you're looking for"
        case .serverError:
            return "Something went wrong please try again"
        }
    }
}

enum JobSearchEndPoint {
    case getJobs(description: String, location: String)
    
    var path: String {
        switch self {
        case .getJobs(description: let description, location: let location):
            return "positions.json?description=\(description)&location=\(location)"
        }
    }
    
    var url: URL? {
        let scheme = "https://"
        let domain = "jobs.github.com/"
        
        switch self {
        case .getJobs(description: _, location: _):
            return URL(string: "\(scheme)\(domain)\(path)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
        }
    }
}

class NetworkManager {
    static let shared = NetworkManager()
    
    func getJobs(description: String, location: String, completed: @escaping (Result<[Job], NetworkError>) -> Void) {
        
        
        guard let url = JobSearchEndPoint.getJobs(description: description, location: location).url else {
            completed(.failure(.invalidURL))
            return
        }

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let _ = error {
                    completed(.failure(.serverError))
                    
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completed(.failure(.response))
                    return
                }
                
                guard let data = data else {
                    completed(.failure(.data))
                    return
                }
                
                do {
                    let deconder = JSONDecoder()
                    deconder.keyDecodingStrategy = .convertFromSnakeCase
                    deconder.dateDecodingStrategy = .iso8601
                    let results = try deconder.decode([Job].self, from: data)
                    completed(.success(results))
                    
                } catch {
                    completed(.failure(.decoding))
                    print(error)
                }
            }
            task.resume()
            
            
            
        }
}
