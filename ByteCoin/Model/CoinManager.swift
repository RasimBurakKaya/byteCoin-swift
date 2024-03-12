//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation
protocol CoinManagerDelegate{
    func updateCurrencyAndRate(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "95538398-4408-416C-ADA6-7E61C3683E75"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String){
        //Use String concatenation to add the selected currency at the end of the baseURL along with the API key.
               let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
               
               //Use optional binding to unwrap the URL that's created from the urlString
               if let url = URL(string: urlString) {
                   
                   //Create a new URLSession object with default configuration.
                   let session = URLSession(configuration: .default)
                   
                   //Create a new data task for the URLSession
                   let task = session.dataTask(with: url) { (data, response, error) in
                       if error != nil {
                           self.delegate?.didFailWithError(error: error!)
                           return
                       }
                       //Format the data we got back as a string to be able to print it.
                       if let safeData = data{
                           DispatchQueue.main.async {
                               if let bitcoinPrice = self.parseJSON(safeData){
                                   let priceString = String(format: "%.2f", bitcoinPrice)
                                   self.delegate?.updateCurrencyAndRate(price: priceString, currency: currency)
                               }
                               
                           }
                       }
                   }
                   //Start task to fetch data from bitcoin average's servers.
                   task.resume()
               }
           }
    
    func parseJSON(_ coinData: Data) -> Double?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
      
    }
    }
   
    
 
    

   
    
  


