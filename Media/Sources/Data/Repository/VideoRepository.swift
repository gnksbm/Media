//
//  VideoRepository.swift
//  Media
//
//  Created by gnksbm on 7/1/24.
//

import Foundation

final class VideoRepository {
    private init() { }
    
    static func callRequest(
        request: VideoRequest,
        onNext: @escaping (VideoResponse) -> Void,
        onError: @escaping (Error) -> Void = { _ in },
        onComplete: @escaping () -> Void = { },
        onProgress: @escaping (Double) -> Void = { _ in }
    ) -> AnyDataRequest<VideoResponse> {
        NetworkService.shared.request(
            endpoint: VideoEndpoint(request: request)
        )
        .decode(type: VideoResponse.self)
        .receive(
            onNext: onNext,
            onError: onError,
            onComplete: onComplete
        )
        .onProgress(onProgress)
    }
}

