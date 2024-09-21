//
//  OnFirstAppearViewModifier.swift
//  SwiftfulFirebaseBootcamp
//
//  Created by Jackie Lu on 2024/9/21.
//

import Foundation
import SwiftUI


struct OnFirstAppearViewModifier: ViewModifier {
    @State private var didAppear: Bool = false
    let perfrom: (() -> Void)?
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                if !didAppear {
                    perfrom?()
                    didAppear = true
                }
            }
    }

}

extension View {
    
    func onFirstAppear(perfrom: (() -> Void)?) -> some View {
        modifier(OnFirstAppearViewModifier(perfrom: perfrom))
    }
}
