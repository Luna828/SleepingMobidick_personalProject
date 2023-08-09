import Foundation

struct MovieInfo: Codable {
    let page: Int
    let results: [Result]
    let total_pages, total_results: Int
}

// MARK: - Result
struct Result: Codable {
    let adult: Bool
    let backdrop_path: String
    let genre_ids: [Int]
    let id: Int
    let original_language: OriginalLanguage
    let original_title, overview: String
    let popularity: Double
    let poster_path, release_date, title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}

enum OriginalLanguage: String, Codable {
    case en = "en"
    case fr = "fr"
    case ja = "ja"
    case uk = "uk"
}
