//
//  ForceGestureRecognizer.swift
//  Weather Shaker
//
//  Created by Mark Lawrence on 4/12/18.
//  Copyright © 2018 Mark Lawrence. All rights reserved.
//

import Foundation
import UIKit.UIGestureRecognizerSubclass

class ForceGestureRecognizer: UIGestureRecognizer {
    
    var forceValue: CGFloat = 0
    var maxValue: CGFloat!
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesBegan(touches, with: event)
        handleForceWithTouches(touches: touches)
        state = .began
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        handleForceWithTouches(touches: touches)
        state = .changed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        handleForceWithTouches(touches: touches)
        state = .ended
    }
    
    
    
    func handleForceWithTouches(touches: Set<UITouch>) {
        
        //only do something is one touch is received
        if touches.count != 1 {
            state = .failed
            return
        }
        
        //check if touch is valid, otherwise set state to failed and return
        guard let touch = touches.first else {
            state = .failed
            return
        }
        
        //if everything is ok, set our variables.
        forceValue = touch.force
        maxValue = touch.maximumPossibleForce
    }
    
    //This is called when our state is set to .ended.
    public override func reset() {
        super.reset()
        forceValue = 0.0
    }
}