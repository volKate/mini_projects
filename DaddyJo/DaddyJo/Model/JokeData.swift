//
//  JokeData.swift
//  DaddyJo
//
//  Created by Kate Volkova on 10.08.22.
//

import Foundation

struct JokeData: Decodable {
    let joke: String?
    let results: [Result]?
}

struct Result: Decodable {
    let id: String
    let joke: String
}
