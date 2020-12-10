//
//  VideoTableViewCell.swift
//  youtube-onedaybuild
//
//  Created by Whitney Naquin on 12/10/20.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var video:Video?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setCell(_ v:Video) {
        
        self.video = v
        
        guard self.video != nil else {
         print("video nil when setting up the cell")
            return
        }
        
        //set the title
        self.titleLabel.text = video?.title
        
        //set the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.dateLabel.text = df.string(from: video!.published)
        
        //set the thumbnail - download the image
        guard self.video?.thumbnail != "" else {
            print("no thumbnail available")
            return
        }
        
        //check cache before downloading new data
        if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail) {
            
            //already have the data, set the thumbnail view with it
            self.thumbnailImageView.image = UIImage(data: cachedData)
            return
        }
        
        //start downloading the data
        let url = URL(string: self.video!.thumbnail)
        
        //get shared url session
        let session = URLSession.shared
        
        //create a data task
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            //check for errors
            if error == nil && data != nil {
                
                CacheManager.setVideoCache(url!.absoluteString, data)
                
                
                //check that the downloaded url matches the video thumbnail that this cell is currently set to display
                if url!.absoluteString != self.video?.thumbnail {
                    //vidoe cell has been recycled for another video and no longer matches the video that was downloaded
                    return
                }
                //create the image object
                let image = UIImage(data: data!)
                //set the image view
                DispatchQueue.main.async {
                    self.thumbnailImageView.image = image
                }
            }
        }
        
        //start the datatask
        dataTask.resume()
    }
    
}
