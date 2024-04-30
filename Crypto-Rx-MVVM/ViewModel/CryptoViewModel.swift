//
//  CryptoViewModel.swift
//  Crypto-Rx-MVVM
//
//  Created by Omer Keskin on 23.04.2024.
//

import Foundation
import RxSwift
import RxCocoa


class CryptoViewModel{
    
    public let cryptos: PublishSubject<[Crypto]> = PublishSubject()
    public let error: PublishSubject<String> = PublishSubject()
    public let loading: PublishSubject<Bool> = PublishSubject()
    
    
   public func requestData(){
        self.loading.onNext(true)
        Webservice().fetchCurreny(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!) { (result) in
            self.loading.onNext(false)
            
            switch result{
            case .success(let cryptos):
                self.cryptos.onNext(cryptos)
                
            case .failure(let failure):
                switch failure{
                case .parsingError:
                    self.error.onNext("Parsing Error")
                case .serverError:
                    self.error.onNext("Server Error")
                }
            }
        }
    }
    
}
