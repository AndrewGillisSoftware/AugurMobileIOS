import UIKit
import CoreData

class InstanceSettingsViewController: UIViewController {

    @IBOutlet weak var urlTextField: UITextField!
    var user:User?
    var coreDataContext : NSManagedObjectContext?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        coreDataContext = GET_CONTEXT()
        loadData()
    }
    
    func loadData()
    {
        //get curre
        let fetch: NSFetchRequest<User> = User.fetchRequest()
        
        do
        {
            self.user = try coreDataContext?.fetch(fetch)[0]
        }
        catch
        {
            print("Could Not Find User in Instance Settings")
        }
        
        if let safeUser = user
        {
            urlTextField.text = safeUser.instanceURL
        }
    }
    
    @IBAction func setDefaultURL(_ sender: Any)
    {
        urlTextField.text = ALT_DEFAULT_INSTANCE
    }
    
    @IBAction func saveInstanceURL(_ sender: Any)
    {
        if let safeUser = user, let safeContext = coreDataContext
        {
            let user = User(context: safeContext)
            
            do
            {
                //Set Zero Points
                user.points = safeUser.points
                //Set Instance
                user.instanceURL = urlTextField.text
                
                try safeContext.save()
                
                coreDataContext?.delete(safeUser)
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
        else
        {
            print("Serious User Violation")
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        urlTextField.resignFirstResponder()
        return true
    }
}
