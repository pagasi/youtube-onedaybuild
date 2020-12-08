//
//  ViewController.swift
//  youtube-onedaybuild
//
//  Created by Whitney Naquin on 12/5/20.
//

import UIKit

class ViewController: UIViewController {

    var model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        model.getVideos()
    }


}

