//
//  ContentView.swift
//  coba Watch App
//
//  Created by masbek mbp-m2 on 05/05/23.
//

import SwiftUI

struct ContentView: View {
    var detailDhikr: DetailDhikr?
    
    var body: some View {
        NavigationStack{
            TabView {
                DigitalCrownView(detailDhikr: .constant(DetailDhikr(id: 1, name: "Any Dhikr", amount: 360)))
                    .tabItem {
                        Image(systemName: "1.circle")
                        Text("Screen 1")
                    }
                DhikrsCarouselView(dhikr: dhikr)
                    .tabItem {
                        Image(systemName: "2.circle")
                        Text("Screen 2")
                    }
            }
            
            .tabViewStyle(PageTabViewStyle())
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
