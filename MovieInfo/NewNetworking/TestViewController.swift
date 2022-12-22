//
//  TestViewController.swift
//  MovieInfo
//
//  Created by Kevin Harijanto on 09/12/22.
//

import Foundation
import UIKit

class TestViewController: UIViewController {
    // MARK: - Properties
    let vm = ViewModel()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureUI()
    }

    // MARK: - Selectors


    // MARK: - Helpers
    func configureUI()  {
        vm.fetchTopQuestions()
    }
}
