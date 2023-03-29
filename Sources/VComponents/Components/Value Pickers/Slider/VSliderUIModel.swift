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
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct VSliderUIModel {
    // MARK: Properties
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
        /// Slider height. Set to `10`.
        public var height: CGFloat = GlobalUIModel.Common.barHeight
        
        /// Slider corner radius. Set to `5`.
        public var cornerRadius: CGFloat = GlobalUIModel.Common.barCornerRadius
        
        /// Indicates if slider rounds progress view right-edge. Set to `true`.
        public var roundsProgressViewRightEdge: Bool = true
        
        var progressViewRoundedCorners: RectCorner {
            if roundsProgressViewRightEdge {
                return .allCorners
            } else {
                return []
            }
        }
        
        /// Thumb dimension. Set to `20`.
        ///
        /// To hide thumb, set to `0`.
        public var thumbDimension: CGFloat = GlobalUIModel.ValuePickers.sliderThumbDimension
        
        /// Thumb corner radius. Set to `10`.
        public var thumbCornerRadius: CGFloat = GlobalUIModel.ValuePickers.sliderThumbCornerRadius
        
        /// Thumb border widths. Set to `0` for `iOS`, and `1` scaled to screen for `macOS`..
        ///
        /// To hide border, set to `0`.
        public var thumbBorderWidth: CGFloat = {
#if os(iOS)
            return 0
#elseif os(macOS)
            return 1/MultiplatformConstants.screenScale
#else
            fatalError() // Not supported
#endif
        }()
        
        /// Thumb shadow radius. Set to `2` for `iOS`, and `1` for `macOS`.
        public var thumbShadowRadius: CGFloat = GlobalUIModel.ValuePickers.sliderThumbShadowRadius
        
        /// Thumb shadow offset. Set to `0x2` for `iOS`, and `0x1` for `macOS`.
        public var thumbShadowOffset: CGSize = GlobalUIModel.ValuePickers.sliderThumbShadowOffset
        
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
            enabled: ColorBook.layerGray,
            disabled: ColorBook.layerGrayDisabled
        )
        
        /// Slider progress colors.
        public var progress: StateColors = .init(
            enabled: ColorBook.accentBlue,
            disabled: ColorBook.accentBluePressedDisabled
        )
        
        /// Thumb colors.
        public var thumb: StateColors = .init(ColorBook.white)
        
        /// Thumb border colors.
        public var thumbBorder: StateColors = {
#if os(iOS)
            return .clearColors
#elseif os(macOS)
            return .init(
                enabled: ColorBook.borderGray,
                disabled: ColorBook.borderGrayDisabled
            )
#else
            fatalError() // Not supported
#endif
        }()
        
        /// Thumb shadow colors.
        public var thumbShadow: StateColors = .init(
            enabled: GlobalUIModel.Common.shadowColorEnabled,
            disabled: GlobalUIModel.Common.shadowColorDisabled
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
        /// Progress animation. Set to `nil`.
        public var progress: Animation? = nil
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
}
