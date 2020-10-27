//
//  NetworkManager.swift
//  Drawer
//
//  Created by Kyle on 10/27/20.
//

import Foundation
import UIKit
import Combine

class NetworkManager {
    static let shareInstance = NetworkManager()
    
    var requests = Set<AnyCancellable>()
    
    func fetch<T:Decodable>(_ url: URL, defaultValue: T, completion: @escaping (T) -> Void){
        let decoder = JSONDecoder()
        URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: decoder)
            .replaceError(with: defaultValue)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &requests)
    }
}
