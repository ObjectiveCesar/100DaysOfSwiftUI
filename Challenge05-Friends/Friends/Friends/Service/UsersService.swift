//
//  UserListViewModel.swift
//  Friends
//
//  Created by Lippmann, Erik on 21.12.22.
//

import Foundation

enum DataError: Error {
    case loadingError
    case decodingError
}

struct UsersService {

    func fetchData() async throws -> [User]  {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw DataError.loadingError
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        let users = try decoder.decode([User].self, from: data)

        return users
    }
}
