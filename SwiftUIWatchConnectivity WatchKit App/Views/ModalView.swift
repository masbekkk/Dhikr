
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
//                .onReceive(Just(scrollAmount)) { newScrollAmount in
//                    //                    counter.setIphoneSendActive(status: false)
//                    //                    print(counter.isIphoneSendActive)
////                    if counter.isIphoneSendActive == false {
//
//                        let scroll = Int(newScrollAmount)
//                        if counter.count != scroll {
//                            count = scroll
////                            counter.setAmountCount(AmountCount: scroll)
////                            counter.increment()
//                            trimProgress = 1 / maximumValue
//                            progress += trimProgress
//                        }
////                    }
//                    if count == 0 {
//                        progress = 0
//                    }
//                }
                Circle()
                    .trim(from: 0, to: CGFloat(progress))
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
                
                //                Circle()
                //                    .frame(width: 20, height: 20)
                //                    .offset(y: -150)
                //                    .foregroundColor(Color.lightTosca)
                //                    .rotationEffect(.degrees(360 * scrollAmount))
                //                    .shadow(
                //                        color: .black,
                //                        radius: 20
                //                    )
                //                    .opacity(0.1)
                //                    .padding()
                
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
            //            .navigationTitle("Dhikr Now")
            //            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 8)
            //            .navigationBarHidden(true)
            .onTapGesture()
            {
                //                print(maximumValue)
//                counter.setIphoneSendActive(status: false)
//                //                print(counter.isIphoneSendActive)
//                if counter.isIphoneSendActive == false {
                    if counter.count < Int(maximumValue) {
                        
                        WKInterfaceDevice.current().play(.click)
                        scrollAmount += 1
                        count = Int(scrollAmount)
                        counter.increment()
//                        counter.setAmountCount(AmountCount: Int(scrollAmount))
                        trimProgress = 1/maximumValue
                        progress += trimProgress
                        
//                    }
                }
                
            }
            .onAppear {
                counter.setAmountCount(AmountCount: 0)
                counter.setAmountDhikr(AmountDhikr: detailDhikr.amount)
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
            //            .padding()
            
        }
    }
}







struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView(detailDhikr: .constant(DetailDhikr(id: 1, name: "Any Dhikr", amount: 10)))
    }
}

