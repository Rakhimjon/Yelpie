//
//  Config.swift
//  RxMovie
//
//  Created by Khuong Pham on 2/28/17.
//  Copyright © 2017 fantageek. All rights reserved.
//

import UIKit

struct Config {
    static let shared: Config = Config()

    let apiKey = "GKlmrTvDUiPI-z0RLcFFUYhTEiLEf0vw3LZYfimNl4U1gi4Snsj10h49iYAIPTLUb0osFfdKA7WFiEv5GmOiTdF6w5Mvpgd3iGLnYoUConhYJzlzphGomTpLXRR7YnYx"
    let baseURL = URL(string: "https://api.yelp.com/v3/")!
}
