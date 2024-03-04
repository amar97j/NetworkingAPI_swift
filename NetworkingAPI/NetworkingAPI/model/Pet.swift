//
//  Pet.swift
//  NetworkingAPI
//
//  Created by Amora J. F. on 04/03/2024.
//

import Foundation

struct Pet: Codable{
    let id: Int
    let name: String
    let gender: String
    let adopted: Bool
    let age: Int
    let image: String
    
}
