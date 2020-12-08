//
//  Model.swift
//  youtube-onedaybuild
//
//  Created by Whitney Naquin on 12/7/20.
//

import Foundation

class Model {
    
    func getVideos() {
        
        //Create a URL object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            return
        }
        //get a URLSession object
        let session = URLSession.shared
        //get a data task from the urlsession object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            
            //check if there were any errors
            if error != nil || data == nil {
                return
            }
            
            //parsing the data into video objects
            
        }
        //kick off the task
        dataTask.resume()
    }
}
