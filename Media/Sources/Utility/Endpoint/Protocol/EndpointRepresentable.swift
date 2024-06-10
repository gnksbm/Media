//
//  EndpointRepresentable.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

import Alamofire

protocol EndpointRepresentable: URLConvertible, URLRequestConvertible {
    var httpMethod: HTTPMethod { get }
    var scheme: String { get }
    var host: String { get }
    var port: Int? { get }
    var path: String { get }
    var queries: [String: String]? { get }
    var header: [String : String]? { get }
    var body: [String: any Encodable]? { get }
}

extension EndpointRepresentable {
    var port: Int? { nil }
    var queries: [String: String]? { nil }
    var header: [String : String]? { nil }
    var body: [String: any Encodable]? { nil }
    
    private var toURLRequest: URLRequest? {
        guard let url = toURL else { return nil }
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = header
        request.httpMethod = httpMethod.rawValue
        if let body {
            let httpBody = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = httpBody
        }
        return request
    }
    
    private var toURL: URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.port = port
        components.queryItems = queries?.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        return components.url
    }
}

// MARK: Alamofire
extension EndpointRepresentable {
    func asURL() throws -> URL {
        guard let toURL else { throw EndpointError.invalidURLRequest }
        return toURL
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let toURLRequest else { throw EndpointError.invalidURLRequest }
        return toURLRequest
    }
}
