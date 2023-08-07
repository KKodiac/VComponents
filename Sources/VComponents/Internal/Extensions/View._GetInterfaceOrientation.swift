//
//  View._GetInterfaceOrientation.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 06.08.23.
//

import SwiftUI
import VCore

// MARK: - View Get Interface Orientation
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
extension View {
    func _getInterfaceOrientation(
        _ action: @escaping (_InterfaceOrientation) -> Void
    ) -> some View {
#if os(iOS) || targetEnvironment(macCatalyst)
        self
            .getInterfaceOrientation({ action(_InterfaceOrientation(uiIInterfaceOrientation: $0)) })
#else
        fatalError() // Not supported
#endif
    }
}
