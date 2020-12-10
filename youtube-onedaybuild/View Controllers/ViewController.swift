//
//  ViewController.swift
//  youtube-onedaybuild
//
//  Created by Whitney Naquin on 12/5/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var model = Model()
    var videos = [Video]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        model.delegate = self
        
        model.getVideos()
    }


}
 //MARK: tableview methods
extension ViewController : UITableViewDelegate, UITableViewDataSource, ModelDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell

        //configure the cell with the data
        let video = self.videos[indexPath.row]
        cell.textLabel?.text = title
        
        cell.setCell(video)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //segue
    }
    
    //MARK:  ModelDelegate methods
    func videosFetched(_ videos:[Video]) {
        //set the returned videos to our video property
        self.videos = videos
        //refresh the tableview
        tableView.reloadData()
    }
}
