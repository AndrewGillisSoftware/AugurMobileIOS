import Foundation

//api/unstable/repo-groups/<group id>/repos
struct RepositoryByGroup : Codable {
    let repo_id : Int?
    let repo_name : String?
    let description : String?
    let url : String?
    let repo_status : String?
    let commits_all_time : Int?
    let issues_all_time : Double?

    enum CodingKeys: String, CodingKey {

        case repo_id = "repo_id"
        case repo_name = "repo_name"
        case description = "description"
        case url = "url"
        case repo_status = "repo_status"
        case commits_all_time = "commits_all_time"
        case issues_all_time = "issues_all_time"
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
    }

}
