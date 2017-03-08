//
//  HomepageViewController.swift
//  Instagram
//
//  Created by Arthur on 2017/3/6.
//  Copyright © 2017年 Kuan-Ting Wu (Arthur Wu). All rights reserved.
//

import UIKit
import Parse

class HomepageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource
{

    @IBOutlet var tableView: UITableView!
    var posts: [PFObject] = []
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        
        
        reload()
        // fetch data asynchronously
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogOut(_ sender: Any)
    {
        User.currentUser = nil
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
        PFUser.logOutInBackground
            {
                (error: Error?) in
            print(error?.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostsCell
        
        let post = posts[indexPath.row]
        
        let media = post["media"] as! PFFile
        let caption = post["caption"] as! String
        

            media.getDataInBackground { (data, error) in
                if let image = data {
                    cell.postView.image = UIImage(data: image)
                    cell.caption.text = caption
                }
                

        }
        
        return cell
    }
    override func viewWillAppear(_ animated: Bool)
    {
        reload()
        tableView.reloadData()
        
    }
    func reload()
    {
        let query = PFQuery(className: "Post")
        query.order(byDescending: "createdAt")
        query.includeKey("author")
        query.whereKey("author", equalTo: PFUser.current())
        query.limit = 20

        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) -> Void in
            if let posts = posts
            {
                self.posts = posts
                
                print(posts)
                
                //let post = self.posts[indexPath.row]
                self.tableView.reloadData()
                
                // do something with the data fetched
            } else {
                // handle error
            }
        }

    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
