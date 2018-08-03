//
//  ViewController.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 02/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let network = NetworkRequest()
        network.request(with: "tron") { result in
            switch result {
            case .success(let json):
                print(json)
            case .error:
                print("error")
            }
        }
    }
}

