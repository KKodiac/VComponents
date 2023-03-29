//
//  VRoundedLabeledButtonUIModel.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 17.08.22.
//

import SwiftUI
import VCore

// MARK: - V Rounded Labeled Button UI Model
/// Model that describes UI.
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct VRoundedLabeledButtonUIModel {
    // MARK: Properties
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
        /// Rectangle dimension. Set to `56`.
        public var roundedRectangleDimension: CGFloat = GlobalUIModel.Buttons.dimensionIOSLarge
        
        /// Rectangle corner radius. Set to `24`.
        public var cornerRadius: CGFloat = GlobalUIModel.Buttons.cornerRadiusIOSLarge
        
        /// Rectangle border width. Set to `0`.
        ///
        /// To hide border, set to `0`.
        public var borderWidth: CGFloat = 0
        
        /// Icon margins. Set to `3`s.
        public var iconMargins: LabelMargins = GlobalUIModel.Buttons.labelMarginsRounded
        
        /// Icon size. Set to `24x24`.
        public var iconSize: CGSize = .init(dimension: GlobalUIModel.Buttons.iconDimensionLarge)
        
        /// Spacing between rounded rectangle and label. Set to `4`.
        public var rectangleLabelSpacing: CGFloat = 4
        
        /// Maximum label width. Set to `100`.
        public var labelWidthMax: CGFloat = 100
        
        /// Spacing between icon label and icon title. Set to `8`.
        public var labelSpacing: CGFloat = GlobalUIModel.Buttons.iconTitleSpacing
        
        /// Icon label size. Set to `18x18`.
        public var iconLabelSize: CGSize = .init(dimension: 18)
        
        /// Title label text line type. Set to `multiline` with `center` alignment and `1...2` lines.
        public var titleLabelTextLineType: TextLineType = {
            if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
                return .multiLine(alignment: .center, lineLimit: 1...2)
            } else {
                return .multiLine(alignment: .center, lineLimit: 2)
            }
        }()
        
        /// Title label minimum scale factor. Set to `0.75`.
        public var titleLabelMinimumScaleFactor: CGFloat = GlobalUIModel.Common.minimumScaleFactor
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
        
        // MARK: Label Margins
        /// Model that contains `horizontal` and `vertical` margins.
        public typealias LabelMargins = EdgeInsets_HorizontalVertical
        
        // MARK: Hit Box
        /// Model that contains `horizontal` and `vertical` hit boxes.
        public typealias HitBox = EdgeInsets_HorizontalVertical
    }

    // MARK: Colors
    /// Model that contains color properties.
    public struct Colors {
        // MARK: Properties
        /// Background colors.
        public var background: StateColors = .init(
            enabled: ColorBook.controlLayerBlueTransparent,
            pressed: ColorBook.controlLayerBlueTransparentPressed,
            disabled: ColorBook.controlLayerBlueTransparentDisabled
        )
        
        /// Border colors.
        public var border: StateColors = .clearColors
        
        /// Icon colors.
        ///
        /// Applied to all images. But should be used for vector images.
        /// In order to use bitmap images, set this to `clear`.
        public var icon: StateColors = .init(
            enabled: GlobalUIModel.Buttons.transparentLayerLabelEnabled,
            pressed: GlobalUIModel.Buttons.transparentLayerLabelPressed,
            disabled: GlobalUIModel.Buttons.transparentLayerLabelDisabled
        )
        
        /// Icon opacities. Set to `1`s.
        ///
        /// Applied to all images. But should be used for bitmap images.
        /// In order to use vector images, set this to `1`s.
        public var iconOpacities: StateOpacities = .init(1)
        
        /// Title label colors.
        public var titleLabel: StateColors = .init(
            enabled: ColorBook.primary,
            pressed: ColorBook.primaryPressedDisabled,
            disabled: ColorBook.primaryPressedDisabled
        )
        
        /// Icon label colors.
        ///
        /// Applied to all images. But should be used for vector images.
        /// In order to use bitmap images, set this to `clear`.
        public var iconLabel: StateColors = .init(
            enabled: ColorBook.primary,
            pressed: ColorBook.primaryPressedDisabled,
            disabled: ColorBook.primaryPressedDisabled
        )
        
        /// Icon label opacities. Set to `1`s.
        ///
        /// Applied to all images. But should be used for bitmap images.
        /// In order to use vector images, set this to `1`s.
        public var iconLabelOpacities: StateOpacities = .init(1)
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
        
        // MARK: State Colors
        /// Model that contains colors for component states.
        public typealias StateColors = GenericStateModel_EnabledPressedDisabled<Color>
        
        // MARK: State Opacities
        /// Model that contains opacities for component states.
        public typealias StateOpacities = GenericStateModel_EnabledPressedDisabled<CGFloat>
    }

    // MARK: Fonts
    /// Model that contains font properties.
    public struct Fonts {
        // MARK: Properties
        /// Title font. Set to `system` `15`.
        public var titleLabel: Font = .system(size: 15)
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
    
    // MARK: Animations
    /// Model that contains animation properties.
    public struct Animations {
        // MARK: Properties
        /// Indicates if button animates state change. Defaults to `true`.
        public var animatesStateChange: Bool = true
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
    
    // MARK: Sub UI Models
    var baseButtonSubUIModel: SwiftUIBaseButtonUIModel {
        var uiModel: SwiftUIBaseButtonUIModel = .init()
        
        uiModel.animations.animatesStateChange = animations.animatesStateChange
        
        return uiModel
    }
}
