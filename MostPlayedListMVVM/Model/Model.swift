//
//  Model.swift
//  MostPlayedListMVVM
//
//  Created by Furkan Yıldız on 21.03.2022.
//


import Foundation

// MARK: - Album
struct Model: Codable {
    var feed: Feed
}

// MARK: - Feed
struct Feed: Codable {
    var title: String
    var id: String
    var author: Author
    var links: [Link]
    var copyright, country: String
    var icon: String
    var updated: String
    var results: [Result]
}

// MARK: - Author
struct Author: Codable {
    var name: String
    var url: String
}

// MARK: - Link
struct Link: Codable {
    var linkSelf: String

    enum CodingKeys: String, CodingKey {
        case linkSelf = "self"
    }
}

// MARK: - Result
struct Result: Codable {
    var artistName, id, name, releaseDate: String
    var kind: Kind
    var artistID: String?
    var artistURL: String?
    var contentAdvisoryRating: ContentAdvisoryRating?
    var artworkUrl100: String
    var genres: [Genre]
    var url: String

    enum CodingKeys: String, CodingKey {
        case artistName, id, name, releaseDate, kind
        case artistID = "artistId"
        case artistURL = "artistUrl"
        case contentAdvisoryRating, artworkUrl100, genres, url
    }
}

enum ContentAdvisoryRating: String, Codable {
    case explict = "Explict"
}

// MARK: - Genre
struct Genre: Codable {
    var genreID, name: String
    var url: String

    enum CodingKeys: String, CodingKey {
        case genreID = "genreId"
        case name, url
    }
}

enum Kind: String, Codable {
    case albums = "albums"
}
