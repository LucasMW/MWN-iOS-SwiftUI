//
//  NewsCellView.swift
//  MWN-SWIFT-UI
//
//  Created by Lucas Menezes on 3/12/20.
//  Copyright © 2020 Lucas Menezes. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

class ItemViewModel : ObservableObject {
    @Published var item : Item? = nil
    func load() {
        guard item != nil else { return }
        let api = API()
        api.getNews { (feed) in
            self.item = feed?.items?.first
        }
    }
    func goToWebPage() {
        if let url = URL(string: item!.id!),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}
struct ItemView: View {
    @ObservedObject var model = ItemViewModel()
    init(item : Item){
        self.model.item = item
    }
    init(model : ItemViewModel){
        self.model = model
    }
    var item : Item {
        return model.item ?? getItemMock()
    }
    @State private var isSharePresented: Bool = false
    var body: some View {
        ZStack {
            WebImage(url: URL(string: item.image ?? "")!).resizable().blendMode(.luminosity).background(Color.black).blur(radius: 20)
            VStack (alignment: .center) {
                ZStack {
                    Text(self.item.title ?? "O PSOL é um partido de pirocas").foregroundColor(Color.white).font(.title)
                    }.background(Color.black)
                ScrollView(.vertical) {
                    Text(self.item.description ?? "").padding(20).background(Color.white).foregroundColor(.black)
                }.background(Color.white)
                
                HStack(alignment: .center, spacing: 50) {
                    Button("Go to page",action: {
                    print("\(self.item.id)")
                    self.model.goToWebPage() }).padding().background(Color.secondary).foregroundColor(.white)
                    Button("Share",action: {
                        self.isSharePresented = true
                        print("\(self.item.id)")
                    }).padding().background(Color.secondary).foregroundColor(Color.white)
                        .sheet(isPresented: $isSharePresented, onDismiss: {
                            print("Dismissed \(self.isSharePresented)")
                        }, content: {
                            ActivityViewController(activityItems: [URL(string: self.item.id!)!])
                        })
                }.padding(.vertical, 50)
                
            }.padding(.all, 30)
            
            }
        .onAppear() {
            //self.model.load()
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(model: ItemViewModel())
    }
}
func getItemMock() -> Item {
    let item = Item(JSONString: itemMock)
    return item ?? Item(title: "O PSOL é um partido de pirocas", description: "des",imageURL: "https://media.breitbart.com/media/2020/04/GettyImages-993512108-640x335.jpg")
}
