//
//  RooViewController.swift
//  TestLightIT
//
//  Created by Анна Яцун on 02.08.2020.
//  Copyright © 2020 Анна Яцун. All rights reserved.
//

import UIKit


protocol ViewControllerEventType {
    
}

class RooViewController<InputEvent: ViewControllerEventType, OutputEvent: ViewControllerEventType, ViewModel, Configurator: ConfiguratorType> : UIViewController, ConfigureType {
    
    let viewModel: ViewModel
     
     // MARK:
     // MARK:  Initializator
     
     init(viewModel: ViewModel) {
         self.viewModel = viewModel
         super.init(nibName: "\(Self.self)", bundle: nil)
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()
         self.configuration()
     }
      
     // MARK:
     // MARK:
     open func configuration() {
         
     }
}


