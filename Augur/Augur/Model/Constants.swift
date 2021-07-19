import UIKit
import CoreData

let DEFAULT_INSTANCE : String = "http://augur.chaoss.io"
let ALT_DEFAULT_INSTANCE : String = "http://unicef.osshealth.io"
let ACCESS_API = "/api/unstable/"
let GET_REPO_URL_STRING : String = ACCESS_API + "repos"
let GET_REPO_GROUPS_URL_STRING : String = ACCESS_API + "repo-groups"


func GET_CONTEXT() -> NSManagedObjectContext?
{
    return (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
}
