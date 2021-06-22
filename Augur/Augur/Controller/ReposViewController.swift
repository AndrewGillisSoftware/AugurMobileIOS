//
//  ViewController.swift
//  Augur
//
//  Created by Andrew Gillis on 6/20/21.
//

import UIKit

class ReposViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    @IBOutlet weak var reposTableView: UITableView!
    let repoURLString = "http://augur.chaoss.io/api/unstable/repos"
    
    var repositories:[Repository]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadData()
    }
    
    //Server Down UNTESTED
    func loadData()
    {
        guard let repoURL = URL(string: repoURLString) else
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
                        self.reposTableView.reloadData()
                        
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
        let cell = reposTableView.dequeueReusableCell(withIdentifier: "repoCell",for: indexPath)
        
        //Cast Cell and Fill Data Here If NEEDED
        cell.textLabel?.text = repositories?[indexPath.row].repo_name
        
        return cell
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

