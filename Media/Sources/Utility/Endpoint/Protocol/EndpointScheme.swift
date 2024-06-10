//
//  EndpointScheme.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

fileprivate enum EndpointScheme: String {
    case http, https, ws
}

protocol HTTPEndpointRepresentable: EndpointRepresentable { }
extension HTTPEndpointRepresentable {
    var scheme: String { EndpointScheme.http.rawValue }
}

protocol HTTPSEndpointRepresentable: EndpointRepresentable { }
extension HTTPSEndpointRepresentable {
    var scheme: String { EndpointScheme.https.rawValue }
}

protocol WSEndpointRepresentable: EndpointRepresentable { }
extension WSEndpointRepresentable {
    var scheme: String { EndpointScheme.ws.rawValue }
}
