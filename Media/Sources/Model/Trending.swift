//
//  Trending.swift
//  Media
//
//  Created by gnksbm on 6/10/24.
//

import Foundation

struct Trending: Codable {
    let page: Int
    let results: [Item]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

extension Trending {
    struct Item: Codable {
        let backdropPath: String
        let id: Int
        let originalTitle: String?
        let overview, posterPath: String
        let mediaType: MediaType
        let adult: Bool
        let title: String?
        let originalLanguage: OriginalLanguage
        let genreIDS: [Int]
        let popularity: Double
        let releaseDate: String?
        let video: Bool?
        let voteAverage: Double
        let voteCount: Int
        let originalName, name, firstAirDate: String?
        let originCountry: [String]?
        
        var genreID: Int? {
            if let genreId = genreIDS.first {
                return genreId
            } else {
                return nil
            }
        }
        
        var visibleDate: String? {
            releaseDate?.formatted(
                input: .trendingItemInput,
                output: .trendingItemOutput
            )
        }
        
        var grade: String {
            String(
                format: "%.2f",
                voteAverage
            )
        }
        
        var imageURL: URL? {
            URL(string: "https://image.tmdb.org/t/p/w500/\(posterPath)")
        }
        
        enum CodingKeys: String, CodingKey {
            case backdropPath = "backdrop_path"
            case id
            case originalTitle = "original_title"
            case overview
            case posterPath = "poster_path"
            case mediaType = "media_type"
            case adult, title
            case originalLanguage = "original_language"
            case genreIDS = "genre_ids"
            case popularity
            case releaseDate = "release_date"
            case video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case originalName = "original_name"
            case name
            case firstAirDate = "first_air_date"
            case originCountry = "origin_country"
        }
    }
    
    enum MediaType: String, Codable {
        case movie, tv
    }
    
    enum OriginalLanguage: String, Codable {
        case en, fr, ja, zh
    }
}

/*
{
    "page":1,
    "results":[{
        "backdrop_path":"/nv6F6tz7r61DUhE7zgHwLJFcTYp.jpg",
        "id":974635,
        "original_title":"Hit Man",
        "overview":"A mild-mannered professor moonlighting as a fake hit man in police stings ignites a chain reaction of trouble when he falls for a potential client.",
        "poster_path":"/1126gjlBf4hTm9Sgf0ox3LGVEBt.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"Hit Man",
        "original_language":"en",
        "genre_ids":[
            35,
            80,
            10749
        ],
        "popularity":323.943,
        "release_date":"2024-05-16",
        "video":false,
        "vote_average":7.113,
        "vote_count":137
    },
               {
        "backdrop_path":"/xQkotnzv12fm9FF29if1cBLsyU3.jpg",
        "id":1001311,
        "original_title":"Sous la Seine",
        "overview":"In the Summer of 2024, Paris is hosting the World Triathlon Championships on the Seine for the first time. Sophia, a brilliant scientist, learns from Mika, a young environmental activist, that a large shark is swimming deep in the river. To avoid a bloodbath at the heart of the city, they have no choice but to join forces with Adil, the Seine river police commander.",
        "poster_path":"/qZPLK5ktRKa3CL4sKRZtj8UlPYc.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"Under Paris",
        "original_language":"fr",
        "genre_ids":[
            53,
            27,
            28,
            9648
        ],
        "popularity":609.854,
        "release_date":"2024-06-05",
        "video":false,
        "vote_average":5.783,
        "vote_count":258
    },
               {
        "backdrop_path":"/ga4OLm4qLxPqKLMzjJlqHxVjst3.jpg",
        "id":573435,
        "original_title":"Bad Boys: Ride or Die",
        "overview":"After their late former Captain is framed, Lowrey and Burnett try to clear his name, only to end up on the run themselves.",
        "poster_path":"/nP6RliHjxsz4irTKsxe8FRhKZYl.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"Bad Boys: Ride or Die",
        "original_language":"en",
        "genre_ids":[
            28,
            80,
            53
        ],
        "popularity":2486.516,
        "release_date":"2024-06-05",
        "video":false,
        "vote_average":7.656,
        "vote_count":93
    },
               {
        "backdrop_path":"/yWKPYjbkV8Bb9JLSKsX7KEQCuoh.jpg",
        "id":114479,
        "original_name":"The Acolyte",
        "overview":"An investigation into a shocking crime spree pits a respected Jedi Master against a dangerous warrior from his past. As more clues emerge, they travel down a dark path where sinister forces reveal all is not what it seems.",
        "poster_path":"/mztdt3y6GBsJR69zHtszFezTCLT.jpg",
        "media_type":"tv",
        "adult":false,
        "name":"The Acolyte",
        "original_language":"en",
        "genre_ids":[
            9648,
            10765
        ],
        "popularity":1341.69,
        "first_air_date":"2024-06-04",
        "vote_average":6.0,
        "vote_count":99,
        "origin_country":["US"]
    },
               {
        "backdrop_path":"/6LksoR7reQ45gQRik0zhrHmcpZw.jpg",
        "id":1010600,
        "original_title":"The Strangers: Chapter 1",
        "overview":"After their car breaks down in an eerie small town, a young couple are forced to spend the night in a remote cabin. Panic ensues as they are terrorized by three masked strangers who strike with no mercy and seemingly no motives.",
        "poster_path":"/qyT2xw9FBxHlNXQYsuNCu8T7Rbo.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"The Strangers: Chapter 1",
        "original_language":"en",
        "genre_ids":[
            27,
            53
        ],
        "popularity":213.286,
        "release_date":"2024-05-15",
        "video":false,
        "vote_average":5.377,
        "vote_count":73
    },
               {
        "backdrop_path":"/xRd1eJIDe7JHO5u4gtEYwGn5wtf.jpg",
        "id":823464,
        "original_title":"Godzilla x Kong: The New Empire",
        "overview":"Following their explosive showdown, Godzilla and Kong must reunite against a colossal undiscovered threat hidden within our world, challenging their very existence – and our own.",
        "poster_path":"/z1p34vh7dEOnLDmyCrlUVLuoDzd.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"Godzilla x Kong: The New Empire",
        "original_language":"en",
        "genre_ids":[
            878,
            28,
            12
        ],
        "popularity":2726.153,
        "release_date":"2024-03-27",
        "video":false,
        "vote_average":7.228,
        "vote_count":2599
    },
               {
        "backdrop_path":"/H5HjE7Xb9N09rbWn1zBfxgI8uz.jpg",
        "id":746036,
        "original_title":"The Fall Guy",
        "overview":"Fresh off an almost career-ending accident, stuntman Colt Seavers has to track down a missing movie star, solve a conspiracy and try to win back the love of his life while still doing his day job.",
        "poster_path":"/tSz1qsmSJon0rqjHBxXZmrotuse.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"The Fall Guy",
        "original_language":"en",
        "genre_ids":[
            28,
            35
        ],
        "popularity":1382.602,
        "release_date":"2024-04-24",
        "video":false,
        "vote_average":7.3,
        "vote_count":1108
    },
               {
        "backdrop_path":"/fY3lD0jM5AoHJMunjGWqJ0hRteI.jpg",
        "id":940721,
        "original_title":"ゴジラ-1.0",
        "overview":"In postwar Japan, Godzilla brings new devastation to an already scorched landscape. With no military intervention or government help in sight, the survivors must join together in the face of despair and fight back against an unrelenting horror.",
        "poster_path":"/hkxxMIGaiCTmrEArK7J56JTKUlB.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"Godzilla Minus One",
        "original_language":"ja",
        "genre_ids":[
            878,
            27,
            28
        ],
        "popularity":898.788,
        "release_date":"2023-11-03",
        "video":false,
        "vote_average":7.631,
        "vote_count":1564
    },
               {
        "backdrop_path":"/z121dSTR7PY9KxKuvwiIFSYW8cf.jpg",
        "id":929590,
        "original_title":"Civil War",
        "overview":"In the near future, a group of war journalists attempt to survive while reporting the truth as the United States stands on the brink of civil war.",
        "poster_path":"/sh7Rg8Er3tFcN9BpKIPOMvALgZd.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"Civil War",
        "original_language":"en",
        "genre_ids":[
            10752,
            28,
            18
        ],
        "popularity":2730.901,
        "release_date":"2024-04-10",
        "video":false,
        "vote_average":7.062,
        "vote_count":1384
    },
               {
        "backdrop_path":"/xpba0Dxz3sxV3QgYLR8UIe1LAAX.jpg",
        "id":103768,
        "original_name":"Sweet Tooth",
        "overview":"On a perilous adventure across a post-apocalyptic world, a lovable boy who's half-human and half-deer searches for a new beginning with a gruff protector.",
        "poster_path":"/dBxxtfhC4vYrxB2fLsSxOTY2dQc.jpg",
        "media_type":"tv",
        "adult":false,
        "name":"Sweet Tooth",
        "original_language":"en",
        "genre_ids":[
            18,
            10765
        ],
        "popularity":1211.922,
        "first_air_date":"2021-06-04",
        "vote_average":7.8,
        "vote_count":1337,
        "origin_country":["US"]
    },
               {
        "backdrop_path":"/shrwC6U8Bkst9T9J7fr1A50n6x6.jpg",
        "id":786892,
        "original_title":"Furiosa: A Mad Max Saga",
        "overview":"As the world fell, young Furiosa is snatched from the Green Place of Many Mothers and falls into the hands of a great Biker Horde led by the Warlord Dementus. Sweeping through the Wasteland they come across the Citadel presided over by The Immortan Joe. While the two Tyrants war for dominance, Furiosa must survive many trials as she puts together the means to find her way home.",
        "poster_path":"/iADOJ8Zymht2JPMoy3R7xceZprc.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"Furiosa: A Mad Max Saga",
        "original_language":"en",
        "genre_ids":[
            28,
            12,
            878
        ],
        "popularity":1122.616,
        "release_date":"2024-05-22",
        "video":false,
        "vote_average":7.7,
        "vote_count":785
    },
               {
        "backdrop_path":"/tkqsrARBZnWnKqv2O8n4PYry1LS.jpg",
        "id":239770,
        "original_name":"Doctor Who",
        "overview":"The Doctor and his companion travel across time and space encountering incredible friends and foes.",
        "poster_path":"/8FHthx4Vu81J4X5BTLhJYK9Gtbs.jpg",
        "media_type":"tv",
        "adult":false,
        "name":"Doctor Who",
        "original_language":"en",
        "genre_ids":[
            10759,
            18,
            10765
        ],
        "popularity":254.038,
        "first_air_date":"2024-05-11",
        "vote_average":6.304,
        "vote_count":84,
        "origin_country":["GB"]
    },
               {
        "backdrop_path":"/fKxGUfI09ubxe594Nl8Om2cMuxH.jpg",
        "id":641934,
        "original_title":"Am I OK?",
        "overview":"Lucy and Jane have been best friends for most of their lives and think they know everything there is to know about each other. But when Jane announces she's moving to London, Lucy reveals a long-held secret. As Jane tries to help Lucy, their friendship is thrown into chaos.",
        "poster_path":"/qKkaG7HVFVe7C1JuxTGwNz0eSyL.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"Am I OK?",
        "original_language":"en",
        "genre_ids":[
            18,
            35,
            10749
        ],
        "popularity":177.213,
        "release_date":"2024-06-11",
        "video":false,
        "vote_average":6.1,
        "vote_count":37
    },
               {
        "backdrop_path":"/xOMo8BRK7PfcJv9JCnx7s5hj0PX.jpg",
        "id":693134,
        "original_title":"Dune: Part Two",
        "overview":"Follow the mythic journey of Paul Atreides as he unites with Chani and the Fremen while on a path of revenge against the conspirators who destroyed his family. Facing a choice between the love of his life and the fate of the known universe, Paul endeavors to prevent a terrible future only he can foresee.",
        "poster_path":"/1pdfLvkbY9ohJlCjQH2CZjjYVvJ.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"Dune: Part Two",
        "original_language":"en",
        "genre_ids":[
            878,
            12
        ],
        "popularity":903.033,
        "release_date":"2024-02-27",
        "video":false,
        "vote_average":8.169,
        "vote_count":4401
    },
               {
        "backdrop_path":"/u1CqlLecfpcuOaugKi3ol9gDQHJ.jpg",
        "id":95842,
        "original_name":"庆余年",
        "overview":"Zhang Qing, a present-day college student in culture and history major wants to study in professor Ye's postgraduate class, so he decides to write a historical fiction to elaborate his perspective of analyzing ancient literature history with modern concept. In the fiction, Zhang himself acts as a young man Fan Xian with mysterious life who lives in a remote seaside town of Kingdom Qing in his childhood, under the help of a mysterious mentor and a blindfolded watchman. Fan goes to the capital when he grows up, where he experiences plenty of ordeal and temper. Fan persists in adhering the rule of justice and goodness and lives his own glorious life.",
        "poster_path":"/vlHJfLsduZiILN8eYdN57kHZTcQ.jpg",
        "media_type":"tv",
        "adult":false,
        "name":"Joy of Life",
        "original_language":"zh",
        "genre_ids":[
            18,
            35
        ],
        "popularity":212.187,
        "first_air_date":"2019-11-26",
        "vote_average":8.1,
        "vote_count":75,
        "origin_country":["CN"]
    },
               {
        "backdrop_path":"/uVu2fBc114un7F1GD76RBouWyBP.jpg",
        "id":1022789,
        "original_title":"Inside Out 2",
        "overview":"Teenager Riley's mind headquarters is undergoing a sudden demolition to make room for something entirely unexpected: new Emotions! Joy, Sadness, Anger, Fear and Disgust, who’ve long been running a successful operation by all accounts, aren’t sure how to feel when Anxiety shows up. And it looks like she’s not alone.",
        "poster_path":"/vpnVM9B6NMmQpWeZvzLvDESb2QY.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"Inside Out 2",
        "original_language":"en",
        "genre_ids":[
            16,
            10751,
            18,
            12,
            35
        ],
        "popularity":1350.605,
        "release_date":"2024-06-12",
        "video":false,
        "vote_average":8.0,
        "vote_count":13
    },
               {
        "backdrop_path":"/kti9ufHhCKaOLjg2to4RKfrlkmh.jpg",
        "id":1263421,
        "original_title":"範馬刃牙VSケンガンアシュラ",
        "overview":"It's the ultimate showdown. The toughest fighters from \"Baki Hanma\" and \"Kengan Ashura\" clash in this unprecedented, hard-hitting martial arts crossover.",
        "poster_path":"/etbHJxil0wHvYOCmibzFLsMcl2C.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"Baki Hanma VS Kengan Ashura",
        "original_language":"ja",
        "genre_ids":[
            16,
            28
        ],
        "popularity":341.279,
        "release_date":"2024-06-05",
        "video":false,
        "vote_average":8.222,
        "vote_count":81
    },
               {
        "backdrop_path":"/2rmK7mnchw9Xr3XdiTFSxTTLXqv.jpg",
        "id":37854,
        "original_name":"ワンピース",
        "overview":"Years ago, the fearsome Pirate King, Gol D. Roger was executed leaving a huge pile of treasure and the famous \"One Piece\" behind. Whoever claims the \"One Piece\" will be named the new King of the Pirates.\n\nMonkey D. Luffy, a boy who consumed a \"Devil Fruit,\" decides to follow in the footsteps of his idol, the pirate Shanks, and find the One Piece. It helps, of course, that his body has the properties of rubber and that he's surrounded by a bevy of skilled fighters and thieves to help him along the way.\n\nLuffy will do anything to get the One Piece and become King of the Pirates!",
        "poster_path":"/cMD9Ygz11zjJzAovURpO75Qg7rT.jpg",
        "media_type":"tv",
        "adult":false,
        "name":"One Piece",
        "original_language":"ja",
        "genre_ids":[
            10759,
            35,
            16
        ],
        "popularity":229.494,
        "first_air_date":"1999-10-20",
        "vote_average":8.727,
        "vote_count":4479,
        "origin_country":["JP"]
    },
               {
        "backdrop_path":"/pAcTNgtz4HZWli6enJtpCyydfKK.jpg",
        "id":229202,
        "original_name":"玫瑰的故事",
        "overview":"Born into a scholarly family, Huang Yimei grows up surrounded by care and affection, displaying artistic talent from a young age. Early in her career, she quickly gains recognition and meets her partner, Zhuang Guodong. They fall in love but eventually drift apart. This period of professional growth gives her a clearer vision for her future, leading her to return to school for further education. After graduation, she marries her senior, Fang Xiewen. However, their divergent career paths lead to a divorce. Huang Yimei then starts her own business and makes a name for herself in the planning for art exhibitions. During this time, she meets her soulmate, Fu Jiaming, but their love story ends tragically with his passing just a few months later. Despite this, Huang Yimei remains resilient, continuing to strive for a more fulfilling life.",
        "poster_path":"/5Xjv2eIPSmTUHgMzzQVELZZXbPf.jpg",
        "media_type":"tv",
        "adult":false,
        "name":"The Tale of Rose",
        "original_language":"zh",
        "genre_ids":[18],
        "popularity":103.586,
        "first_air_date":"2024-06-08",
        "vote_average":9.0,
        "vote_count":1,
        "origin_country":["CN"]
    },
               {
        "backdrop_path":"/3TNSoa0UHGEzEz5ndXGjJVKo8RJ.jpg",
        "id":614933,
        "original_title":"Atlas",
        "overview":"A brilliant counterterrorism analyst with a deep distrust of AI discovers it might be her only hope when a mission to capture a renegade robot goes awry.",
        "poster_path":"/bcM2Tl5HlsvPBnL8DKP9Ie6vU4r.jpg",
        "media_type":"movie",
        "adult":false,
        "title":"Atlas",
        "original_language":"en",
        "genre_ids":[
            878,
            28
        ],
        "popularity":1828.902,
        "release_date":"2024-05-23",
        "video":false,
        "vote_average":6.732,
        "vote_count":658
    }],
    "total_pages":1000,
    "total_results":20000
}
*/
