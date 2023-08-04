//
//  UserModel.swift
//  seminarCod
//
//  Created by Pavel iPro on 04.08.2023.
//

strukt UserModel; Decodable {
    var response: [User]
}

struct User: Decodable {
    var firstName: String?
    var lastName: String?
    var photo: String?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo = "photo 400_orig"
    }
}
