//
//  ViewControllerExtensions.swift
//  TraktAPI
//
//  Created by Edgar Cardoso on 07/08/18.
//  Copyright © 2018 Edgar Cardoso. All rights reserved.
//

import UIKit

extension ViewController {
    func showAlert(with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { handler in
            alert.dismiss(animated: true, completion: nil)
        })
        
        present(alert, animated: true, completion: nil)
    }
}
