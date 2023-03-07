//
//  VSliderUIModel.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 12/21/20.
//

import SwiftUI
import VCore

// MARK: - V Slider UI Model
/// Model that describes UI.
public struct VSliderUIModel {
    // MARK: Properties
    fileprivate static let primaryButtonReference: VPrimaryButtonUIModel = .init()
    fileprivate static let toggleReference: VToggleUIModel = .init()
    
    /// Model that contains layout properties.
    public var layout: Layout = .init()
    
    /// Model that contains color properties.
    public var colors: Colors = .init()
    
    /// Model that contains animation properties.
    public var animations: Animations = .init()
    
    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Layout
    /// Model that contains layout properties.
    public struct Layout {
        // MARK: Properties
        /// Slider height. Defaults to `10`.
        public var height: CGFloat = 10
        
        /// Slider corner radius. Defaults to `5`.
        public var cornerRadius: CGFloat = 5
        
        /// Indicates if slider rounds progress view right-edge. Defaults to `true`.
        public var roundsProgressViewRightEdge: Bool = true
        
        var progressViewRoundedCorners: UIRectCorner {
            if roundsProgressViewRightEdge {
                return .allCorners
            } else {
                return []
            }
        }
        
        /// Thumb dimension. Defaults to `20`.
        ///
        /// To hide thumb, set to `0`.
        public var thumbDimension: CGFloat = 20
        
        /// Thumb corner radius. Defaults to `10`.
        public var thumbCornerRadius: CGFloat = 10
        
        /// Thumb border widths. Defaults to `0`.
        public var thumbBorderWidth: CGFloat = 0
        
        /// Thumb shadow radius. Defaults to `2`.
        public var thumbShadowRadius: CGFloat = 2
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }

    // MARK: Colors
    /// Model that contains color properties.
    public struct Colors {
        // MARK: Properties
        /// Slider track colors.
        public var track: StateColors = .init(
            enabled: toggleReference.colors.fill.off,
            disabled: toggleReference.colors.fill.disabled
        )
        
        /// Slider progress colors.
        public var progress: StateColors = .init(
            enabled: toggleReference.colors.fill.on,
            disabled: primaryButtonReference.colors.background.disabled
        )
        
        /// Thumb colors.
        public var thumb: StateColors = .init(
            enabled: toggleReference.colors.thumb.on,
            disabled: toggleReference.colors.thumb.on
        )
        
        /// Thumb border colors.
        public var thumbBorder: StateColors = .init(
            enabled: .init(componentAsset: "Slider.Thumb.Border.enabled"),
            disabled: .init(componentAsset: "Slider.Thumb.Border.disabled")
        )
        
        /// Thumb shadow colors.
        public var thumbShadow: StateColors = .init(
            enabled: .init(componentAsset: "Slider.Thumb.Shadow.enabled"),
            disabled: .init(componentAsset: "Slider.Thumb.Shadow.disabled")
        )
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
        
        // MARK: State Colors
        /// Model that contains colors for component states.
        public typealias StateColors = GenericStateModel_EnabledDisabled<Color>
    }

    // MARK: Animations
    /// Model that contains animation properties.
    public struct Animations {
        // MARK: Properties
        /// Progress animation. Defaults to `nil`.
        public var progress: Animation? = nil
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
}
