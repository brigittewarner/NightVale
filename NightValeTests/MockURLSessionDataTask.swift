//
//  MockURLSessionDataTask.swift
//  NightValeTests
//
//  Created by Brigitte Warner on 9/25/18.
//  Copyright © 2018 Brigitte Warner. All rights reserved.
//

import Foundation

protocol MockURLSessionDataTask {
    func resume()
}

extension URLSessionDataTask: MockURLSessionDataTask {}
