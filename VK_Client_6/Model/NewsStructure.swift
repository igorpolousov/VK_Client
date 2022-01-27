//
//  NewsStructure.swift
//  VK_Client_6
//
//  Created by Igor Polousov on 29.03.2021.
//

import Foundation
import UIKit



import Foundation

// MARK: - Welcome
struct NewsContainer: Codable {
    let response: ResponseNews
}

// MARK: - Response
struct ResponseNews: Codable {
    let items: [ResponseItem]
    let groups: [GroupNews]
    let profiles: [Profile]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct GroupNews: Codable {
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
    let canSetCategory, isFavorite: Bool?
    let shortTextRate: Double?
    let likes: PurpleLikes?
    let reposts: Comments?
    let type: PostTypeEnum
    let postType: PostTypeEnum?
    let date, sourceID: Int
    let text: String?
    let canDoubtCategory: Bool?
    let attachments: [Attachment]?
    let markedAsAds: Int?
    let postID: Int
    let views: Comments?
    let carouselOffset: Int?
    let photos: Photos?

    enum CodingKeys: String, CodingKey {
        case donut, comments
        case canSetCategory = "can_set_category"
        case isFavorite = "is_favorite"
        case shortTextRate = "short_text_rate"
        case likes, reposts, type
        case postType = "post_type"
        case date
        case sourceID = "source_id"
        case text
        case canDoubtCategory = "can_doubt_category"
        case attachments
        case markedAsAds = "marked_as_ads"
        case postID = "post_id"
        case views
        case carouselOffset = "carousel_offset"
        case photos
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: AttachmentType
    let video: AttachmentVideo?
    let doc: Doc?
    let link: Link?
    let photo: LinkPhoto?
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

    enum CodingKeys: String, CodingKey {
        case isFavorite = "is_favorite"
        case title, caption, url
        case linkDescription = "description"
        case photo, button
    }
}

// MARK: - Button
struct Button: Codable {
    let title: String
    let action: Action
}

// MARK: - Action
struct Action: Codable {
    let type, target: String
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

enum AttachmentType: String, Codable {
    case doc = "doc"
    case link = "link"
    case photo = "photo"
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
    let canAccessClosed: Bool
    let screenName: String
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let isClosed: Bool
    let firstName: String

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
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool
    let lastSeen: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
        case lastSeen = "last_seen"
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
