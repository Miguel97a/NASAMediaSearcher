//
//  ContentBuilder.swift
//  Workday Coding
//
//  Created by Miguel Angeles on 6/9/23.
//

import Foundation

final class ContentBuilder {
  
  private lazy var jsonDecoder: JSONDecoder = {
    JSONDecoder()
  }()
  
  func decode(data: Data) throws -> [Content] {
      let apiObjects : Collection = try jsonDecoder.decode(Collection.self, from: data)
      
      return apiObjects.items.map { ContentMapper.map(response: $0) }
  }
  
    // MARK: - Collection
    struct Collection: Codable {
        let version: String
        let href: String
        let items: [Item]
        let metadata: Metadata
        let links: [CollectionLink]
    }

    // MARK: - Item
    struct Item: Codable {
        let href: String
        let data: [Datum]
        let links: [ItemLink]?
    }

    // MARK: - Datum
    struct Datum: Codable {
        let center: Center
        let title, nasaID: String
        let mediaType: MediaType
        let keywords: [String]
        let dateCreated: Date
        let description: String
        let description508, secondaryCreator: String?
        let album: [String]?
        let photographer, location: String?

        enum CodingKeys: String, CodingKey {
            case center, title
            case nasaID = "nasa_id"
            case mediaType = "media_type"
            case keywords
            case dateCreated = "date_created"
            case description
            case description508 = "description_508"
            case secondaryCreator = "secondary_creator"
            case album, photographer, location
        }
    }

    enum Center: String, Codable {
        case hq = "HQ"
        case jpl = "JPL"
        case jsc = "JSC"
    }

    enum MediaType: String, Codable {
        case audio = "audio"
        case image = "image"
        case video = "video"
    }

    // MARK: - ItemLink
    struct ItemLink: Codable {
        let href: String
        let rel: Rel
        let render: MediaType?
    }

    enum Rel: String, Codable {
        case captions = "captions"
        case preview = "preview"
    }

    // MARK: - CollectionLink
    struct CollectionLink: Codable {
        let rel, prompt: String
        let href: String
    }

    // MARK: - Metadata
    struct Metadata: Codable {
        let totalHits: Int

        enum CodingKeys: String, CodingKey {
            case totalHits = "total_hits"
        }
    }

  
}

final class ContentMapper {
  
    class func map(response: ContentBuilder.Item) -> Content {
        Content(href: response.href, dateCreated: response.data[0].dateCreated, title: response.data[0].title, description: response.data[0].description, mediaType: response.data[0].mediaType.rawValue, nasaID: response.data[0].nasaID)
  }
  
}
