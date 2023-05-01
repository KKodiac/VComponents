//
//  VAlertButton.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 12/26/20.
//

import SwiftUI

// MARK: - V Alert Button
/// `VAlert` button.
///
///     @State private var isPresented: Bool = false
///
///     var body: some View {
///         VPlainButton(
///             action: { isPresented = true },
///             title: "Present"
///         )
///         .vAlert(
///             id: "some_alert",
///             isPresented: $isPresented,
///             title: "Lorem Ipsum",
///             message: "Lorem ipsum dolor sit amet",
///             actions: {
///                 VAlertButton(role: .primary, action: { print("Confirmed") }, title: "Confirm")
///                 VAlertButton(role: .cancel, action: { print("Cancelled") }, title: "Cancel")
///             }
///         )
///     }
///
@available(iOS 14.0, *)
@available(macOS, unavailable)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
public struct VAlertButton {
    // MARK: Properties
    private var isEnabled: Bool = true
    /*private*/ let role: Role
    private let action: (() -> Void)?
    private let title: String

    // MARK: Initializers
    /// Initializes `VAlertButton` with action and title.
    public init(
        role: Role,
        action: (() -> Void)?,
        title: String
    ) {
        self.role = role
        self.action = action
        self.title = title
    }

    // MARK: Role
    /// Model that describes the purpose of a button.
    public enum Role {
        /// Primary button role.
        case primary

        /// Secondary button role.
        case secondary

        /// Destructive button role.
        case destructive

        /// Cancel button role.
        case cancel
    }

    // MARK: Body
    func makeBody(
        uiModel: VAlertUIModel,
        animateOut: @escaping (/*completion*/ (() -> Void)?) -> Void
    ) -> AnyView {
        .init(
            VStretchedButton(
                uiModel: {
                    switch role {
                    case .primary: return uiModel.primaryButtonSubUIModel
                    case .secondary: return uiModel.secondaryButtonSubUIModel
                    case .destructive: return uiModel.destructiveButtonSubUIModel
                    case .cancel: return uiModel.secondaryButtonSubUIModel
                    }
                }(),
                action: { animateOut(/*completion: */action) },
                title: title
            )
            .disabled(!isEnabled)
        )
    }

    // MARK: Modifiers
    /// Adds a condition that controls whether users can interact with the button.
    public func disabled(_ disabled: Bool) -> Self {
        var button = self
        button.isEnabled = !disabled
        return button
    }
}
