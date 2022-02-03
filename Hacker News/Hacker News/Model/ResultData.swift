//
//  Result.swift
//  Hacker News
//
//  Created by ran you on 2/2/22.
//

import Foundation

struct Results: Codable{
    let hits:[Post]
}

struct Post: Codable,Identifiable{
    var id:String{
        return objectID
    }
    let points: Int
    let title: String
    let url:String?
    let objectID:String
 
}
