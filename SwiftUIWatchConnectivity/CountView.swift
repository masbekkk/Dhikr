
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
    @State private var isAnimating = false
    @State private var showAlert: Bool = true
    
    @StateObject var counter = Counter()
    @ObservedObject private var heartRate = HeartRate()
    
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
//                        .font(.largeTitle)
                        .font(.custom("SF Pro", size: 45.0, relativeTo: .largeTitle))
                        .padding(.top, 4)
                    
                    HStack {
                        Text("\(heartRate.heartRateValue)")
                            .font(.body)
                        
                        VStack {
                            Image(systemName: "heart.fill")
                                .scaleEffect(isAnimating ? 0.5 : 0.7)
                                .animation(
                                    .easeOut(duration: 1.0)
                                    .repeatForever(autoreverses: true)
                                )
                            Text("BPM")
                                .font(.footnote)
                        }
                        .foregroundColor(.red)
                    }
                    .padding([.top, .bottom], 3)

                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        showAlert = false
                    }
                }
                Circle()
                    .trim(from: 0, to: CGFloat(counter.progressDhikr))
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
                Text("\(counter.dhikrName)")
                    .font(.custom("SF Pro", size: 16.0, relativeTo: .largeTitle))
                    .padding(.top, 4)
            }
            .padding(.top, 5)
            
            .navigationTitle("Dhikr Now")
            
        }
        .onTapGesture()
        {
            if counter.count < Int(maximumValue) {
                print(counter.progressDhikr)
                scrollAmount += 1
                counter.increment()
                trimProgress = 1/maximumValue
                progress += trimProgress
                counter.setProgressDhikr(progress: trimProgress)
            }
            
        }
        .onAppear {
            heartRate.start()
        }
    }
}


struct CountView_Previews: PreviewProvider {
    static var previews: some View {
        CountView(detailDhikr: .constant(DetailDhikr(id: 1, name: "Any Dhikr", amount: 10)))
    }
}

