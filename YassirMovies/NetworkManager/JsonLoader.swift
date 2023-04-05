//
//  JsonLoader.swift
//  YassirMovies
//
//  Created by Adam Essam on 31/03/2023.
//

import Foundation

protocol JsonLoader: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(filename: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void)
}

extension JsonLoader {
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Decodable>(filename: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let path = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("Failed to load JSON file")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            completion(.success(decodedObject))
        } catch {
            completion(.failure(error))
            print("❌" + error.localizedDescription)
            fatalError("Failed to decode the JSON")
            
        }
    }
}
