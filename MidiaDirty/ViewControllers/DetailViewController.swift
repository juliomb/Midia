//
//  DetailViewController.swift
//  MidiaDirty
//
//  Created by Julio Martínez Ballester on 2/23/19.
//  Copyright © 2019 Yuju. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var mediaItemId: String!
    var mediaItemProvider: MediaItemProvider!

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        loadingView.isHidden = false
    }

    @IBAction func didTapCloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
