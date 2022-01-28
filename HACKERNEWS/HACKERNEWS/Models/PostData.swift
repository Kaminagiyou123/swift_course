//
//  PostData.swift
//  HACKERNEWS
//
//  Created by ran you on 1/27/22.
//

import Foundation

struct Results:Decodable{
    let hits:[Post]
}

struct Post:Decodable,Identifiable {
    var id: String {
           return objectID
       }
       let objectID: String
       let points: Int
       let title: String
       let url: String?
}
