//
//  APIClient.swift
//  KumuChallenge
//
//  Created by Zairah Ylagan on 2/10/22.
//

import RxSwift

// TODO: - Move to new file
struct Resource {
    let urlString: String
    let method: String = "GET" //TODO, define methods
    let param: DictionaryEncodable?
}

enum APIClientError: Error {
    case noData
    case internalError(msg: String)
    case serviceError(msg: String)
    
}

extension URLRequest {
    
    init(_ resource: Resource) {
        var components = URLComponents(string: resource.urlString)!
        
        if let param = resource.param, let paramDictionary = param.dictionary() {
            components.queryItems = paramDictionary.map({ URLQueryItem(name: $0.key, value: $0.value) })

        }
        
        self.init(url: components.url!)
        self.httpMethod = resource.method
    }
    
}

final class APIClient {
    
    func load(_ resource: Resource) -> Observable<Data> {
        let request = URLRequest(resource)
        
        return URLSession.shared.rx.data(request: request)
    }
    
}

protocol DictionaryEncodable: Encodable {}

extension DictionaryEncodable {
    func dictionary() -> [String: String]? {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        guard let json = try? encoder.encode(self),
            let dict = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: String] else {
                return nil
        }
        return dict
    }
}
