//
//  VStepperUIModel.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 2/4/21.
//

import SwiftUI
import VCore

// MARK: - V Stepper UI Model
/// Model that describes UI.
public struct VStepperUIModel {
    // MARK: Properties
    fileprivate static let segmentedPickerReference: VSegmentedPickerUIModel = .init()
    
    /// Model that contains layout properties.
    public var layout: Layout = .init()
    
    /// Model that contains color properties.
    public var colors: Colors = .init()
    
    /// Model that contains misc properties.
    public var misc: Misc = .init()
    
    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Layout
    /// Model that contains layout properties.
    public struct Layout {
        // MARK: Properties
        /// Stepper size.Defaults to `94` width and `32` height, similarly to native toggle.
        public var size: CGSize = .init(width: 94, height: 32)
        
        /// Stepper corner radius. Defaults to `7`, similarly to native toggle.
        public var cornerRadius: CGFloat = 7
        
        /// Plus and minus icon dimensions. Defaults to `15`.
        public var iconDimension: CGFloat = 15
        
        /// Plus and minus button divider size. Defaults to width `1` and height `19`.
        public var divider: CGSize = segmentedPickerReference.layout.dividerSize
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }

    // MARK: Layout
    /// Model that contains color properties.
    public struct Colors {
        // MARK: Properties
        /// Background colors.
        public var background: StateColors = segmentedPickerReference.colors.background
        
        /// Plus and minus button background colors.
        public var buttonBackground: ButtonStateColors = .init(
            enabled: .clear,
            pressed: .init(componentAsset: "color_200.200.200_70.70.70"),
            disabled: .clear
        )
        
        /// Plus and minus icon colors.
        public var buttonIcon: ButtonStateColors = .init(
            enabled: ColorBook.primary,
            pressed: ColorBook.primary, // Looks better this way
            disabled: ColorBook.primaryPressedDisabled
        )
        
        /// Plus and minus button divider colors.
        public var divider: StateColors = segmentedPickerReference.colors.divider
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
        
        // MARK: State Colors
        /// Model that contains colors for component states.
        public typealias StateColors = GenericStateModel_EnabledDisabled<Color>
        
        // MARK: Button State Colors
        /// Model that contains colors for component states.
        public typealias ButtonStateColors = GenericStateModel_EnabledPressedDisabled<Color>
    }

    // MARK: Misc
    /// Model that contains misc properties.
    public struct Misc {
        // MARK: Properties
        /// Time interval after which long press incrementation begins. Defaults to `1` second.
        public var intervalToStartLongPressIncrement: TimeInterval = 1
        
        /// Exponent by which long press incrementation happens. Defaults to `2`.
        ///
        /// For instance, if exponent is set to `2`, increment would increase by a factor of `2` every second.
        /// So, `1`, `2`, `4`, `8` ... .
        public var longPressIncrementExponent: Int = 2
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
}
