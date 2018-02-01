//
//  ViewControllerPannable.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 7/19/17.
//  Copyright © 2017 Mark Lawrence. All rights reserved.
//

import UIKit

class ViewControllerPannable: UIViewController {
    var panGestureRecognizer: UIPanGestureRecognizer?
    var originalPosition: CGPoint?
    var currentPositionTouched: CGPoint?
    let screenSize = UIScreen.main.bounds
    
    var mainViewController = WeatherUpdater.sharedInstance.getViewController()
    
    //var cityListController: CityListViewController?
    
    //@IBOutlet weak var dragDownArrow: UIImageView!
    
    var dragDownArrow = UIImageView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Created pan")
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        view.addGestureRecognizer(panGestureRecognizer!)
    }
    
    func panGestureAction(_ panGesture: UIPanGestureRecognizer) {
        
        
        let translation = panGesture.translation(in: view)
        
        if panGesture.state == .began {
            originalPosition = view.center
            currentPositionTouched = panGesture.location(in: view)
        } else if panGesture.state == .changed {
            if translation.y > 0 {
                dragDownArrow.image = #imageLiteral(resourceName: "dragDownArrowStraight")
                view.frame.origin = CGPoint(
                    x: 0,
                    y: translation.y
                )
            }
            
        } else if panGesture.state == .ended {
            let velocity = panGesture.velocity(in: view)
            let panLocation = panGesture.translation(in: view)
            
            if velocity.y >= 1500 || panLocation.y >= screenSize.height - 350 {
                UIView.animate(withDuration: 0.2
                    , animations: {
                        self.view.frame.origin = CGPoint(
                            x: self.view.frame.origin.x,
                            y: self.view.frame.size.height
                        )
                        self.mainViewController.darkenBackground.alpha = 0.0
                }, completion: { (isCompleted) in
                    if isCompleted {
                        self.dismiss(animated: false, completion: nil)
                    }
                })
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.center = self.originalPosition!
                })
                dragDownArrow.image = #imageLiteral(resourceName: "dragDownArrow")
            }
        }
        
    }
}
