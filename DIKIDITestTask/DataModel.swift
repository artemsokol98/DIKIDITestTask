//
//  DataModel.swift
//  DIKIDITestTask
//
//  Created by Артем Соколовский on 26.12.2022.
//

import Foundation

// MARK: - DataModel
struct DataModel: Decodable {
    let error: ErrorModel?
    let data: DataClass?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        print(container)
        error = try container.decode(ErrorModel?.self, forKey: .error)
        print(error)
        data = try container.decode(DataClass?.self, forKey: .data)
        print(data)
    }
    
    enum CodingKeys: String, CodingKey {
        case error, data
    }
    /*
    init(from decoder: Decoder) throws {
        let container = try decoder.container
        print(container)
        error = try container.decode(ErrorModel.self, forKey: .error)
        print(error)
        data = try container.decode(DataClass.self, forKey: .data)
        print(data)
    }
     */
}

// MARK: - DataClass
struct DataClass: Codable {
    let title: String?
    let image: String?
    let catalogCount: String?
    let blocks: Blocks?
    let order: [String]?

    enum CodingKeys: String, CodingKey {
        case title, image
        case catalogCount = "catalog_count"
        case blocks, order
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        print(container)
        title = try container.decode(String?.self, forKey: .title)
        print(title)
        image = try container.decode(String?.self, forKey: .image)
        print(image)
        catalogCount = try container.decode(String?.self, forKey: .catalogCount)
        print(catalogCount)
        blocks = try container.decode(Blocks?.self, forKey: .blocks)
        print(blocks)
        order = try container.decode([String]?.self, forKey: .order)
        print(order)
    }
}

// MARK: - Blocks
struct Blocks: Codable {
    let vip: [Vip]?
    let shares: Shares?
    let examples: String?
    let catalog: [Catalog]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        print(container)
        vip = try container.decode([Vip]?.self, forKey: .vip)
        print(vip)
        shares = try container.decode(Shares?.self, forKey: .shares)
        print(shares)
        examples = try container.decode(String?.self, forKey: .examples)
        print(examples)
        catalog = try container.decode([Catalog]?.self, forKey: .catalog)
        print(catalog)
    }
    
    enum CodingKeys: String, CodingKey {
        case vip, shares, examples, catalog
    }
}

// MARK: - Catalog
struct Catalog: Codable {
    let id, name: String?
    let image: Image?
    let street, house: String?
    let schedule: ScheduleSwitch?
    let lat, lng: String?
    let categories: [String]? //here was jsonnull
    let rating: Int?
    let isMaster: Bool?
    let currency: Currency?
    let masterID: String?

    enum CodingKeys: String, CodingKey {
        case id, name, image, street, house, schedule, lat, lng, categories, rating, isMaster, currency
        case masterID = "master_id"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        print(container)
        id = try container.decode(String?.self, forKey: .id)
        print(id)
        name = try container.decode(String?.self, forKey: .name)
        print(name)
        image = try container.decode(Image?.self, forKey: .image)
        print(image)
        street = try container.decode(String?.self, forKey: .street)
        print(street)
        house = try container.decode(String?.self, forKey: .house)
        print(house)
        schedule = try container.decodeIfPresent(ScheduleSwitch.self, forKey: .schedule)
        print(schedule)
        lat = try container.decode(String?.self, forKey: .lat)
        print(lat)
        lng = try container.decode(String?.self, forKey: .lng)
        print(lng)
        categories = try container.decode([String]?.self, forKey: .categories)
        print(categories)
        rating = try container.decode(Int?.self, forKey: .rating)
        print(rating)
        isMaster = try container.decode(Bool?.self, forKey: .isMaster)
        print(isMaster)
        currency = try container.decode(Currency?.self, forKey: .currency)
        print(currency)
        masterID = try container.decodeIfPresent(String.self, forKey: .masterID)
        print(masterID)
    }
}

// MARK: - Currency
struct Currency: Codable {
    let id, title, abbr: String?
}

// MARK: - Image
struct Image: Codable {
    let thumb, origin: String?
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
    let day, workFrom, workTo: String?

    enum CodingKeys: String, CodingKey {
        case day
        case workFrom = "work_from"
        case workTo = "work_to"
    }
}

enum ScheduleSwitch: Codable {
    case bool(Bool)
    case schedule([ScheduleElement])
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let bool = try? container.decode(Bool.self) {
            self = .bool(bool)
        } else if let schedule = try? container.decode([ScheduleElement].self) {
            self = .schedule(schedule)
        } else {
            let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Unknown type")
                    throw DecodingError.dataCorrupted(context)
        }
    }
}

// MARK: - Shares
struct Shares: Codable {
    let list: [ListModel]?
    let count: String?
}

// MARK: - List
struct ListModel: Codable {
    let id, name, timeStart, timeStop: String?
    let discountValue, view, usedCount, companyID: String?
    let icon: String?
    let companyName, companyStreet, companyHouse: String?
    let companyImage: String?

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
    let id: String?
    let image: Image?
    let name: String?
    let categories: [String]?
}

// MARK: - Error
struct ErrorModel: Codable {
    let code: Int?
    let message: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        code = try container.decode(Int?.self, forKey: .code)
        print(code)
        message = try container.decode(String?.self, forKey: .message)
        print(message)
    }
    
    enum CodingKeys: String, CodingKey {
        case code
        case message
    }
}
