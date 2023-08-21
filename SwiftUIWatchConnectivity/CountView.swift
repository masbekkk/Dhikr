
//  DigitalCrownView.swift
//  coba Watch App
//
//  Created by masbek mbp-m2 on 05/05/23.
//

import SwiftUI
import Combine

struct CountView: View {
    @Binding var detailDhikr: DetailDhikr
    
    @State private var scrollAmount: Double = 0.0
    @State private var count: Int = 1
    @State private var trimProgress: Double = 0.0
    @State private var progress: Double = 0.0
    @State private var showAlert: Bool = true
    
    @StateObject var counter = Counter()
    
    let colors: [Color] = [Color.lightTosca, Color.tosca]
    
    var body: some View {
        let maximumValue = Double(counter.amountDhikr)
        NavigationStack {
            ZStack {
                Circle()
                    .stroke(Color.darkTosca, lineWidth: 40)
                    .padding()
                
                VStack {
                    Text("\(counter.count)")
                        .font(.largeTitle)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showAlert = false
                    }
                }
                Circle()
                    .trim(from: 0, to: CGFloat(progress))
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: colors),
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        ),
                        style: StrokeStyle(lineWidth: 40, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .padding()
                
                if showAlert {
                    Text("tap to start")
                        .font(.footnote)
                        .background(.tertiary)
                        .shadow(radius: 10)
                        .cornerRadius(3)
                        .padding()
                }
            }
            .padding()
            VStack{
                Text("\(counter.dhikrName )x")
                    .font(.caption)
                    .padding(.top, 4)
            }
            .padding(.top, 5)
            
            .navigationTitle("Dhikr Now")
            
        }
        .onTapGesture()
        {
            if counter.count < Int(maximumValue) {
                scrollAmount += 1
                counter.increment()
                trimProgress = 1/maximumValue
                progress += trimProgress
            }
            
        }
        .onAppear {
        }
    }
}


struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        CountView(detailDhikr: .constant(DetailDhikr(id: 1, name: "Any Dhikr", amount: 10)))
    }
}

