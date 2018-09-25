//
//  MockURLSession.swift
//  NightValeTests
//
//  Created by Brigitte Warner on 9/25/18.
//  Copyright © 2018 Brigitte Warner. All rights reserved.
//

import Foundation

struct MockHTTPClient {
    let session: MockURLSession
    
    init(session: MockURLSession = URLSession.shared) {
        self.session = session
    }
    
    func get(_ route: Route, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let url = URL(string: route.rawValue) else { return }
        let task = session.dataTask(with: url,completionHandler: completion)
        task.resume()
    }
}

extension MockHTTPClient {
    enum Route: String {
        case base = "https://api.darksky.net/"
        case forecast = "https://api.darksky.net/forecast/02329f5cf787aca05a365cbcea9ac304/32.6115,116.8832"
    }
}

protocol MockURLSession {
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
                  -> MockURLSessionDataTask
}

extension URLSession: MockURLSession {
    func dataTask(with url: URL,
                  completionHandler: @escaping (Data?, URLResponse?,Error?) -> Void)
                  -> MockURLSessionDataTask {
                    return dataTask(with: url, completionHandler: completionHandler)
                      as URLSessionDataTask as MockURLSessionDataTask
    }
}
