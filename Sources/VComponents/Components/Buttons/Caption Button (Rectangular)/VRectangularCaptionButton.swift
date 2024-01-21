//
//  VRectangularCaptionButton.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 17.08.22.
//

import SwiftUI
import VCore

// MARK: - V Rectangular Caption Button
/// Rectangular captioned button component that performs action when triggered.
///
///     var body: some View {
///         VRectangularCaptionButton(
///             action: { print("Clicked") },
///             icon: Image(systemName: "swift"),
///             titleCaption: "Lorem Ipsum"
///         )
///     }
///
@available(macOS, unavailable) // Doesn't follow Human Interface Guidelines
@available(tvOS, unavailable) // Doesn't follow Human Interface Guidelines
public struct VRectangularCaptionButton<CaptionLabel>: View where CaptionLabel: View {
    // MARK: Properties
    private let uiModel: VRectangularCaptionButtonUIModel
    
    private func internalState(_ baseButtonState: SwiftUIBaseButtonState) -> VRectangularCaptionButtonInternalState {
        baseButtonState
    }
    
    private let action: () -> Void
    
    private let icon: Image

    private let caption: VRectangularCaptionButtonCaption<CaptionLabel>
    
    // MARK: Initializers
    /// Initializes `VRectangularCaptionButton` with action, icon, and title caption.
    public init(
        uiModel: VRectangularCaptionButtonUIModel = .init(),
        action: @escaping () -> Void,
        icon: Image,
        titleCaption: String
    )
        where CaptionLabel == Never
    {
        self.uiModel = uiModel
        self.action = action
        self.icon = icon
        self.caption = .title(title: titleCaption)
    }

    /// Initializes `VRectangularCaptionButton` with action, icon, and icon caption.
    public init(
        uiModel: VRectangularCaptionButtonUIModel = .init(),
        action: @escaping () -> Void,
        icon: Image,
        iconCaption: Image
    )
        where CaptionLabel == Never
    {
        self.uiModel = uiModel
        self.action = action
        self.icon = icon
        self.caption = .icon(icon: iconCaption)
    }

    /// Initializes `VRectangularCaptionButton` with action, icon, icon caption, and title caption.
    public init(
        uiModel: VRectangularCaptionButtonUIModel = .init(),
        action: @escaping () -> Void,
        icon: Image,
        titleCaption: String,
        iconCaption: Image
    )
        where CaptionLabel == Never
    {
        self.uiModel = uiModel
        self.action = action
        self.icon = icon
        self.caption = .titleAndIcon(title: titleCaption, icon: iconCaption)
    }
    
    /// Initializes `VRectangularCaptionButton` with action, icon, and caption.
    public init(
        uiModel: VRectangularCaptionButtonUIModel = .init(),
        action: @escaping () -> Void,
        icon: Image,
        @ViewBuilder caption: @escaping (VRectangularCaptionButtonInternalState) -> CaptionLabel
    ) {
        self.uiModel = uiModel
        self.action = action
        self.icon = icon
        self.caption = .caption(caption: caption)
    }
    
    // MARK: Body
    public var body: some View {
        SwiftUIBaseButton(
            uiModel: uiModel.baseButtonSubUIModel,
            action: {
                playHapticEffect()
                action()
            },
            label: { baseButtonState in
                let internalState: VRectangularCaptionButtonInternalState = internalState(baseButtonState)
                
                VStack(spacing: uiModel.rectangleAndCaptionSpacing, content: {
                    rectangle(internalState: internalState)
                    buttonCaption(internalState: internalState)
                })
                .contentShape(Rectangle()) // Registers gestures even when clear
            }
        )
    }
    
    private func rectangle(
        internalState: VRectangularCaptionButtonInternalState
    ) -> some View {
        Group(content: { // `Group` is used for adding multiple frames
            icon
                .resizable()
                .scaledToFit()
                .frame(size: uiModel.iconSize)
                .scaleEffect(internalState == .pressed ? uiModel.iconPressedScale : 1)
                .padding(uiModel.iconMargins)
                .foregroundStyle(uiModel.iconColors.value(for: internalState))
                .opacity(uiModel.iconOpacities.value(for: internalState))
        })
        .frame(size: uiModel.rectangleSize)
        .clipShape(.rect(cornerRadius: uiModel.rectangleCornerRadius)) // Prevents large content from overflowing
        .background(content: { rectangleBackground(internalState: internalState) }) // Has own rounding
        .overlay(content: { rectangleBorder(internalState: internalState) }) // Has own rounding
    }
    
    private func rectangleBackground(
        internalState: VRectangularCaptionButtonInternalState
    ) -> some View {
        RoundedRectangle(cornerRadius: uiModel.rectangleCornerRadius)
            .scaleEffect(internalState == .pressed ? uiModel.rectanglePressedScale : 1)
            .foregroundStyle(uiModel.rectangleColors.value(for: internalState))
            .shadow(
                color: uiModel.shadowColors.value(for: internalState),
                radius: uiModel.shadowRadius,
                offset: uiModel.shadowOffset
            )
    }
    
    @ViewBuilder private func rectangleBorder(
        internalState: VRectangularCaptionButtonInternalState
    ) -> some View {
        if uiModel.rectangleBorderWidth > 0 {
            RoundedRectangle(cornerRadius: uiModel.rectangleCornerRadius)
                .strokeBorder(uiModel.rectangleBorderColors.value(for: internalState), lineWidth: uiModel.rectangleBorderWidth)
                .scaleEffect(internalState == .pressed ? uiModel.rectanglePressedScale : 1)
        }
    }
    
    private func buttonCaption(
        internalState: VRectangularCaptionButtonInternalState
    ) -> some View {
        Group(content: {
            switch caption {
            case .title(let title):
                titleCaptionComponent(internalState: internalState, title: title)

            case .icon(let icon):
                iconCaptionComponent(internalState: internalState, icon: icon)

            case .titleAndIcon(let title, let icon):
                switch uiModel.titleCaptionTextAndIconCaptionPlacement {
                case .titleAndIcon:
                    HStack(spacing: uiModel.titleCaptionTextAndIconCaptionSpacing, content: {
                        titleCaptionComponent(internalState: internalState, title: title)
                        iconCaptionComponent(internalState: internalState, icon: icon)
                    })

                case .iconAndTitle:
                    HStack(spacing: uiModel.titleCaptionTextAndIconCaptionSpacing, content: {
                        iconCaptionComponent(internalState: internalState, icon: icon)
                        titleCaptionComponent(internalState: internalState, title: title)
                    })
                }

            case .caption(let caption):
                caption(internalState)
            }
        })
        .frame(
            maxWidth: uiModel.captionWidthMax,
            alignment: Alignment(
                horizontal: uiModel.captionFrameAlignment,
                vertical: .center
            )
        )
        .scaleEffect(internalState == .pressed ? uiModel.captionPressedScale : 1)
    }
    
    private func titleCaptionComponent(
        internalState: VRectangularCaptionButtonInternalState,
        title: String
    ) -> some View {
        Text(title)
            .multilineTextAlignment(uiModel.titleCaptionTextLineType.textAlignment ?? .leading)
            .lineLimit(type: uiModel.titleCaptionTextLineType.textLineLimitType)
            .minimumScaleFactor(uiModel.titleCaptionTextMinimumScaleFactor)
            .foregroundStyle(uiModel.titleCaptionTextColors.value(for: internalState))
            .font(uiModel.titleCaptionTextFont)
    }
    
    private func iconCaptionComponent(
        internalState: VRectangularCaptionButtonInternalState,
        icon: Image
    ) -> some View {
        icon
            .resizable()
            .scaledToFit()
            .frame(size: uiModel.iconCaptionSize)
            .foregroundStyle(uiModel.iconCaptionColors.value(for: internalState))
            .opacity(uiModel.iconCaptionOpacities.value(for: internalState))
    }
    
    // MARK: Haptics
    private func playHapticEffect() {
#if os(iOS)
        HapticManager.shared.playImpact(uiModel.haptic)
#elseif os(watchOS)
        HapticManager.shared.playImpact(uiModel.haptic)
#endif
    }
}

// MARK: - Preview
#if DEBUG

#if !(os(macOS) || os(tvOS))

#Preview("*", body: {
    PreviewContainer(content: {
        VRectangularCaptionButton(
            action: {},
            icon: Image(systemName: "swift"),
            titleCaption: "Lorem Ipsum"
        )
    })
})

#Preview("States", body: {
    PreviewContainer(content: {
        PreviewRow("Enabled", content: {
            VRectangularCaptionButton(
                action: {},
                icon: Image(systemName: "swift"),
                titleCaption: "Lorem Ipsum"
            )
        })

        PreviewRow("Pressed", content: {
            VRectangularCaptionButton(
                uiModel: {
                    var uiModel: VRectangularCaptionButtonUIModel = .init()
                    uiModel.rectangleColors.enabled = uiModel.rectangleColors.pressed
                    uiModel.iconColors.enabled = uiModel.iconColors.pressed
                    uiModel.titleCaptionTextColors.enabled = uiModel.titleCaptionTextColors.pressed
                    return uiModel
                }(),
                action: {},
                icon: Image(systemName: "swift"),
                titleCaption: "Lorem Ipsum"
            )
        })

        PreviewRow("Disabled", content: {
            VRectangularCaptionButton(
                action: {},
                icon: Image(systemName: "swift"),
                titleCaption: "Lorem Ipsum"
            )
            .disabled(true)
        })
    })
})

#endif

#endif
