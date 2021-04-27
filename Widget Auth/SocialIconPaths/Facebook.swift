//
//  Facebook.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 27/04/21.
//

import Foundation
import SwiftUI

struct Facebook: Shape {
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.05656*width, y: 0.35581*height))
        path.addLine(to: CGPoint(x: 0.05656*width, y: 0.79359*height))
        path.addCurve(to: CGPoint(x: 0.20641*width, y: 0.94345*height), control1: CGPoint(x: 0.05656*width, y: 0.87644*height), control2: CGPoint(x: 0.12357*width, y: 0.94345*height))
        path.addLine(to: CGPoint(x: 0.79359*width, y: 0.94345*height))
        path.addCurve(to: CGPoint(x: 0.94344*width, y: 0.79359*height), control1: CGPoint(x: 0.87644*width, y: 0.94345*height), control2: CGPoint(x: 0.94344*width, y: 0.87644*height))
        path.addLine(to: CGPoint(x: 0.94344*width, y: 0.35734*height))
        path.addCurve(to: CGPoint(x: 0.50291*width, y: 0.40973*height), control1: CGPoint(x: 0.81671*width, y: 0.39048*height), control2: CGPoint(x: 0.66538*width, y: 0.40973*height))
        path.addCurve(to: CGPoint(x: 0.05656*width, y: 0.35581*height), control1: CGPoint(x: 0.33789*width, y: 0.40973*height), control2: CGPoint(x: 0.18445*width, y: 0.38988*height))
        path.move(to: CGPoint(x: 0.00014*width, y: 0.17248*height))
        path.addLine(to: CGPoint(x: 0, y: 0.82052*height))
        path.addCurve(to: CGPoint(x: 0.1795*width, y: height), control1: CGPoint(x: 0, y: 0.91945*height), control2: CGPoint(x: 0.08055*width, y: height))
        path.addLine(to: CGPoint(x: 0.82051*width, y: height))
        path.addCurve(to: CGPoint(x: width, y: 0.82052*height), control1: CGPoint(x: 0.91946*width, y: height), control2: CGPoint(x: width, y: 0.91945*height))
        path.addLine(to: CGPoint(x: width, y: 0.17948*height))
        path.addCurve(to: CGPoint(x: 0.99996*width, y: 0.17586*height), control1: CGPoint(x: width, y: 0.17828*height), control2: CGPoint(x: 0.99999*width, y: 0.17706*height))
        path.addLine(to: CGPoint(x: 0.99996*width, y: 0.34114*height))
        path.addCurve(to: CGPoint(x: 0.97704*width, y: 0.34807*height), control1: CGPoint(x: 0.99243*width, y: 0.3435*height), control2: CGPoint(x: 0.98478*width, y: 0.34581*height))
        path.addLine(to: CGPoint(x: 0.97704*width, y: 0.80579*height))
        path.addCurve(to: CGPoint(x: 0.80579*width, y: 0.97705*height), control1: CGPoint(x: 0.97704*width, y: 0.9002*height), control2: CGPoint(x: 0.90019*width, y: 0.97705*height))
        path.addLine(to: CGPoint(x: 0.19421*width, y: 0.97705*height))
        path.addCurve(to: CGPoint(x: 0.02296*width, y: 0.80579*height), control1: CGPoint(x: 0.09981*width, y: 0.97705*height), control2: CGPoint(x: 0.02296*width, y: 0.9002*height))
        path.addLine(to: CGPoint(x: 0.02296*width, y: 0.34636*height))
        path.addCurve(to: CGPoint(x: 0.00003*width, y: 0.3393*height), control1: CGPoint(x: 0.01521*width, y: 0.34406*height), control2: CGPoint(x: 0.00757*width, y: 0.34171*height))
        path.addLine(to: CGPoint(x: 0.00003*width, y: 0.17848*height))
        path.addCurve(to: CGPoint(x: 0.00014*width, y: 0.17248*height), control1: CGPoint(x: 0.00004*width, y: 0.17647*height), control2: CGPoint(x: 0.00007*width, y: 0.17447*height))
        path.move(to: CGPoint(x: 0.05656*width, y: 0.20619*height))
        path.addCurve(to: CGPoint(x: 0.20641*width, y: 0.05635*height), control1: CGPoint(x: 0.05656*width, y: 0.12356*height), control2: CGPoint(x: 0.12357*width, y: 0.05635*height))
        path.addLine(to: CGPoint(x: 0.79359*width, y: 0.05635*height))
        path.addCurve(to: CGPoint(x: 0.94344*width, y: 0.20619*height), control1: CGPoint(x: 0.87644*width, y: 0.05635*height), control2: CGPoint(x: 0.94344*width, y: 0.12356*height))
        path.addLine(to: CGPoint(x: 0.94344*width, y: 0.79359*height))
        path.addCurve(to: CGPoint(x: 0.79359*width, y: 0.94345*height), control1: CGPoint(x: 0.94344*width, y: 0.87644*height), control2: CGPoint(x: 0.87644*width, y: 0.94345*height))
        path.addLine(to: CGPoint(x: 0.20641*width, y: 0.94345*height))
        path.addCurve(to: CGPoint(x: 0.05656*width, y: 0.79359*height), control1: CGPoint(x: 0.12357*width, y: 0.94345*height), control2: CGPoint(x: 0.05656*width, y: 0.87644*height))
        path.addLine(to: CGPoint(x: 0.05656*width, y: 0.20619*height))
        path.move(to: CGPoint(x: 0.02296*width, y: 0.19421*height))
        path.addLine(to: CGPoint(x: 0.02296*width, y: 0.80579*height))
        path.addCurve(to: CGPoint(x: 0.19421*width, y: 0.97705*height), control1: CGPoint(x: 0.02296*width, y: 0.9002*height), control2: CGPoint(x: 0.09981*width, y: 0.97705*height))
        path.addLine(to: CGPoint(x: 0.80579*width, y: 0.97705*height))
        path.addCurve(to: CGPoint(x: 0.97704*width, y: 0.80579*height), control1: CGPoint(x: 0.9002*width, y: 0.97705*height), control2: CGPoint(x: 0.97704*width, y: 0.9002*height))
        path.addLine(to: CGPoint(x: 0.97704*width, y: 0.19421*height))
        path.addCurve(to: CGPoint(x: 0.80579*width, y: 0.02296*height), control1: CGPoint(x: 0.97704*width, y: 0.09981*height), control2: CGPoint(x: 0.9002*width, y: 0.02296*height))
        path.addLine(to: CGPoint(x: 0.19421*width, y: 0.02296*height))
        path.addCurve(to: CGPoint(x: 0.02296*width, y: 0.19421*height), control1: CGPoint(x: 0.09981*width, y: 0.02296*height), control2: CGPoint(x: 0.02296*width, y: 0.09981*height))
        path.move(to: CGPoint(x: 0.82871*width, y: 0))
        path.addLine(to: CGPoint(x: 0.16939*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.15623*width, y: 0.00056*height), control1: CGPoint(x: 0.16496*width, y: 0), control2: CGPoint(x: 0.16058*width, y: 0.00022*height))
        path.addCurve(to: CGPoint(x: 0.00014*width, y: 0.17248*height), control1: CGPoint(x: 0.07019*width, y: 0.01178*height), control2: CGPoint(x: 0.00305*width, y: 0.08415*height))
        path.addCurve(to: CGPoint(x: 0.1795*width, y: 0), control1: CGPoint(x: 0.00383*width, y: 0.07677*height), control2: CGPoint(x: 0.08289*width, y: 0))
        path.addLine(to: CGPoint(x: 0.82051*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.99996*width, y: 0.17586*height), control1: CGPoint(x: 0.91825*width, y: 0), control2: CGPoint(x: 0.99803*width, y: 0.07859*height))
        path.addLine(to: CGPoint(x: 0.99996*width, y: 0.17551*height))
        path.addCurve(to: CGPoint(x: 0.84834*width, y: 0.00116*height), control1: CGPoint(x: 0.99852*width, y: 0.08736*height), control2: CGPoint(x: 0.93319*width, y: 0.01441*height))
        path.addCurve(to: CGPoint(x: 0.82871*width, y: 0), control1: CGPoint(x: 0.8419*width, y: 0.00042*height), control2: CGPoint(x: 0.83535*width, y: 0))
        path.move(to: CGPoint(x: 0.79359*width, y: 0.05635*height))
        path.addLine(to: CGPoint(x: 0.20641*width, y: 0.05635*height))
        path.addCurve(to: CGPoint(x: 0.05656*width, y: 0.20619*height), control1: CGPoint(x: 0.12357*width, y: 0.05635*height), control2: CGPoint(x: 0.05656*width, y: 0.12356*height))
        path.addLine(to: CGPoint(x: 0.05656*width, y: 0.35581*height))
        path.addCurve(to: CGPoint(x: 0.5029*width, y: 0.40972*height), control1: CGPoint(x: 0.18445*width, y: 0.38988*height), control2: CGPoint(x: 0.33789*width, y: 0.40972*height))
        path.addCurve(to: CGPoint(x: 0.94343*width, y: 0.35734*height), control1: CGPoint(x: 0.66537*width, y: 0.40972*height), control2: CGPoint(x: 0.8167*width, y: 0.39047*height))
        path.addLine(to: CGPoint(x: 0.94343*width, y: 0.20619*height))
        path.addCurve(to: CGPoint(x: 0.79359*width, y: 0.05635*height), control1: CGPoint(x: 0.94344*width, y: 0.12356*height), control2: CGPoint(x: 0.87643*width, y: 0.05635*height))
        path.move(to: CGPoint(x: 0.82051*width, y: 0))
        path.addLine(to: CGPoint(x: 0.1795*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.00014*width, y: 0.17248*height), control1: CGPoint(x: 0.08289*width, y: 0), control2: CGPoint(x: 0.00383*width, y: 0.07677*height))
        path.addCurve(to: CGPoint(x: 0.00004*width, y: 0.17848*height), control1: CGPoint(x: 0.00007*width, y: 0.17447*height), control2: CGPoint(x: 0.00004*width, y: 0.17647*height))
        path.addLine(to: CGPoint(x: 0.00004*width, y: 0.3393*height))
        path.addLine(to: CGPoint(x: 0, y: 0.19421*height))
        path.addCurve(to: CGPoint(x: 0.19421*width, y: 0.02296*height), control1: CGPoint(x: 0.02296*width, y: 0.09981*height), control2: CGPoint(x: 0.09981*width, y: 0.02296*height))
        path.addLine(to: CGPoint(x: 0.80579*width, y: 0.02296*height))
        path.addCurve(to: CGPoint(x: 0.97704*width, y: 0.19421*height), control1: CGPoint(x: 0.9002*width, y: 0.02296*height), control2: CGPoint(x: 0.97704*width, y: 0.09981*height))
        path.addLine(to: CGPoint(x: 0.97704*width, y: 0.34807*height))
        path.addLine(to: CGPoint(x: 0, y: 0.17586*height))
        path.addCurve(to: CGPoint(x: 0.82051*width, y: 0), control1: CGPoint(x: 0.99803*width, y: 0.07859*height), control2: CGPoint(x: 0.91825*width, y: 0))
        path.move(to: CGPoint(x: 0.80579*width, y: 0.02296*height))
        path.addLine(to: CGPoint(x: 0.19421*width, y: 0.02296*height))
        path.addCurve(to: CGPoint(x: 0.02296*width, y: 0.19421*height), control1: CGPoint(x: 0.09981*width, y: 0.02296*height), control2: CGPoint(x: 0.02296*width, y: 0.09981*height))
        path.addLine(to: CGPoint(x: 0.02296*width, y: 0.34636*height))
        path.addLine(to: CGPoint(x: 0, y: 0.20619*height))
        path.addCurve(to: CGPoint(x: 0.20641*width, y: 0.05635*height), control1: CGPoint(x: 0.05656*width, y: 0.12356*height), control2: CGPoint(x: 0.12357*width, y: 0.05635*height))
        path.addLine(to: CGPoint(x: 0.79359*width, y: 0.05635*height))
        path.addCurve(to: CGPoint(x: 0.94344*width, y: 0.20619*height), control1: CGPoint(x: 0.87644*width, y: 0.05635*height), control2: CGPoint(x: 0.94344*width, y: 0.12356*height))
        path.addLine(to: CGPoint(x: 0.94344*width, y: 0.35735*height))
        path.addLine(to: CGPoint(x: 0, y: 0.19421*height))
        path.addCurve(to: CGPoint(x: 0.80579*width, y: 0.02296*height), control1: CGPoint(x: 0.97704*width, y: 0.09981*height), control2: CGPoint(x: 0.9002*width, y: 0.02296*height))
        path.move(to: CGPoint(x: 0.76831*width, y: 0.27017*height))
        path.addLine(to: CGPoint(x: 0.83241*width, y: 0.27017*height))
        path.addLine(to: CGPoint(x: 0.83241*width, y: 0.14043*height))
        path.addLine(to: CGPoint(x: 0.69343*width, y: 0.14043*height))
        path.addCurve(to: CGPoint(x: 0.54059*width, y: 0.29327*height), control1: CGPoint(x: 0.60902*width, y: 0.14043*height), control2: CGPoint(x: 0.54059*width, y: 0.20886*height))
        path.addLine(to: CGPoint(x: 0.54059*width, y: 0.37088*height))
        path.addLine(to: CGPoint(x: 0.43095*width, y: 0.37088*height))
        path.addLine(to: CGPoint(x: 0.43095*width, y: 0.50062*height))
        path.addLine(to: CGPoint(x: 0.54059*width, y: 0.50062*height))
        path.addLine(to: CGPoint(x: 0.54059*width, y: 0.90008*height))
        path.addLine(to: CGPoint(x: 0.7111*width, y: 0.90008*height))
        path.addLine(to: CGPoint(x: 0.7111*width, y: 0.50062*height))
        path.addLine(to: CGPoint(x: 0.83241*width, y: 0.50062*height))
        path.addLine(to: CGPoint(x: 0.83241*width, y: 0.37088*height))
        path.addLine(to: CGPoint(x: 0.7111*width, y: 0.37088*height))
        path.addLine(to: CGPoint(x: 0.7111*width, y: 0.32736*height))
        path.addCurve(to: CGPoint(x: 0.76831*width, y: 0.27017*height), control1: CGPoint(x: 0.71111*width, y: 0.29578*height), control2: CGPoint(x: 0.73672*width, y: 0.27017*height))
        path.closeSubpath()
        return path
    }
}