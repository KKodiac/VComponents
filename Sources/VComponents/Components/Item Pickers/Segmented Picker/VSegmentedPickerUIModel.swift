//
//  VSegmentedPickerUIModel.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 1/7/21.
//

import SwiftUI
import VCore

// MARK: - V Segmented Picker UI Model
/// Model that describes UI.
public struct VSegmentedPickerUIModel {
    // MARK: Properties
    fileprivate static let toggleReference: VToggleUIModel = .init()
    fileprivate static let sliderReference: VSliderUIModel = .init()
    
    /// Model that contains layout properties.
    public var layout: Layout = .init()
    
    /// Model that contains color properties.
    public var colors: Colors = .init()
    
    /// Model that contains font properties.
    public var fonts: Fonts = .init()
    
    /// Model that contains animation properties.
    public var animations: Animations = .init()
    
    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Layout
    /// Model that contains layout properties.
    public struct Layout {
        // MARK: Properties
        /// Picker height. Defaults to `31`, similarly to native picker.
        public var height: CGFloat = 31
        
        /// Picker corner radius. Defaults to `8`, similarly to native picker.
        public var cornerRadius: CGFloat = 7
        
        /// Selection indicator corner radius.  Defaults to `6`, similarly to native picker.
        public var indicatorCornerRadius: CGFloat = 6
        
        /// Selection indicator margin. Defaults to `2`.
        public var indicatorMargin: CGFloat = 2
        
        /// Scale by which selection indicator changes on press. Defaults to `0.95`.
        public var indicatorPressedScale: CGFloat = 0.95
        
        /// Indicator shadow radius. Defaults to `1`.
        public var indicatorShadowRadius: CGFloat = 1
        
        /// Indicator shadow X offset. Defaults to `0`.
        public var indicatorShadowOffsetX: CGFloat = 0
        
        /// Indicator shadow Y offset. Defaults to `1`.
        public var indicatorShadowOffsetY: CGFloat = 1
        
        /// Row content margin. Defaults to `2`.
        public var contentMargin: CGFloat = 2
        
        /// Header title line type. Defaults to `singleline`.
        public var headerTitleLineType: TextLineType = .singleLine
        
        /// Footer title line type. Defaults to `multiline` of `1...5` lines.
        public var footerTitleLineType: TextLineType = .multiLine(alignment: .leading, lineLimit: 1...5)
        
        /// Spacing between header, picker, and footer. Defaults to `3`.
        public var headerPickerFooterSpacing: CGFloat = 3
        
        /// Header and footer horizontal margin. Defaults to `10`.
        public var headerFooterMarginHorizontal: CGFloat = 10
        
        /// Title minimum scale factor. Defaults to `0.75`.
        public var titleMinimumScaleFactor: CGFloat = 0.75
        
        /// Row divider size. Defaults to width `1` and height `19`, similarly to native picker.
        public var dividerSize: CGSize = .init(width: 1, height: 19)
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }

    // MARK: Colors
    /// Model that contains color properties.
    public struct Colors {
        // MARK: Properties
        /// Background colors.
        public var background: StateColors = .init(
            enabled: .init(componentAsset: "color_240.240.240_40.40.40"),
            disabled: toggleReference.colors.fill.disabled
        )
        
        /// Selection indicator colors.
        public var indicator: StateColors = .init(
            enabled: .init(componentAsset: "color_254.254.254_90.90.90"),
            disabled: .init(componentAsset: "color_254.254.254_60.60.60")
        )
        
        /// Selection indicator shadow colors.
        public var indicatorShadow: StateColors = .init(
            enabled: sliderReference.colors.thumbShadow.enabled,
            disabled: sliderReference.colors.thumbShadow.disabled
        )
        
        /// Title colors.
        ///
        /// Only applicable when using `init` with title.
        public var title: RowStateColors = .init(
            enabled: ColorBook.primary,
            pressed: ColorBook.primaryPressedDisabled,
            disabled: ColorBook.primaryPressedDisabled
        )
        
        /// Custom content opacities.
        ///
        /// Applicable only when `init` with content is used.
        /// When using a custom content, it's subviews cannot be configured with individual colors,
        /// so instead, a general opacity is being applied.
        public var customContentOpacities: RowStateOpacities = .init(
            enabled: 1,
            pressed: 0.3,
            disabled: 0.3
        )
        
        /// Row divider colors.
        public var divider: StateColors = .init(
            enabled: .init(componentAsset: "color_215.215.215_70.70.70"),
            disabled: .init(componentAsset: "color_230.230.230_50.50.50")
        )
        
        /// Header colors.
        public var header: StateColors = .init(
            enabled: ColorBook.secondary,
            disabled: ColorBook.secondaryPressedDisabled
        )
        
        /// Footer colors.
        public var footer: StateColors = .init(
            enabled: ColorBook.secondary,
            disabled: ColorBook.secondaryPressedDisabled
        )
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
        
        // MARK: State Colors
        /// Model that contains colors for component states.
        public typealias StateColors = GenericStateModel_EnabledDisabled<Color>
        
        /// Model that contains colors for component states.
        public typealias RowStateColors = GenericStateModel_EnabledPressedDisabled<Color>
        
        // MARK: State Opacities
        /// Model that contains opacities for component states.
        public typealias RowStateOpacities = GenericStateModel_EnabledPressedDisabled<CGFloat>
    }

    // MARK: Fonts
    /// Model that contains font properties.
    public struct Fonts {
        // MARK: Properties
        /// Header font. Defaults to system font of size `14`.
        public var header: Font = .system(size: 14)
        
        /// Footer font. Defaults to system font of size `13`.
        public var footer: Font = .system(size: 13)
        
        /// Row font. Defaults to system font of size `14` with `medium` weight.
        ///
        /// Only applicable when using `init` with title.
        public var rows: Font = .system(size: 14, weight: .medium)
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }

    // MARK: Animations
    /// Model that contains animation properties.
    public struct Animations {
        // MARK: Properties
        /// State change animation. Defaults to `easeInOut` with duration `0.2`.
        public var selection: Animation? = .easeInOut(duration: 0.2)
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
}
