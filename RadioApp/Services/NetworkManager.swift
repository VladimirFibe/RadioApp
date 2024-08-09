//
//  NetworkManager.swift
//  RadioApp
//
//  Created by Елена Логинова on 08.08.2024.
//

import Foundation

enum APIEndpoint {
    enum link {
        case base
        case allStations
        case popular
        case station
        case countries
        case languages
        case tags
        case seach
        
        var url: String {
            switch self {
            case .base:
                return "https://de1.api.radio-browser.info/json/"
            case .allStations:
                return "stations"
            case .popular:
                return "/topvote"
            case .station:
                return "/byuuid/"
            case .countries:
                return "countries"
            case .languages:
                return "languages"
            case .tags:
                return "tags"
            case .seach:
                return "/search?name="
            }
        }
    }
        
        case popularRadioURL(limit: Int, offset: Int)
        case allRadioStations(limit: Int, offset: Int)
        case oneStationURL(uuid: String)
        case countriesURL(limit: Int, offset: Int)
        case languagesURL(limit: Int, offset: Int)
        case tagsURL(limit: Int, offset: Int)
        case searchURL(guery: String, limit: Int, offset: Int)
        
        
        var url: URL {
            switch self {
                
            case .allRadioStations(limit: let limit, offset: let offset):
                return URL(string: "\(link.base.url)\(link.allStations.url)?limit=\(limit)&offset=\(offset)")!
            case .popularRadioURL(limit: let limit, offset: let offset):
                return URL(string: "\(link.base.url)\(link.allStations.url)\(link.popular.url)?limit=\(limit)&offset=\(offset)")!
            case .oneStationURL(uuid: let uuid):
                return URL(string: "\(link.base.url)\(link.allStations.url)\(link.station.url)\(uuid)")!
            case .countriesURL(limit: let limit, offset: let offset):
                return URL(string: "\(link.base.url)\(link.countries.url)?limit=\(limit)&offset=\(offset)")!
            case .languagesURL(limit: let limit, offset: let offset):
                return URL(string: "\(link.base.url)\(link.languages.url)?limit=\(limit)&offset=\(offset)")!
            case .tagsURL(limit: let limit, offset: let offset):
                return URL(string: "\(link.base.url)\(link.tags.url)?limit=\(limit)&offset=\(offset)")!
            case .searchURL(guery: let query, limit: let limit, offset: let offset):
                return URL(string: "\(link.base.url)\(link.allStations.url)\(link.seach.url)\(query)&limit=\(limit)&offset=\(offset)")!
            }
        }
    }


enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}


struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping(Result<Data, NetworkError>) -> Void) {
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                completion(.failure(.noData))
                return
            }
            
            do {
                let dataModel = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(dataModel))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

