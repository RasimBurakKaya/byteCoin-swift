//
//  CoinData.swift
//  ByteCoin
//
//  Created by Rasim Burak Kaya on 25.10.2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CoinData: Codable{
    let asset_id_base: String
    let asset_id_quote: String
    let rate: Double
    
    var rateString: String{
        let string = String(format: "%.1f", rate)
        return string
    }
}


