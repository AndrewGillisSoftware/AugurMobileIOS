import Foundation
struct Repository : Codable {
    let repo_id : Int?
    let repo_name : String?
    let description : String?
    let url : String?
    let repo_status : String?
    let commits_all_time : Int?
    let issues_all_time : Double?
    let rg_name : String?
    let repo_group_id : Int?
    let base64_url : String?

    enum CodingKeys: String, CodingKey {

        case repo_id = "repo_id"
        case repo_name = "repo_name"
        case description = "description"
        case url = "url"
        case repo_status = "repo_status"
        case commits_all_time = "commits_all_time"
        case issues_all_time = "issues_all_time"
        case rg_name = "rg_name"
        case repo_group_id = "repo_group_id"
        case base64_url = "base64_url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        repo_id = try values.decodeIfPresent(Int.self, forKey: .repo_id)
        repo_name = try values.decodeIfPresent(String.self, forKey: .repo_name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        repo_status = try values.decodeIfPresent(String.self, forKey: .repo_status)
        commits_all_time = try values.decodeIfPresent(Int.self, forKey: .commits_all_time)
        issues_all_time = try values.decodeIfPresent(Double.self, forKey: .issues_all_time)
        rg_name = try values.decodeIfPresent(String.self, forKey: .rg_name)
        repo_group_id = try values.decodeIfPresent(Int.self, forKey: .repo_group_id)
        base64_url = try values.decodeIfPresent(String.self, forKey: .base64_url)
    }

}
