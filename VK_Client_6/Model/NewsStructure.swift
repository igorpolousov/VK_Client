//
//  NewsStructure.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import Foundation
import UIKit

var newsGroup = [NewsGroup]()
var newsPost = [ResponseItem]()


import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct NewsContainer: Codable {
    let response: NewsResponse
}

// MARK: - Response
struct NewsResponse: Codable {
    let items: [ResponseItem]
    let groups: [NewsGroup] // аватарка и назвние группы
    let profiles: [Profile]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct NewsGroup: Codable {
    let id: Int
    let photo100, photo50, photo200: String
    let type, screenName, name: String
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case id
        case photo100 = "photo_100"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

// MARK: - ResponseItem
struct ResponseItem: Codable {
    let donut: Donut?
    let comments: Comments?
    let isFavorite: Bool?
    let shortTextRate: Double?
    let likes: PurpleLikes?
    let reposts: Comments?
    let type: PostTypeEnum
    let postType: PostTypeEnum?
    let carouselOffset: Int?
    let date, sourceID: Int
    let text: String?
    let attachments: [Attachment]?
    let postID: Int
    let markedAsAds: Int?
    let views: Comments?
    let canSetCategory, canDoubtCategory: Bool?
    let photos: Photos?
    let categoryAction: CategoryAction?

    enum CodingKeys: String, CodingKey {
        case donut, comments
        case isFavorite = "is_favorite"
        case shortTextRate = "short_text_rate"
        case likes, reposts, type
        case postType = "post_type"
        case carouselOffset = "carousel_offset"
        case date
        case sourceID = "source_id"
        case text, attachments
        case postID = "post_id"
        case markedAsAds = "marked_as_ads"
        case views
        case canSetCategory = "can_set_category"
        case canDoubtCategory = "can_doubt_category"
        case photos
        case categoryAction = "category_action"
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: AttachmentType
    let doc: Doc?
    let link: Link?
    let video: AttachmentVideo?
    let photo: LinkPhoto?
    let poll: Poll?
}

// MARK: - Doc
struct Doc: Codable {
    let accessKey: String
    let id: Int
    let ext, title: String
    let size, date: Int
    let preview: Preview
    let type, ownerID: Int
    let url: String

    enum CodingKeys: String, CodingKey {
        case accessKey = "access_key"
        case id, ext, title, size, date, preview, type
        case ownerID = "owner_id"
        case url
    }
}

// MARK: - Preview
struct Preview: Codable {
    let photo: PreviewPhoto
    let video: VideoElement
}

// MARK: - PreviewPhoto
struct PreviewPhoto: Codable {
    let sizes: [VideoElement]
}

// MARK: - VideoElement
struct VideoElement: Codable {
    let type: SizeType?
    let width: Int
    let src: String?
    let height: Int
    let fileSize: Int?
    let url: String?
    let withPadding: Int?

    enum CodingKeys: String, CodingKey {
        case type, width, src, height
        case fileSize = "file_size"
        case url
        case withPadding = "with_padding"
    }
}

enum SizeType: String, Codable {
    case a = "a"
    case b = "b"
    case c = "c"
    case d = "d"
    case e = "e"
    case i = "i"
    case k = "k"
    case l = "l"
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

// MARK: - Link
struct Link: Codable {
    let isFavorite: Bool?
    let title: String
    let caption: String?
    let url: String
    let linkDescription: String
    let photo: LinkPhoto
    let button: Button?
    let target: String?

    enum CodingKeys: String, CodingKey {
        case isFavorite = "is_favorite"
        case title, caption, url
        case linkDescription = "description"
        case photo, button, target
    }
}

// MARK: - Button
struct Button: Codable {
    let title: String
    let action: Action
}

// MARK: - Action
struct Action: Codable {
    let type: String
    let target: String?
    let url: String
}

// MARK: - LinkPhoto
struct LinkPhoto: Codable {
    let albumID, id, date: Int
    let text: String
    let userID: Int
    let sizes: [VideoElement]
    let hasTags: Bool
    let ownerID: Int
    let postID: Int?
    let accessKey: String?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case id, date, text
        case userID = "user_id"
        case sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case postID = "post_id"
        case accessKey = "access_key"
    }
}

// MARK: - Poll
struct Poll: Codable {
    let canEdit: Bool
    let id: Int
    let embedHash: String
    let photo: PollPhoto
    let closed, disableUnvote: Bool
    let endDate: Int
    let canReport, anonymous: Bool
    let answers: [Answer]
    let multiple: Bool
    let ownerID, created: Int
    let question: String
    let canShare, isBoard, canVote: Bool
    let answerIDS: [JSONAny]
    let votes: Int

    enum CodingKeys: String, CodingKey {
        case canEdit = "can_edit"
        case id
        case embedHash = "embed_hash"
        case photo, closed
        case disableUnvote = "disable_unvote"
        case endDate = "end_date"
        case canReport = "can_report"
        case anonymous, answers, multiple
        case ownerID = "owner_id"
        case created, question
        case canShare = "can_share"
        case isBoard = "is_board"
        case canVote = "can_vote"
        case answerIDS = "answer_ids"
        case votes
    }
}

// MARK: - Answer
struct Answer: Codable {
    let text: String
    let id, votes: Int
    let rate: Double
}

// MARK: - PollPhoto
struct PollPhoto: Codable {
    let color: String
    let id: Int
    let images: [VideoElement]
}

enum AttachmentType: String, Codable {
    case doc = "doc"
    case link = "link"
    case photo = "photo"
    case poll = "poll"
    case video = "video"
}

// MARK: - AttachmentVideo
struct AttachmentVideo: Codable {
    let ownerID: Int
    let title: String
    let canAdd, duration: Int
    let image: [VideoElement]
    let isFavorite: Bool
    let views: Int
    let type: AttachmentType
    let canLike, canComment: Int
    let firstFrame: [VideoElement]
    let date, id, height: Int
    let trackCode: String
    let width, canAddToFaves: Int
    let accessKey: String
    let comments, canSubscribe, canRepost: Int
    let videoDescription: String

    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case title
        case canAdd = "can_add"
        case duration, image
        case isFavorite = "is_favorite"
        case views, type
        case canLike = "can_like"
        case canComment = "can_comment"
        case firstFrame = "first_frame"
        case date, id, height
        case trackCode = "track_code"
        case width
        case canAddToFaves = "can_add_to_faves"
        case accessKey = "access_key"
        case comments
        case canSubscribe = "can_subscribe"
        case canRepost = "can_repost"
        case videoDescription = "description"
    }
}

// MARK: - CategoryAction
struct CategoryAction: Codable {
    let name: String
    let action: Action
}

// MARK: - Comments
struct Comments: Codable {
    let count: Int
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - PurpleLikes
struct PurpleLikes: Codable {
    let count, canLike, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case count
        case canLike = "can_like"
        case userLikes = "user_likes"
    }
}

// MARK: - Photos
struct Photos: Codable {
    let count: Int
    let items: [PhotosItem]
}

// MARK: - PhotosItem
struct PhotosItem: Codable {
    let id: Int
    let comments: Comments
    let likes: FluffyLikes
    let accessKey: String
    let userID: Int
    let reposts: Reposts
    let date, ownerID: Int
    let postID: Int?
    let text: String
    let canRepost: Int
    let sizes: [VideoElement]
    let hasTags: Bool
    let albumID, canComment: Int

    enum CodingKeys: String, CodingKey {
        case id, comments, likes
        case accessKey = "access_key"
        case userID = "user_id"
        case reposts, date
        case ownerID = "owner_id"
        case postID = "post_id"
        case text
        case canRepost = "can_repost"
        case sizes
        case hasTags = "has_tags"
        case albumID = "album_id"
        case canComment = "can_comment"
    }
}

// MARK: - FluffyLikes
struct FluffyLikes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

enum PostTypeEnum: String, Codable {
    case post = "post"
    case wallPhoto = "wall_photo"
}

// MARK: - Profile
struct Profile: Codable {
    let canAccessClosed: Bool?
    let screenName: String?
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let isClosed: Bool?
    let firstName: String
    let deactivated: String?

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case screenName = "screen_name"
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case isClosed = "is_closed"
        case firstName = "first_name"
        case deactivated
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool
    let lastSeen, appID: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
        case lastSeen = "last_seen"
        case appID = "app_id"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}



struct News {
    var userImage: UIImage
    var userName: String
    var newsDate: String
    var newsText: String
    var newsImage: UIImage
}

var news = [
    News(userImage: .init(imageLiteralResourceName: "donald"), userName: "Donald Trump", newsDate: "21.04.2020г.", newsText: "Цена нефти марки WTI с поставкой в мае упала ниже одного доллара — впервые в истории. Об этом свидетельствуют данные торгов на бирже ICE в Лондоне. В моменте американская смесь стоила 16 центов, а потом стоимость опустилась до нуля. К 21:23 WTI торговалась в отрицательных значениях — минус 7,5 доллара, а после и вовсе — почти до минус 40 долларов (37,6 доллара за баррель).", newsImage: .init(imageLiteralResourceName: "wti")),
    
    News(userImage: .init(imageLiteralResourceName: "rayDalio"), userName: "Ray Dalio", newsDate: "23.11.2019г.", newsText: "Крупнейший хедж-фонд мира Bridgewater Associates, основанный миллиардером Реем Далио, сделал крупную ставку на падение фондовых рынков США и Европы к марту 2020 года, утверждает газета The Wall Street Journal. По словам источников издания, хедж-фонд, под управлением которого находится $150 млрд от 350 клиентов, вложил около $1,5 млрд покупку пут-опционов на американский фондовый индекс S&P 500 и европейский Euro Stoxx 50. Господин Далио заявил, что представленные газетой данные не соответствуют действительности.", newsImage: .init(imageLiteralResourceName: "dollars"))

]
