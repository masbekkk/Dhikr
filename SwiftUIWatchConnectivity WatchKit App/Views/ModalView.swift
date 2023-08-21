
//  DigitalCrownView.swift
//  coba Watch App
//
//  Created by masbek mbp-m2 on 05/05/23.
//

import SwiftUI
import Combine
import WatchKit

struct ModalView: View {
    @Binding var detailDhikr: DetailDhikr
    
    @State private var scrollAmount: Double = 0.0
    @State private var count: Int = 1
    @State private var trimProgress: Double = 0.0
    @State private var progress: Double = 0.0
    @State private var isAnimating = false
    @State private var showAlert: Bool = true
    
    @ObservedObject private var heartRate = HeartRate()
    @StateObject var counter = Counter()
    
    let colors: [Color] = [Color.lightTosca, Color.tosca]
    
    var body: some View {
        let maximumValue = Double(detailDhikr.amount)
        NavigationStack {
            ZStack {
                Circle()
                    .stroke(Color.darkTosca, lineWidth: 20)
                
                VStack {
                    Text("\(counter.count)")
                        .font(.title)
                    
                    HStack {
                        Text("\(heartRate.heartRateValue)")
                            .font(.caption2)
                        
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
                    .padding(.bottom, 3)
                    .onAppear {
                        isAnimating = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            showAlert = false
                        }
                    }
                }
                .focusable(true)
                .digitalCrownRotation(
                    $scrollAmount,
                    from: 1,
                    through: maximumValue,
                    by: 0.1,
                    sensitivity: .low,
                    isContinuous: false
                )
                Circle()
                    .trim(from: 0, to: CGFloat(counter.progressDhikr))
                    .stroke(
                        AngularGradient(
                            gradient: Gradient(colors: colors),
                            center: .center,
                            startAngle: .degrees(0),
                            endAngle: .degrees(360)
                        ),
                        style: StrokeStyle(lineWidth: 20, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                if showAlert {
                    Text("tap or scroll to start")
                        .font(.footnote)
                        .background(.tertiary)
                        .shadow(radius: 10)
                        .cornerRadius(3)
                        .padding()
                }
            }
            .padding(.top, 2)
            .padding(.top, 8)
            .onTapGesture()
            {
                
                if counter.count < Int(maximumValue) {
                    print(counter.progressDhikr)
                    WKInterfaceDevice.current().play(.click)
                    scrollAmount += 1
                    count = Int(scrollAmount)
                    counter.increment()
                    trimProgress = 1/maximumValue
                    progress += trimProgress
                    counter.setProgressDhikr(progress: trimProgress)
                }
                
            }
            .onAppear {
                counter.setAmountCount(AmountCount: 0)
                counter.setAmountDhikr(AmountDhikr: detailDhikr.amount)
                counter.setProgressDhikr(progress: progress)
                //                counter.increment()
                counter.setDhikrName(dhikr: "\(detailDhikr.name ) \(detailDhikr.amount )x")
                heartRate.start()
            }
            VStack{
                Text("\(detailDhikr.name ) \(detailDhikr.amount )x")
                    .font(.caption)
                    .padding(.top, 4)
            }
            .padding(.top, 5)
        }
    }
}







struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(detailDhikr: .constant(DetailDhikr(id: 1, name: "Any Dhikr", amount: 10)))
    }
}

