import Foundation

//api/unstable/repo-groups
struct RepositoryGroups : Codable {
    let repo_group_id : Int?
    let rg_name : String?
    let rg_description : String?
    let rg_website : String?
    let rg_recache : Int?
    let rg_last_modified : String?
    let rg_type : String?
    let tool_source : String?
    let tool_version : String?
    let data_source : String?
    let data_collection_date : String?

    enum CodingKeys: String, CodingKey {

        case repo_group_id = "repo_group_id"
        case rg_name = "rg_name"
        case rg_description = "rg_description"
        case rg_website = "rg_website"
        case rg_recache = "rg_recache"
        case rg_last_modified = "rg_last_modified"
        case rg_type = "rg_type"
        case tool_source = "tool_source"
        case tool_version = "tool_version"
        case data_source = "data_source"
        case data_collection_date = "data_collection_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        repo_group_id = try values.decodeIfPresent(Int.self, forKey: .repo_group_id)
        rg_name = try values.decodeIfPresent(String.self, forKey: .rg_name)
        rg_description = try values.decodeIfPresent(String.self, forKey: .rg_description)
        rg_website = try values.decodeIfPresent(String.self, forKey: .rg_website)
        rg_recache = try values.decodeIfPresent(Int.self, forKey: .rg_recache)
        rg_last_modified = try values.decodeIfPresent(String.self, forKey: .rg_last_modified)
        rg_type = try values.decodeIfPresent(String.self, forKey: .rg_type)
        tool_source = try values.decodeIfPresent(String.self, forKey: .tool_source)
        tool_version = try values.decodeIfPresent(String.self, forKey: .tool_version)
        data_source = try values.decodeIfPresent(String.self, forKey: .data_source)
        data_collection_date = try values.decodeIfPresent(String.self, forKey: .data_collection_date)
    }

}
