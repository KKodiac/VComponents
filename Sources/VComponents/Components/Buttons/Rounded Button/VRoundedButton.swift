//
//  VRoundedButton.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 19.12.20.
//

import SwiftUI
import VCore

// MARK: - V Rounded Button
/// Rounded colored button component that performs action when triggered.
///
/// Component can be initialized with title, icon, and label.
///
/// UI Model can be passed as parameter.
///
///     var body: some View {
///         VRoundedButton(
///             action: { print("Clicked") },
///             icon: Image(systemName: "swift")
///         )
///     }
///
@available(tvOS, unavailable) // Doesn't follow Human Interface Guidelines
@available(watchOS, unavailable) // Doesn't follow Human Interface Guidelines
public struct VRoundedButton<Label>: View where Label: View {
    // MARK: Properties
    private let uiModel: VRoundedButtonUIModel
    private func internalState(_ baseButtonState: SwiftUIBaseButtonState) -> VRoundedButtonInternalState { baseButtonState }
    private let action: () -> Void
    private let label: VRoundedButtonLabel<Label>
    
    private var hasBorder: Bool { uiModel.layout.borderWidth > 0 }

    // MARK: Initializers
    /// Initializes `VRoundedButton` with action and title.
    public init(
        uiModel: VRoundedButtonUIModel = .init(),
        action: @escaping () -> Void,
        title: String
    )
        where Label == Never
    {
        self.uiModel = uiModel
        self.action = action
        self.label = .title(title: title)
    }
    
    /// Initializes `VRoundedButton` with action and icon.
    public init(
        uiModel: VRoundedButtonUIModel = .init(),
        action: @escaping () -> Void,
        icon: Image
    )
        where Label == Never
    {
        self.uiModel = uiModel
        self.action = action
        self.label = .icon(icon: icon)
    }
    
    /// Initializes `VRoundedButton` with action and label.
    public init(
        uiModel: VRoundedButtonUIModel = .init(),
        action: @escaping () -> Void,
        @ViewBuilder label: @escaping (VRoundedButtonInternalState) -> Label
    ) {
        self.uiModel = uiModel
        self.action = action
        self.label = .label(label: label)
    }

    // MARK: Body
    public var body: some View {
        SwiftUIBaseButton(
            uiModel: uiModel.baseButtonSubUIModel,
            action: action,
            label: { baseButtonState in
                let internalState: VRoundedButtonInternalState = internalState(baseButtonState)
                
                buttonLabel(internalState: internalState)
                    .frame(dimension: uiModel.layout.dimension)
                    .background(background(internalState: internalState))
                    .overlay(border(internalState: internalState))
                    .padding(uiModel.layout.hitBox)
            }
        )
    }
    
    private func buttonLabel(
        internalState: VRoundedButtonInternalState
    ) -> some View {
        Group(content: {
            switch label {
            case .title(let title):
                titleLabelComponent(internalState: internalState, title: title)
                
            case .icon(let icon):
                iconLabelComponent(internalState: internalState, icon: icon)
                
            case .label(let label):
                label(internalState)
            }
        })
            .padding(uiModel.layout.labelMargins)
    }
    
    private func titleLabelComponent(
        internalState: VRoundedButtonInternalState,
        title: String
    ) -> some View {
        VText(
            minimumScaleFactor: uiModel.layout.titleMinimumScaleFactor,
            color: uiModel.colors.title.value(for: internalState),
            font: uiModel.fonts.title,
            text: title
        )
    }
    
    private func iconLabelComponent(
        internalState: VRoundedButtonInternalState,
        icon: Image
    ) -> some View {
        icon
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(size: uiModel.layout.iconSize)
            .foregroundColor(uiModel.colors.icon.value(for: internalState))
            .opacity(uiModel.colors.iconOpacities.value(for: internalState))
    }

    private func background(
        internalState: VRoundedButtonInternalState
    ) -> some View {
        RoundedRectangle(cornerRadius: uiModel.layout.cornerRadius)
            .foregroundColor(uiModel.colors.background.value(for: internalState))
    }
    
    @ViewBuilder private func border(
        internalState: VRoundedButtonInternalState
    ) -> some View {
        if hasBorder {
            RoundedRectangle(cornerRadius: uiModel.layout.cornerRadius)
                .strokeBorder(uiModel.colors.border.value(for: internalState), lineWidth: uiModel.layout.borderWidth)
        }
    }
}

// MARK: - Preview
@available(macOS 11.0, *)
@available(tvOS, unavailable)
@available(watchOS, unavailable)
struct VRoundedButton_Previews: PreviewProvider {
    // Configuration
    private static var colorScheme: ColorScheme { .light }
    
    // Previews
    static var previews: some View {
        Group(content: {
            Preview().previewDisplayName("*")
            StatesPreview().previewDisplayName("States")
        })
            .colorScheme(colorScheme)
    }
    
    // Data
    private static var icon: Image { .init(systemName: "swift") }
    
    // Previews (Scenes)
    private struct Preview: View {
        var body: some View {
            PreviewContainer(content: {
                VRoundedButton(
                    action: { print("Clicked") },
                    icon: icon
                )
            })
        }
    }
    
    private struct StatesPreview: View {
        var body: some View {
            PreviewContainer(content: {
                PreviewRow(
                    axis: .horizontal,
                    title: "Enabled",
                    content: {
                        VRoundedButton(
                            action: {},
                            icon: icon
                        )
                    }
                )
                
                PreviewRow(
                    axis: .horizontal,
                    title: "Pressed",
                    content: {
                        VRoundedButton(
                            uiModel: {
                                var uiModel: VRoundedButtonUIModel = .init()
                                uiModel.colors.background.enabled = uiModel.colors.background.pressed
                                uiModel.colors.icon.enabled = uiModel.colors.icon.pressed
                                return uiModel
                            }(),
                            action: {},
                            icon: icon
                        )
                    }
                )
                
                PreviewRow(
                    axis: .horizontal,
                    title: "Disabled",
                    content: {
                        VRoundedButton(
                            action: {},
                            icon: icon
                        )
                            .disabled(true)
                    }
                )
            })
        }
    }
}
