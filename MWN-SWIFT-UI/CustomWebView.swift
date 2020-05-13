//
//  CustomWebView.swift
//  MWN-SWIFT-UI
//
//  Created by Lucas Menezes on 5/12/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

import SwiftUI

struct CustomWebView: View {
    var body: some View {
        VStack {
            Button("Finish", action: {
                }).colorInvert()
            Webview(url: URL(string:"https://thehider.surge.sh")!)
        }
        
    }
}

struct CustomWebView_Previews: PreviewProvider {
    static var previews: some View {
        CustomWebView()
    }
}
