//
//  VPlainButtonUIModel.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 19.12.20.
//

import SwiftUI
import VCore

// MARK: - V Plain Button UI Model
/// Model that describes UI.
public struct VPlainButtonUIModel {
    // MARK: Properties
    fileprivate static let primaryButtonReference: VPrimaryButtonUIModel = .init()
    fileprivate static let secondaryButtonReference: VSecondaryButtonUIModel = .init()
    fileprivate static let roundedButtonReference: VRoundedButtonUIModel = .init()
    
    /// Model that contains layout properties.
    public var layout: Layout = .init()
    
    /// Model that contains color properties.
    public var colors: Colors = .init()
    
    /// Model that contains font properties.
    public var fonts: Fonts = .init()
    
    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Layout
    /// Model that contains layout properties.
    public struct Layout {
        // MARK: Properties
        /// Icon size. Defaults to `20` by `20`.
        public var iconSize: CGSize = roundedButtonReference.layout.iconSize
        
        /// Title minimum scale factor. Defaults to `0.75`.
        public var titleMinimumScaleFactor: CGFloat = primaryButtonReference.layout.titleMinimumScaleFactor
        
        /// Spacing between icon and title. Defaults to `8`.
        ///
        /// Applicable only if icon `init` with icon and title is used.
        public var iconTitleSpacing: CGFloat = secondaryButtonReference.layout.iconTitleSpacing
        
        /// Hit box. Defaults to `5`s.
        public var hitBox: HitBox = .init(5)
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
        
        // MARK: Hit Box
        /// Model that contains `horizontal` and `vertical` hit boxes.
        public typealias HitBox = EdgeInsets_HorizontalVertical
    }

    // MARK: Colors
    /// Model that contains color properties.
    public struct Colors {
        // MARK: Properties
        /// Title colors.
        public var title: StateColors = .init(
            enabled: ColorBook.accent,
            pressed: ColorBook.accentPressedDisabled,
            disabled: ColorBook.accentPressedDisabled
        )
        
        /// Icon colors.
        ///
        /// Applied to all images. But should be used for vector images.
        /// In order to use bitmap images, set this to `clear`.
        public var icon: StateColors = .init(
            enabled: ColorBook.accent,
            pressed: ColorBook.accentPressedDisabled,
            disabled: ColorBook.accentPressedDisabled
        )
        
        /// Icon opacities. Defaults to `1`s.
        ///
        /// Applied to all images. But should be used for bitmap images.
        /// In order to use vector images, set this to `1`s.
        public var iconOpacities: StateOpacities = .init(primaryButtonReference.colors.iconOpacities)
        
        /// Custom label opacities.
        ///
        /// Applicable only when `init` with label is used.
        /// When using a custom label, it's subviews cannot be configured with individual colors,
        /// so instead, a general opacity is being applied.
        public var customLabelOpacities: StateOpacities = .init(primaryButtonReference.colors.customLabelOpacities)
        
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
        /// Title font. Defaults to system font of size `15` with `medium` weight.
        ///
        /// Only applicable when using `init` with title.
        public var title: Font = .system(size: 15, weight: .medium)
        
        // MARK: Initializers
        /// Initializes UI model with default values.
        public init() {}
    }
}
