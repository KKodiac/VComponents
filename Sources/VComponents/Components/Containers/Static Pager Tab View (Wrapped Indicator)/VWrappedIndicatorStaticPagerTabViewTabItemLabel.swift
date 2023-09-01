//
//  VWrappedIndicatorStaticPagerTabViewTabItemLabel.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 01.09.23.
//

import SwiftUI

// MARK: - V Static Pager Tab View Tab Item Label (Wrapped Indicator)
@available(iOS 14.0, *)
@available(macOS 11.0, *)@available(macOS, unavailable)
@available(tvOS 14.0, *)@available(tvOS, unavailable)
@available(watchOS 8.0, *)@available(watchOS, unavailable)
enum VWrappedIndicatorStaticPagerTabViewTabItemLabel<Element, Content>
    where
        Element: Hashable,
        Content: View
{
    case title(title: (Element) -> String)
    case label(label: (VWrappedIndicatorStaticPagerTabViewTabItemInternalState, Element) -> Content)
}
