// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

extension APIRequest {
    static func getGames() -> APIRequest{
        return APIRequest(path: "/games", parameters: [:])
    }
    
    static func searchGames(by query: String) -> APIRequest {
        return APIRequest(path: "/games", parameters: ["search": query])
    }
}

var placeHolderImageURL: URL = URL(string: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg")!

// MARK: - Welcome
struct GamesList: Codable {
    let count: Int?
    let next: String?
    let previous: JSONNull?
    let results: [GameResponse]?
    let seoTitle, seoDescription, seoKeywords, seoH1: String?
    let noindex, nofollow: Bool?
    let welcomeDescription: String?
    let filters: Filters?
    let nofollowCollections: [String]?

    enum CodingKeys: String, CodingKey {
        case count, next, previous, results
        case seoTitle = "seo_title"
        case seoDescription = "seo_description"
        case seoKeywords = "seo_keywords"
        case seoH1 = "seo_h1"
        case noindex, nofollow
        case welcomeDescription = "description"
        case filters
        case nofollowCollections = "nofollow_collections"
    }
}

// MARK: - Filters
struct Filters: Codable {
    let years: [FiltersYear]?
}

// MARK: - FiltersYear
struct FiltersYear: Codable {
    let from, to: Int?
    let filter: String?
    let decade: Int?
    let years: [YearYear]?
    let nofollow: Bool?
    let count: Int?
}

// MARK: - YearYear
struct YearYear: Codable {
    let year, count: Int?
    let nofollow: Bool?
}
