//
//  GroupsModel.swift
//  seminarCod
//
//  Created by Pavel iPro on 24.07.2023.
//

struct GroupsModel: Decodable {
    var response: Groups
}

struct Groups: Decodable {
    var items: [Group]
}

struct Group: Decodable {
    var id: Int
    var name: String?
    var photo: String?
    var description: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "first_name"
        case photo = "photo_50"
        case description
    }
}

