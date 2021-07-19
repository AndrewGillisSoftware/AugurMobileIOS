import UIKit
import CoreData

class RepositoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate,UIPickerViewDataSource
{
    @IBOutlet weak var repoTableView: UITableView!
    @IBOutlet weak var groupPickerView: UIPickerView!
    @IBOutlet weak var repoSearchBar: UISearchBar!
    
    var repositories:[RepositoryByGroup]?
    var groups:[RepositoryGroups]?
    
    var user:User?
    
    var coreDataContext : NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGroupData()
        
    }
    
    func loadGroupData()
    {
        //Get Context
        coreDataContext = GET_CONTEXT()
        
        //get repo string
        let fetch: NSFetchRequest<User> = User.fetchRequest()
        
        do
        {
            self.user = try coreDataContext?.fetch(fetch)[0]
        }
        catch
        {
            print("Could Not Found Repos URL")
        }
        
        //Get Repos groups from URL String
        var url : String = user?.instanceURL ?? ""
        url.append(GET_REPO_GROUPS_URL_STRING)
        guard let repoGroupURL = URL(string: url) else
        {
            print("Bad URL")
            return
        }
        
        let request = URLRequest(url: repoGroupURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([RepositoryGroups].self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.groups = decodedResponse
                        self.groupPickerView.reloadAllComponents()
                    }

                    // everything is good, so we can exit
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
        
        loadRepoData(groupId: String(self.groups?[0].repo_group_id ?? 0))
    }
    
    func loadRepoData(groupId:String)
    {
        //Get Repos groups from URL String
        var url : String = user?.instanceURL ?? ""
        url.append(GET_REPO_GROUPS_URL_STRING + "/" + groupId + "/repos")
        
        guard let repoURL = URL(string: url) else
        {
            print("Bad URL")
            return
        }
        
        let request = URLRequest(url: repoURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([RepositoryByGroup].self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.repositories = decodedResponse
                        self.repoTableView.reloadData()
                        
                    }

                    // everything is good, so we can exit
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }
    
    //Only one section per view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Set number of entries
    func tableView( _ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.repositories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = repoTableView.dequeueReusableCell(withIdentifier: "repoCell",for: indexPath)
        
        //Cast Cell and Fill Data Here If NEEDED
        cell.textLabel?.text = repositories?[indexPath.row].repo_name
        
        return cell
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return groups?[row].rg_name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        loadRepoData(groupId: String(groups?[row].repo_group_id ?? 0))
        repoTableView.reloadData()
        
    }
    
    func searchBarShouldReturn(_ UISearchBar: UISearchBar) -> Bool {
        repoSearchBar.resignFirstResponder()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        switch(segue.identifier)
        {
            default:
                print("Critical Segue Error")
        }
    }
}
