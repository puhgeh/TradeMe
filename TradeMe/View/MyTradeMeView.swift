//
//  MyTradeMeView.swift
//  TradeMe
//
//  Created by Axel on 12/21/22.
//

import SwiftUI

struct MyTradeMeView: View {
    var body: some View {
        NavigationView {
            Color.blue
                .navigationTitle("My Trade Me")
                .navigationBarTitleDisplayMode(.inline)
                .ignoresSafeArea()
        }
    }
}

struct MyTradeMeView_Previews: PreviewProvider {
    static var previews: some View {
        MyTradeMeView()
    }
}
