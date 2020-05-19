/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct GabFeed : Mappable {
	var version : String?
	var title : String?
	var home_page_url : String?
	var feed_url : String?
	var description : String?
	var icon : String?
	var author : Author?
	var items : [Item]?

	init?(map: Map) {

	}

    mutating func filterFor(bannedWords : [String]) {
        guard let itens = self.items else { return }
        let filtered = itens.filter({ (item) -> Bool in
            var banned = false
            for word in bannedWords {
                guard let description = item.description?.lowercased(), let title = item.title?.lowercased() else {
                    continue
                }
                banned = description.contains(word) || title.contains(word)
                if banned {
                    print("remove \(title) because of \(word)")
                    print(word)
                    return !banned
                }
            }
            return !banned
        })
        print("removed \(itens.count - filtered.count) items")
        self.items = filtered
    }
    mutating func filterFor(bannedSites : [String]) {
        guard let itens = self.items else { return }
        let filtered = itens.filter({ (item) -> Bool in
            var banned = false
            for site in bannedSites {
                guard let id = item.id, let author = item.author?.name  else {
                    continue
                }
                banned = id.contains(site) || author.contains(site)
                if banned {
                    print("remove \(author) because of \(site)")
                    print(site)
                    return !banned
                }
            }
            return !banned
        })
        print("removed \(itens.count - filtered.count) items")
        self.items = filtered
    }
    
	mutating func mapping(map: Map) {

		version <- map["version"]
		title <- map["title"]
		home_page_url <- map["home_page_url"]
		feed_url <- map["feed_url"]
		description <- map["description"]
		icon <- map["icon"]
		author <- map["author"]
		items <- map["items"]
	}

}
