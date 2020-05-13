//
//  ReviewUtil.swift
//  MWN-SWIFT-UI
//
//  Created by Lucas Menezes on 5/12/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

import Foundation
import StoreKit

/**
 Asks for Request Review by chance
 - parameter chance : Double. A number from 0 - 1  meaning the chance of asking the user to review.
 - attention: Please note this method is not garanteed. It is Apple who decides when to show this.
 - returns: Nothing
 */
func displayReviewByProbability(chance : Double) {
    let random = Double.random(in:  0 ..< 1)
    if(random < chance){
        displayReviewController()
    }
}
func displayReviewController() {
    if #available( iOS 10.3, macOS 10.14, *){
        SKStoreReviewController.requestReview()
    } else {
        print("Review Controller isn't available")
    }
}
