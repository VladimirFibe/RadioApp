//
//  DetailsViewController.swift
//  RadioApp
//
//  Created by Sergey Zakurakin on 8/2/24.
//

import UIKit
import SnapKit

class DetailsViewController: UIViewController {
    
    //MARK: - UI
    private lazy var background: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(named: "detailsBackground")
        // setup
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()

    private lazy var mainTitle: UILabel = {
        let element = UILabel()
        // setup
        
        
        element.translatesAutoresizingMaskIntoConstraints = false
        return element
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension DetailsViewController {
    
    func setupConstraint() {
        background.snp
    }
}
