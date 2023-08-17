//
//  DhikrsCarouselView.swift
//  coba Watch App
//
//  Created by masbek mbp-m2 on 08/05/23.
//

import SwiftUI

struct DhikrsCarouselView: View {
    var dhikr: [Dhikr]
    @State var isPresentingModalView: Bool = false
    @State var detail: DetailDhikr = DetailDhikr(id: 1, name: "Istighfar", amount: 10)
    
    var body: some View {
        List {
            ForEach(dhikr, id: \.self) { item in
                VStack(alignment: .leading) {
                    Image(systemName: item.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding([.leading, .top], 10)
                        .foregroundColor(Color.tosca)
                    
                    Text(item.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                        .padding([.leading, .bottom], 10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .animation(.easeInOut(duration: 0.2))
                    
//                    Text("DHIKR NOW")
//                        .padding([.leading, .bottom], 10)
//                        .foregroundColor(Color.tosca)
                    
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    detail = item.details
                    isPresentingModalView = true
                }
            }
        }
        .listStyle(CarouselListStyle())
        .navigationTitle("Dhikr")
        .sheet(isPresented: $isPresentingModalView) {
            ModalView(detailDhikr: $detail)
                .toolbar(content: {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Close") { self.isPresentingModalView = false }
                    }
                })
        }
    }
}


struct DhikrsCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        DhikrsCarouselView(dhikr: [Dhikr(name: "After Pray", imageName: "moon.haze.fill", details: DetailDhikr(id: 1, name: "Lorem", amount: 2)
                                        )])
    }
}
