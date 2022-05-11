//
//  String+Ex.swift
//  RoViu
//
//  Created by KhuongPham on 27/08/2021.
//

import Foundation

extension String {
    func toFlagUrl() -> String {
        guard let path = Bundle.main.path(forResource: "countries", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
              let jsonResult = try? JSONSerialization.jsonObject(with: data, options: []),
              let countriesJSON = jsonResult as? [[String: String]] else {
                  return "https://flagpedia.net/data/flags/icon/56x42/vn.png"
              }
        for countryJSON in countriesJSON {
            if let countryName = countryJSON["name"], countryName.lowercased() == self.lowercased(), let countryCode = countryJSON["code"]?.lowercased() {
                return "https://flagpedia.net/data/flags/icon/56x42/\(countryCode).png"
            }
        }
        return "https://flagpedia.net/data/flags/icon/56x42/vn.png"
    }
}
