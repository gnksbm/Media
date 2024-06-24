//
//  NetworkService.swift
//  Media
//
//  Created by gnksbm on 6/24/24.
//

import Foundation

final class NetworkService {
    private static var taskStorage = [URLRequest: URLSessionTask]()
    
    private init() { }
    
    static func request<T: Decodable>(
        endpoint: EndpointRepresentable,
        _ completionHandler: @escaping (T) -> Void,
        errorHandler: @escaping (Error) -> Void
    ) {
        do {
            let urlRequest = try endpoint.asURLRequest()
            taskStorage[urlRequest]?.cancel()
            let task = URLSession.shared.dataTask(
                with: urlRequest
            ) { data, response, error in
                if let error {
                    errorHandler(NetworkError.requestFailed(error))
                    return
                }
                guard let response else {
                    errorHandler(NetworkError.noResponse)
                    return
                }
                guard let httpURLResponse = response as? HTTPURLResponse
                else {
                    errorHandler(NetworkError.invalidResponseType)
                    return
                }
                guard 200..<300 ~= httpURLResponse.statusCode else { 
                    errorHandler(
                        NetworkError.statusCodeError(
                            statusCode: httpURLResponse.statusCode
                        )
                    )
                    return
                }
                guard let data else { 
                    errorHandler(NetworkError.noData)
                    return
                }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(result)
                } catch {
                    errorHandler(
                        NetworkError.decodingError(type: T.self, error: error)
                    )
                }
            }
            taskStorage[urlRequest] = task
            task.resume()
        } catch {
            errorHandler(error)
        }
    }
}

enum NetworkError: LocalizedError {
    case requestFailed(Error)
    case noResponse
    case invalidResponseType
    case statusCodeError(statusCode: Int)
    case noData
    case decodingError(type: Decodable.Type, error: Error)
    
    var errorDescription: String? {
        switch self {
        case .requestFailed(let error):
            "요청에 실패하였습니다.\n에러: \(error.localizedDescription)"
        case .noResponse:
            "서버로부터 응답을 받지 못했습니다."
        case .invalidResponseType:
            "응답 형식이 유효하지 않습니다."
        case .statusCodeError(let statusCode):
            "잘못된 상태 코드입니다 - \(statusCode)"
        case .noData:
            "데이터를 받지 못했습니다."
        case .decodingError(let type, let error):
            "\(type)으로 디코딩에 실패하였습니다.\n에러: \(error.localizedDescription)"
        }
    }
}
