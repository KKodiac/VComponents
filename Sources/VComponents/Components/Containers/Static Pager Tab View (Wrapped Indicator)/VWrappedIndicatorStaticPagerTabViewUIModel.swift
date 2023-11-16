//
//  VWrappedIndicatorStaticPagerTabViewUIModel.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 01.09.23.
//

import SwiftUI
import VCore

// MARK: - V Wrapped-Indicator Static Pager Tab View UI Model
/// Model that describes UI.
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct VWrappedIndicatorStaticPagerTabViewUIModel {
    // MARK: Properties - Global
    /// Spacing between tab bar and tab view. Set to `0`.
    public var tabBarAndTabViewSpacing: CGFloat = GlobalUIModel.Containers.pagerTabViewTabBarAndTabViewSpacing

    // MARK: Properties - Header
    /// Header background color.
    public var headerBackgroundColor: Color = GlobalUIModel.Containers.pagerTabViewBackgroundColor

    // MARK: Properties - Tab Bar
    /// Tab bar alignment for tab items. Set to `top`.
    public var tabBarAlignment: VerticalAlignment = GlobalUIModel.Containers.pagerTabViewTabBarAlignment

    // MARK: Properties - Tab Bar - Tab Item
    /// Tab bar margins. Set to `10`s.
    public var tabItemMargins: VerticalMargins = .init(GlobalUIModel.Containers.pagerTabViewTabItemMargin)

    // MARK: Properties - Tab Bar - Tab Item - Text
    /// Tab item text minimum scale factor. Set to `0.75`.
    public var tabItemTextMinimumScaleFactor: CGFloat = GlobalUIModel.Common.minimumScaleFactor

    /// Tab item text colors.
    public var tabItemTextColors: TabItemStateColors = .init(
        deselected: GlobalUIModel.Containers.pagerTabViewTabItemTextColorDeselected,
        selected: GlobalUIModel.Containers.pagerTabViewTabItemTextColorDeSelected,
        pressedDeselected: GlobalUIModel.Containers.pagerTabViewTabItemTextColorPressedDeselected,
        pressedSelected: GlobalUIModel.Containers.pagerTabViewTabItemTextColorPressedSelected,
        disabled: GlobalUIModel.Containers.pagerTabViewTabItemTextColorDisabled
    )

    /// Tab item text font. Set to `body` (`17`).
    public var tabItemTextFont: Font = GlobalUIModel.Containers.pagerTabViewTabItemTextFont

    // MARK: Properties - Tab Indicator Strip
    /// Tab indicator strip alignment. Set to `bottom`.
    public var tabIndicatorStripAlignment: VerticalAlignment = GlobalUIModel.Containers.pagerTabViewTabIndicatorStripAlignment

    // MARK: Properties - Tab Indicator Strip - Track
    /// Tab indicator track height. Set to `2`.
    public var tabIndicatorTrackHeight: CGFloat = GlobalUIModel.Containers.pagerTabViewTabIndicatorTrackHeight

    /// Tab indicator track color.
    public var tabIndicatorTrackColor: Color = GlobalUIModel.Containers.pagerTabViewTabIndicatorTrackColor

    // MARK: Properties - Tab Indicator Strip - Indicator
    /// Selected tab indicator height. Set to `2`.
    public var selectedTabIndicatorHeight: CGFloat = GlobalUIModel.Containers.pagerTabViewSelectedTabIndicatorHeight

    /// Selected tab indicator corner radius. Set to `0`.
    public var selectedTabIndicatorCornerRadius: CGFloat = GlobalUIModel.Containers.pagerTabViewSelectedTabIndicatorCornerRadius

    /// Selected tab indicator color.
    public var selectedTabIndicatorColor: Color = GlobalUIModel.Containers.pagerTabViewSelectedTabIndicatorColor

    /// Selected tab indicator animation. Set to `default`.
    public var selectedTabIndicatorAnimation: Animation? = GlobalUIModel.Containers.pagerTabViewSelectedTabIndicatorAnimation

    // MARK: Properties - Tab View
    /// Tab view background color.
    public var tabViewBackgroundColor: Color = GlobalUIModel.Containers.pagerTabViewBackgroundColor

    // MARK: Initializers
    /// Initializes UI model with default values.
    public init() {}

    // MARK: Vertical Margins
    /// Model that contains `top` and `bottom` margins.
    public typealias VerticalMargins = EdgeInsets_TopBottom

    // MARK: Tab Item State Colors
    /// Model that contains colors for component states.
    public typealias TabItemStateColors = GenericStateModel_DeselectedSelectedPressedDisabled<Color>
}
