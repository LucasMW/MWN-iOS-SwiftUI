//
//  ActivityViewController.swift
//  MWN-SWIFT-UI
//
//  Created by Lucas Menezes on 5/13/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

//Based on https://stackoverflow.com/a/58341956

import UIKit
import SwiftUI

struct ActivityViewController: UIViewControllerRepresentable {

    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}
