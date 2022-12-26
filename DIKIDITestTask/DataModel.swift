//
//  DataModel.swift
//  DIKIDITestTask
//
//  Created by Артем Соколовский on 26.12.2022.
//

import Foundation

// MARK: - DataModel
struct DataModel: Codable {
    let error: ErrorModel
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let title: String
    let image: String
    let catalogCount: String
    let blocks: Blocks
    let order: [String]

    enum CodingKeys: String, CodingKey {
        case title, image
        case catalogCount = "catalog_count"
        case blocks, order
    }
}

// MARK: - Blocks
struct Blocks: Codable {
    let vip: [Vip]
    let shares: Shares
    let examples: String
    let catalog: [Catalog]
}

// MARK: - Catalog
struct Catalog: Codable {
    let id, name: String
    let image: Image
    let street, house: String
    let schedule: [ScheduleElement]
    let lat, lng: String
    let categories: [String] //here was jsonnull
    let rating: Int
    let isMaster: Bool
    let currency: Currency
    let masterID: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image, street, house, schedule, lat, lng, categories, rating, isMaster, currency
        case masterID = "master_id"
    }
}

// MARK: - Currency
struct Currency: Codable {
    let id, title, abbr: String
}

// MARK: - Image
struct Image: Codable {
    let thumb, origin: String
}
/*
enum ScheduleUnion: Codable {
    case bool(Bool)
    case scheduleElementArray([ScheduleElement])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Bool.self) {
            self = .bool(x)
            return
        }
        if let x = try? container.decode([ScheduleElement].self) {
            self = .scheduleElementArray(x)
            return
        }
        throw DecodingError.typeMismatch(ScheduleUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ScheduleUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .bool(let x):
            try container.encode(x)
        case .scheduleElementArray(let x):
            try container.encode(x)
        }
    }
}
*/
// MARK: - ScheduleElement
struct ScheduleElement: Codable {
    let day, workFrom, workTo: String

    enum CodingKeys: String, CodingKey {
        case day
        case workFrom = "work_from"
        case workTo = "work_to"
    }
}

// MARK: - Shares
struct Shares: Codable {
    let list: [ListModel]
    let count: String
}

// MARK: - List
struct ListModel: Codable {
    let id, name, timeStart, timeStop: String
    let discountValue, view, usedCount, companyID: String
    let icon: String
    let companyName, companyStreet, companyHouse: String
    let companyImage: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case timeStart = "time_start"
        case timeStop = "time_stop"
        case discountValue = "discount_value"
        case view
        case usedCount = "used_count"
        case companyID = "company_id"
        case icon
        case companyName = "company_name"
        case companyStreet = "company_street"
        case companyHouse = "company_house"
        case companyImage = "company_image"
    }
}

// MARK: - Vip
struct Vip: Codable {
    let id: String
    let image: Image
    let name: String
    let categories: [String]
}

// MARK: - Error
struct ErrorModel: Codable {
    let code: Int
    let message: String
}
