//
//  NetworkService.swift
//  Media
//
//  Created by gnksbm on 6/24/24.
//

import Foundation

final class NetworkService: NSObject {
    static let shared = NetworkService()
    
    private var requestStorage = [Int: DataRequest]()
    
    lazy var session = URLSession(
        configuration: .default,
        delegate: NetworkService.shared,
        delegateQueue: .main
    )
    
    private override init() { }
    
    func request(
        endpoint: EndpointRepresentable
    ) -> AnyDataRequest<Data> {
        do {
            let urlRequest = try endpoint.asURLRequest()
            let task = session.dataTask(with: urlRequest)
            return makeRequest(task: task)
        } catch {
            let request = AnyDataRequest<Data>(task: nil)
            request.didReceive(error: error)
            return request
        }
    }
    
    func makeRequest(task: URLSessionTask) -> AnyDataRequest<Data> {
        let request = AnyDataRequest<Data>(task: task)
        requestStorage[task.taskIdentifier] = request
        return request
    }
    
    func getRequest(task: URLSessionTask) -> DataRequest? {
        requestStorage[task.taskIdentifier]
    }
    
    func replaceRequest(task: URLSessionTask, request: DataRequest) {
        requestStorage[task.taskIdentifier] = request
    }
    
    func removeRequest(task: URLSessionTask) {
        requestStorage.removeValue(forKey: task.taskIdentifier)
    }
}

extension NetworkService: URLSessionDataDelegate {
    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive response: URLResponse
    ) async -> URLSession.ResponseDisposition {
        getRequest(task: dataTask)?.bufferSize =
        Int(response.expectedContentLength)
        return .allow
    }
    
    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive data: Data
    ) {
        getRequest(task: dataTask)?.didReceive(data: data)
    }
    
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didCompleteWithError error: (any Error)?
    ) {
        let request = getRequest(task: task)
        if let error {
            request?.didReceive(error: error)
        } else {
            request?.finish()
        }
    }
}
