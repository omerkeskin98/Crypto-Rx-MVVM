//
//  Webservice.swift
//  Crypto-Rx-MVVM
//
//  Created by Omer Keskin on 23.04.2024.
//

import Foundation


public enum cryptoError: Error{
    case serverError
    case parsingError
}

class Webservice{
    
    func fetchCurreny(url: URL, completion: @escaping (Result<[Crypto], cryptoError>) -> ()){
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error{
                completion(.failure(.serverError))
            }
            else if let data = data{
                let cryptoList = try? JSONDecoder().decode([Crypto].self, from: data)
                
                if let cryptoList = cryptoList{
                    completion(.success(cryptoList))
                }
                else{
                    completion(.failure(.parsingError))
                }
            }
        } .resume()
    }
    
}
