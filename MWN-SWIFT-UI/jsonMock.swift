//
//  jsonMock.swift
//  MWN-SWIFT-UI
//
//  Created by Lucas Menezes on 5/11/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

import Foundation

let jsonMock = """
{"version":"https://jsonfeed.org/version/1","title":"GabTrends.com Feed","home_page_url":"https://trends.gab.com/","feed_url":"https://trends.gab.com/trend-feed","description":"Hourly updates from the people-powered newsroom.","icon":"https://trends.gab.com/img/social-card.jpg","author":{"name":"Gab.com","url":"https://gab.com/"},"items":[\(itemMock)]}
"""
let itemMock = """
{"id":"https://thehider.surge.sh/","title":"PROTECT YOUR PRIVACY.HIDE IN PLAIN SIGHT.","image":"https://thehider.surge.sh/img/logo.png5.jpg","date_published":"2020-05-10T15:53:27.647Z","date_modified":"2020-05-10T15:53:27.647Z","author":{"name":"www.breitbart.com"}, "description":  "PROTECT YOUR PRIVACY.HIDE IN PLAIN SIGHT; STORE YOUR SECRET FILES INSIDE IMAGES; Insert an image (JPG, PNG or BMP), and a file which you want to hide (it can be any format). The Hider will hide the file inside that image. EASY RECOVERY. Simply select the image which contains the hidden file and The Hider will automatically extract it for you."}
"""
