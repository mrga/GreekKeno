//
//  NetworkController.swift
//  GK
//
//  Created by Branislav Mrganic on 29.6.24..
//

import Foundation


class NetworkController: NetworkControllable {

    // MARK: Enums
    
    enum NetworkError: LocalizedError {
        
        // MARK: Cases
        
        case invalidRequest
        case unableToParseResponse
        case noDataReceived
        case custtom(String)

        
        // MARK: Public Properties
        
        var errorDescription: String? {
            switch self {
            case .invalidRequest:
                return String(localized: "Invalid request, please try again.")
            case .unableToParseResponse:
                return String(localized: "Unable to parse response from server, please try again.")
            case .noDataReceived:
                return String(localized: "No data received.")
            case .custtom(let message):
                return message
            }
        }
    }
}

extension NetworkController {
    
    func loadUpcamingDrawData(gameId: Int, upcoming: Int, completion: @escaping NetworkCompletion.LoadUpcamingDrawDataCompletion) {
        guard let url = URL(string: Endpoints.WebAPI.upcomingDraws(gameId: gameId, upcoming: upcoming)) else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.custtom(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noDataReceived))
                return
            }
            
            do {
                let drawData = try JSONDecoder().decode([DrawData].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(drawData))
                }
            } catch {
                completion(.failure(NetworkError.unableToParseResponse))
            }
        }.resume()
    }
    
    func loadPastDrwas(gameid: Int, from: String, to: String, completion: @escaping NetworkCompletion.LoadPastDrawsCompletion) {
        guard let url = URL(string: Endpoints.WebAPI.pastDraws(gameId: gameid, fromDate: from, toDate: to)) else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.custtom(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noDataReceived))
                return
            }
            
            do {
                let pastDraws = try JSONDecoder().decode(PastDraws.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(pastDraws))
                }
            } catch {
                completion(.failure(NetworkError.unableToParseResponse))
            }
        }.resume()
    }
}
