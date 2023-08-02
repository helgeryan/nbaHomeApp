//
//  NBARouter.swift
//  nbaApp
//
//  Created by Ryan Helgeson on 8/2/23.
//

import Foundation
import Alamofire

protocol NBARouter {
    var method: HTTPMethod { get }
    var path: String { get }
    var baseUrl: String { get }
    var parameters: [String: Any] { get }
    var authHeader: HTTPHeaders? { get }
    var parameterEncoding: ParameterEncoding { get }
    var mockDataFileName: String { get }
}
