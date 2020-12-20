//
//  VPlainButtonViewModel.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 19.12.20.
//

import SwiftUI

// MARK:- V Plain Button ViewModel
public struct VPlainButtonViewModel {
    // MARK: Properties
    public let layout: Layout
    public let colors: Colors
    public let fonts: Fonts
    
    // MARK: Initializers
    public init(layout: Layout = .init(), colors: Colors = .init(), fonts: Fonts = .init()) {
        self.layout = layout
        self.colors = colors
        self.fonts = fonts
    }
}

// MARK:- Layout
extension VPlainButtonViewModel {
    public struct Layout {
        // MARK: Properties
        public let hitAreaOffsetHor: CGFloat
        public let hitAreaOffsetVer: CGFloat
        
        // MARK: Initializers
        public init(hitAreaOffsetHor: CGFloat, hitAreaOffsetVer: CGFloat) {
            self.hitAreaOffsetHor = hitAreaOffsetHor
            self.hitAreaOffsetVer = hitAreaOffsetVer
        }
        
        public init() {
            self.init(
                hitAreaOffsetHor: 15,
                hitAreaOffsetVer: 5
            )
        }
    }
}

// MARK:- Colors
extension VPlainButtonViewModel {
    public struct Colors {
        // MARK: Properties
        public let foreground: ForegroundColors
        
        // MARK: Initializers
        public init(foreground: ForegroundColors = .init()) {
            self.foreground = foreground
        }
    }
}

extension VPlainButtonViewModel.Colors {
    public struct ForegroundColors {
        // MARK: Properties
        public let enabled: Color
        public let pressed: Color
        public let disabled: Color
        
        public let pressedOpacity: Double
        
        // MARK: Initializers
        public init(enabled: Color, pressed: Color, disabled: Color, pressedOpacity: Double) {
            self.enabled = enabled
            self.pressed = pressed
            self.disabled = disabled
            self.pressedOpacity = pressedOpacity
        }
        
        public init() {
            self.init(
                enabled: ColorBook.PlainButton.Text.enabled,
                pressed: ColorBook.PlainButton.Text.pressed,
                disabled: ColorBook.PlainButton.Text.disabled,
                pressedOpacity: 0.5
            )
        }
    }
}

// MARK:- Fonts
extension VPlainButtonViewModel {
    public struct Fonts {
        // MARK: Properties
        public let title: Font
        
        // MARK: Initializers
        public init(title: Font) {
            self.title = title
        }
        
        public init() {
            self.init(
                title: FontBook.buttonLarge
            )
        }
    }
}

// MARK:- Mapping
extension VPlainButtonViewModel.Colors {
    static func foreground(state: VPlainButtonActualState, vm: VPlainButtonViewModel) -> Color {
        switch state {
        case .enabled: return vm.colors.foreground.enabled
        case .pressed: return vm.colors.foreground.pressed
        case .disabled: return vm.colors.foreground.disabled
        }
    }
    
    static func foregroundOpacity(state: VPlainButtonActualState, vm: VPlainButtonViewModel) -> Double {
        switch state {
        case .enabled: return 1
        case .pressed: return vm.colors.foreground.pressedOpacity
        case .disabled: return 1
        }
    }
}
