//
//  Color.swift
//  coba Watch App
//
//  Created by masbek mbp-m2 on 06/05/23.
//

import Foundation
import SwiftUI

extension Color {
    public static var outlineRed: Color {
        return Color(decimalRed: 34.0, green: 0, blue: 3)
    }
    
    public static var darkRed: Color {
        return Color(decimalRed: 221, green: 31, blue: 59)
    }
    
    public static var lightRed: Color {
        return Color(decimalRed: 239, green: 54, blue: 128)
    }
    
    public init(decimalRed red: Double, green: Double, blue: Double) {
        self.init(red: red / 255, green: green / 255, blue: blue / 255)
    }
    
    public static var tosca : Color {
        return Color(decimalRed: 84, green: 196, blue: 191)
    }
    
    public static var lightTosca: Color {
//        return Color(decimalRed: 147, green: 213, blue: 209)
        return Color(decimalRed: 234, green: 249, blue: 249)
    }
    
    public static var darkTosca: Color {
//        return Color(decimalRed: 80, green: 173, blue: 154)
        return Color(decimalRed: 40, green: 86, blue: 77)
    }

}
