//
//  CombineView.swift
//  NewDhikr
//
//  Created by masbek mbp-m2 on 20/08/23.
//

import SwiftUI
import Combine

struct CombineView: View {
    @Binding var detailDhikr: DetailDhikr
    
    @State private var scrollAmount: Double = 0.0
    @State private var count: Int = 1
    @State private var trimProgress: Double = 0.0
    @State private var progress: Double = 0.0
    @State private var showAlert: Bool = true
    
    @StateObject var counter = Counter()
    
    let colors: [Color] = [Color.lightTosca, Color.tosca]
    
    var body: some View {
        let maximumValue = Double(33.0)
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
//        .onReceive(Just(scrollAmount)) { newScrollAmount in
//            //                    counter.setIphoneSendActive(status: false)
//            //                    print(counter.isIphoneSendActive)
////            if counter.isIphoneSendActive {
//                
//                let scroll = Int(newScrollAmount)
//                if counter.count != scroll {
//                    count = scroll
////                    counter.increment()
//                    counter.setAmountCount(AmountCount: scroll)
//                    trimProgress = 1 / maximumValue
//                    progress += trimProgress
//                }
////            }
//            if count == 0 {
//                progress = 0
//            }
//        }

        .onTapGesture()
        {
//            counter.setIphoneSendActive(status: true)
//            print(counter.isIphoneSendActive)
//            if counter.isIphoneSendActive {
                if counter.count < Int(maximumValue) {
                    scrollAmount += 1
//                    counter.increment()
//                    count = Int(scrollAmount)
                    counter.setAmountCount(AmountCount: Int(scrollAmount))
                    trimProgress = 1/maximumValue
                    progress += trimProgress
                    
                }
//            }
            
        }
        .onAppear {
//            counter.setAmountCount(AmountCount: 0)
//            counter.setDhikrName(dhikr: "\(detailDhikr.name ) \(detailDhikr.amount )x")
        }
    }
}


struct Combine_Previews: PreviewProvider {
    static var previews: some View {
        CombineView(detailDhikr: .constant(DetailDhikr(id: 1, name: "Any Dhikr", amount: 10)))
    }
}

