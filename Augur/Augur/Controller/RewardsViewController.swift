import UIKit
import CoreData

class RewardsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var repoInvestTableView: UITableView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var repoInvestSearchBar: UISearchBar!
    
    var coreDataContext : NSManagedObjectContext?
    var repositories:[Repository]?
    var user:User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coreDataContext = GET_CONTEXT()
        loadData()
    }
    
    func loadData()
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
            print("Could Not Found Repos URL in Rewards")
        }
        
        //Get Repos from URL String
        var url : String = user?.instanceURL ?? ""
        url.append(GET_REPO_URL_STRING)
        
        //Set Label for Points
        self.pointLabel.text = String(user?.points ?? 0)
        
        guard let repoURL = URL(string: url) else
        {
            print("Bad URL")
            return
        }
        
        let request = URLRequest(url: repoURL)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Repository].self, from: data) {
                    // we have good data – go back to the main thread
                    DispatchQueue.main.async {
                        // update our UI
                        self.repositories = decodedResponse
                        self.repoInvestTableView.reloadData()
                        
                    }

                    // everything is good, so we can exit
                    return
                }
            }

            // if we're still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
            
        }.resume()
    }

    @IBAction func getMorePoints(_ sender: Any)
    {
        var i:Int = Int(pointLabel.text ?? "0") ?? 0
        i += 1
        self.pointLabel.text = String(i)
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
        let cell = repoInvestTableView.dequeueReusableCell(withIdentifier: "investRepoCell",for: indexPath)
        
        //Cast Cell and Fill Data Here If NEEDED
        cell.textLabel?.text = repositories?[indexPath.row].repo_name
        
        return cell
    }
    
    func searchBarShouldReturn(_ UISearchBar: UISearchBar) -> Bool {
        repoInvestSearchBar.resignFirstResponder()
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
