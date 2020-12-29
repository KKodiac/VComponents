//
//  VSheetDemoView.swift
//  VComponentsDemo
//
//  Created by Vakhtang Kontridze on 12/23/20.
//

import SwiftUI
import VComponents

// MARK:- V Sheet Demo View
struct VSheetDemoView: View {
    // MARK: Properties
    static let navigationBarTitle: String = "Sheet"
    
    private func sheeContent() -> some View {
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla dapibus volutpat enim, vitae blandit justo iaculis sit amet. Aenean vitae leo tincidunt, sollicitudin mauris a, mollis massa. Sed posuere, nibh non fermentum ultrices, ipsum nunc luctus arcu, a auctor velit nisl ac nibh. Donec vel arcu condimentum, iaculis quam sed, commodo orci.")
    }
}

// MARK:- Body
extension VSheetDemoView {
    var body: some View {
        VBaseView(title: Self.navigationBarTitle, content: {
            ScrollView(content: {
                DemoRowView(type: .titled("Round All"), content: {
                    VSheet(model: .init(layout: .init(roundedCorners: .all)), content: sheeContent)
                })
                
                DemoRowView(type: .titled("Round Top"), content: {
                    VSheet(model: .init(layout: .init(roundedCorners: .top)), content: sheeContent)
                })
                
                DemoRowView(type: .titled("Round Bottom"), content: {
                    VSheet(model: .init(layout: .init(roundedCorners: .bottom)), content: sheeContent)
                })
                
                DemoRowView(type: .titled("Round Custom"), content: {
                    VSheet(model: .init(layout: .init(roundedCorners: .custom([.topLeft, .bottomRight]))), content: sheeContent)
                })
            })
                .background(ColorBook.canvas)
        })
    }
}

// MARK:- Preview
struct VSheetDemoView_Previews: PreviewProvider {
    static var previews: some View {
        VSheetDemoView()
    }
}
