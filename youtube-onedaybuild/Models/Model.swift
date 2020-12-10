//
//  Model.swift
//  youtube-onedaybuild
//
//  Created by Whitney Naquin on 12/7/20.
//

import Foundation

protocol ModelDelegate {
    func videosFetched(_ videos:[Video])
}

class Model {
    
    var delegate:ModelDelegate?
    
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
            
            do {
            
            //parsing the data into video objects
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
                let response = try decoder.decode(Response.self, from: data!)
            
                
                
                //call the videosFetched method of the delegate
                if response.items != nil {
                    DispatchQueue.main.async {
                    self.delegate?.videosFetched(response.items!)
                    }
                }
                dump(response)
            }
            catch { print("had and error trying the decoder in model")
                
            }
        }
        //kick off the task
        dataTask.resume()
    }
}
