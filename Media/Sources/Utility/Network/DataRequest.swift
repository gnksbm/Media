//
//  DataRequest.swift
//  Media
//
//  Created by gnksbm on 7/1/24.
//

import Foundation

protocol DataRequest: AnyObject {
    var bufferSize: Int { get set }
    
    func didReceive(data: Data)
    func didReceive(error: Error)
    func finish()
}

final class AnyDataRequest<T: Decodable> {
    var bufferSize: Int = 0
    
    let task: URLSessionTask?
    
    private var buffer: Data?
    private var onNextEvent: ((T) -> Void)?
    private var onErrorEvent: ((Error) -> Void)?
    private var onCompleteEvent: (() -> Void)?
    
    init(task: URLSessionTask?) {
        self.task = task
    }
    
    func decode<Item: Decodable>(
        type: Item.Type
    ) -> AnyDataRequest<Item> {
        let request = AnyDataRequest<Item>(task: task)
        if let task {
            NetworkService.shared.replaceRequest(
                task: task,
                request: request
            )
        }
        return request
    }
    
    @discardableResult
    func receive(
        onNext: @escaping (T) -> Void,
        onError: @escaping (Error) -> Void = { _ in },
        onComplete: @escaping () -> Void = { }
    ) -> Self {
        task?.resume()
        onNextEvent = onNext
        onErrorEvent = onError
        onCompleteEvent = onComplete
        return self
    }
    
    func cancel() {
        onNextEvent = nil
        onErrorEvent = nil
        onCompleteEvent = nil
        task?.cancel()
    }
    
    @discardableResult
    func logRetainCount(
        file: String = #fileID,
        line: Int = #line,
        function: String = #function
    ) -> Self {
        return self
    }
}

extension AnyDataRequest: DataRequest {
    func didReceive(data: Data) {
        if data.count < bufferSize {
            if buffer == nil {
                buffer = data
            } else {
                buffer?.append(data)
            }
        } else {
            if let data = data as? T {
                onNextEvent?(data)
            } else {
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    self.onNextEvent?(result)
                } catch {
                    didReceive(error: error)
                }
            }
        }
    }
    
    func didReceive(error: Error) {
        onErrorEvent?(error)
    }
    
    func finish() {
        onCompleteEvent?()
        if let task {
            NetworkService.shared.removeRequest(task: task)
        }
    }
}
