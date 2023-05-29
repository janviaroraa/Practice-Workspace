//
//  DataModel.swift
//  Practice Workspace
//
//  Created by Powerplay on 29/05/23.
//

import Foundation

struct RootResults: Codable {
    var results: [Results]
}


struct Results: Codable {
    var container_number: String?
    var commodities: [Commodities]
}


struct Commodities: Codable {
    var commodity_name_en: String?
    var varieties: [Varieties]
}


struct Varieties: Codable {
    var variety_name_en: String?
    var variety_name_ar: String?
}
