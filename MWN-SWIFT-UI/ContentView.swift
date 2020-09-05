//
//  ContentView.swift
//  MWN-SWIFT-UI
//
//  Created by Lucas Menezes on 3/12/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

class ViewModel : ObservableObject {
    
    @Published var feed : GabFeed? = nil
    var censored = true

    //@Published var items : [Item] = [Item](repeating: Item(forDisplayWith: "display", description: "description"), count: 24)
    init(feed : GabFeed? = nil){
        self.feed = feed
    }
    
    var items : [Item] {
        return feed?.items ?? []
    }
    
    func load() {
        let api = API()
        api.getBehavior { (shouldCensor) in
            print("should censor \(shouldCensor)")
            self.censored = shouldCensor
            api.getNews { (feed) in
                self.feed = feed
                if self.censored {
                    self.feed?.filterFor(bannedWords: Censorship.pandemic)
                }
            }
        }
        
    }
    func goToWebPage(i : Int) {
        if let url = URL(string: items[i].id!),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

struct ContentView: View {
    @ObservedObject var model = ViewModel()
    @State var selected : Int?
    var loading : Bool {
        return posts.count < 1
    }
    var posts : [Item] {
        return model.items
    }
    //should return optional, Webimage can use placeholder without problems
    func imageUrlFor(i : Int) -> URL? {
        return URL(string: posts[i].image ?? "")
    }
    func dateFor(i : Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd-hh:mm:ss"        
        let dateString = String( posts[i].date_published?.split(separator: ".").first ?? "").replacingOccurrences(of: "T", with: "-")
        print(dateString)
        guard let dateObj = dateFormatter.date(from: dateString) else {
            return dateString
        }
        dateFormatter.dateStyle = .long
        let xd = dateFormatter.string(from: dateObj)
        print(xd)
        return xd
    }
    var body: some View {
        
        NavigationView {
            VStack {
                ZStack {
                    Text("Minimal World News").font(.system(size:30))
                        .fontWeight(.heavy)
                        .foregroundColor(Color.white).scaledToFit()
                }.background(Color.black)
                if loading {
                    ActivityIndicatorView()
                } else {
                    EmptyView()
                    //Text(dateFor(i: 0))
                }
                List {
                    ForEach (0..<posts.count, id: \.self){ i in
                        HStack {
                            WebImage(url: self.imageUrlFor(i: i))
                                .resizable()
                                .placeholder(Image(systemName: "photo")).scaledToFit().padding()
                            VStack {
                                Text(self.posts[i].title ?? "").bold().fontWeight(.heavy).scaledToFit()
                                
                                //Text(self.dateFor(i: i)).fontWeight(.light).underline()
                                Text(self.posts[i].description ?? "").font(.system(size: 12))
                               
                                NavigationLink(destination: ItemView(item: self.posts[i]), tag: i, selection: self.$selected) {
                                    EmptyView()
                                }
                                
                            }.onTapGesture {
                                print("go to \(self.posts[i].id ?? "no id")")
                                print("go to \(i)")
                                self.selected = i
                            }.onLongPressGesture {
                                self.model.goToWebPage(i: i)
                            }
                            
                        }
                        
                    }
                }.onAppear(){
                    self.model.load()
                    print("Loading")
                    displayReviewByProbability(chance: 1/100)
                }
            }
            .navigationBarTitle("MWN",displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        //ActivityIndicatorView()
        ContentView(model: ViewModel(feed: GabFeed(JSONString: jsonMock)))
        //Webview(url: URL(string: "https://github.com")!)
    }
}
