//
//  Google.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 27/04/21.
//

import Foundation
import SwiftUI

struct Google: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.99952*width, y: 0.50935*height))
        path.addCurve(to: CGPoint(x: 0.98876*width, y: 0.40748*height), control1: CGPoint(x: 0.99952*width, y: 0.46839*height), control2: CGPoint(x: 0.99612*width, y: 0.43849*height))
        path.addLine(to: CGPoint(x: 0.50996*width, y: 0.40748*height))
        path.addLine(to: CGPoint(x: 0.50996*width, y: 0.5924*height))
        path.addLine(to: CGPoint(x: 0.791*width, y: 0.5924*height))
        path.addCurve(to: CGPoint(x: 0.68675*width, y: 0.75406*height), control1: CGPoint(x: 0.78534*width, y: 0.63835*height), control2: CGPoint(x: 0.75474*width, y: 0.70756*height))
        path.addLine(to: CGPoint(x: 0.68579*width, y: 0.76026*height))
        path.addLine(to: CGPoint(x: 0.83718*width, y: 0.87485*height))
        path.addLine(to: CGPoint(x: 0.84767*width, y: 0.87587*height))
        path.addCurve(to: CGPoint(x: 0.99952*width, y: 0.50935*height), control1: CGPoint(x: 0.94399*width, y: 0.78895*height), control2: CGPoint(x: 0.99952*width, y: 0.66105*height))
        path.move(to: CGPoint(x: 0.50996*width, y: 0.99656*height))
        path.addCurve(to: CGPoint(x: 0.84767*width, y: 0.87587*height), control1: CGPoint(x: 0.64765*width, y: 0.99656*height), control2: CGPoint(x: 0.76324*width, y: 0.95227*height))
        path.addLine(to: CGPoint(x: 0.68675*width, y: 0.75406*height))
        path.addCurve(to: CGPoint(x: 0.50996*width, y: 0.80389*height), control1: CGPoint(x: 0.64368*width, y: 0.78341*height), control2: CGPoint(x: 0.58589*width, y: 0.80389*height))
        path.addCurve(to: CGPoint(x: 0.21985*width, y: 0.59683*height), control1: CGPoint(x: 0.37511*width, y: 0.80389*height), control2: CGPoint(x: 0.26065*width, y: 0.71697*height))
        path.addLine(to: CGPoint(x: 0.21387*width, y: 0.59733*height))
        path.addLine(to: CGPoint(x: 0.05645*width, y: 0.71636*height))
        path.addLine(to: CGPoint(x: 0.05439*width, y: 0.72195*height))
        path.addCurve(to: CGPoint(x: 0.50996*width, y: 0.99656*height), control1: CGPoint(x: 0.13825*width, y: 0.88473*height), control2: CGPoint(x: 0.31051*width, y: 0.99656*height))
        path.move(to: CGPoint(x: 0.21985*width, y: 0.59683*height))
        path.addCurve(to: CGPoint(x: 0.20285*width, y: 0.49828*height), control1: CGPoint(x: 0.20908*width, y: 0.56583*height), control2: CGPoint(x: 0.20285*width, y: 0.53261*height))
        path.addCurve(to: CGPoint(x: 0.21928*width, y: 0.39973*height), control1: CGPoint(x: 0.20285*width, y: 0.46395*height), control2: CGPoint(x: 0.20908*width, y: 0.43074*height))
        path.addLine(to: CGPoint(x: 0.219*width, y: 0.39313*height))
        path.addLine(to: CGPoint(x: 0.05961*width, y: 0.27218*height))
        path.addLine(to: CGPoint(x: 0.05439*width, y: 0.27461*height))
        path.addCurve(to: CGPoint(x: 0, y: 0.49828*height), control1: CGPoint(x: 0.01983*width, y: 0.34215*height), control2: CGPoint(x: 0, y: 0.418*height))
        path.addCurve(to: CGPoint(x: 0.05439*width, y: 0.72195*height), control1: CGPoint(x: 0, y: 0.57856*height), control2: CGPoint(x: 0.01983*width, y: 0.65441*height))
        path.addLine(to: CGPoint(x: 0.21985*width, y: 0.59683*height))
        path.move(to: CGPoint(x: 0.50996*width, y: 0.19267*height))
        path.addCurve(to: CGPoint(x: 0.70714*width, y: 0.26686*height), control1: CGPoint(x: 0.60572*width, y: 0.19267*height), control2: CGPoint(x: 0.67031*width, y: 0.23308*height))
        path.addLine(to: CGPoint(x: 0.85107*width, y: 0.12955*height))
        path.addCurve(to: CGPoint(x: 0.50996*width, y: 0), control1: CGPoint(x: 0.76268*width, y: 0.04927*height), control2: CGPoint(x: 0.64765*width, y: 0))
        path.addCurve(to: CGPoint(x: 0.05439*width, y: 0.27461*height), control1: CGPoint(x: 0.31051*width, y: 0), control2: CGPoint(x: 0.13825*width, y: 0.11184*height))
        path.addLine(to: CGPoint(x: 0.21928*width, y: 0.39973*height))
        path.addCurve(to: CGPoint(x: 0.50996*width, y: 0.19267*height), control1: CGPoint(x: 0.26065*width, y: 0.27959*height), control2: CGPoint(x: 0.37511*width, y: 0.19267*height))
        return path
    }
}
