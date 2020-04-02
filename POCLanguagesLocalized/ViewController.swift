//
//  ViewController.swift
//  POCLanguagesLocalized
//
//  Created by Nawin Phunsawat on 2/4/2563 BE.
//  Copyright © 2563 Nawin Phunsawat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loadingLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
    
    func setView() {
        loadingLabel.text = "loading_data".localized()
    }

    @IBAction func changeToThaiBtn(_ sender: Any) {
        LanguageManager.shared.currentLanguage = .th
        setView()
    }
    @IBAction func changeToEngBtn(_ sender: Any) {
        LanguageManager.shared.currentLanguage = .en
        setView()
    }
}

