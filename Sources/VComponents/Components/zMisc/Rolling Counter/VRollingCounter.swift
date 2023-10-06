//
//  VRollingCounter.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 25.08.23.
//

import SwiftUI
import VCore

// MARK: - V Rolling Counter
/// Text component that highlights change in a floating-absolute number.
///
///     @State private var value: Double = 10_000
///
///     var body: some View {
///         ZStack(content: {
///             VRollingCounter(value: value)
///         })
///         .onAppear(perform: changeValue)
///     }
///
///     private func changeValue() {
///         DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
///             value += .random(in: -10...10)
///             changeValue()
///         })
///     }
///
/// Integer types can be represented by hiding fraction digits.
///
///     @State private var value: Int = 10_000
///
///     var body: some View {
///         ZStack(content: {
///             VRollingCounter(
///                 uiModel: {
///                     var uiModel: VRollingCounterUIModel = .init()
///                     uiModel.hasFractionDigits = false
///                     return uiModel
///                 }(),
///                 value: Double(value)
///             )
///         })
///         .onAppear(perform: ...)
///     }
///        
public struct VRollingCounter: View {
    // MARK: Properties
    private let uiModel: VRollingCounterUIModel

    private let value: Double
    @State private var components: [any VRollingCounterComponentProtocol]

    @State private var numberFormatter: NumberFormatter // Marked as `State` to persist a `class`
    @State private var highlightedColor: Color?

    // MARK: Initializers
    /// Initializes `VRollingCounter` with value.
    public init<V>(
        uiModel: VRollingCounterUIModel = .init(),
        value: V
    )
        where V: BinaryFloatingPoint
    {
        let value: Double = .init(value)

        let numberFormatter: NumberFormatter = VRollingCounterFactory.numberFormatter(
            uiModel: uiModel
        )

        self.uiModel = uiModel
        self.value = value
        self._components = State(initialValue: VRollingCounterFactory.components(
            value: value,
            uiModel: uiModel,
            numberFormatter: numberFormatter
        ))
        self._numberFormatter = State(initialValue: numberFormatter)
    }

    // MARK: Body
    public var body: some View {
        HStack(
            alignment: uiModel.verticalAlignment,
            spacing: uiModel.spacing,
            content: {
                ForEach(
                    components,
                    id: \.id,
                    content: digitView
                )
            }
        )
        .clipped() // Prevents animation clipping
        .onChange(of: value, perform: didChangeValue)
    }

    @ViewBuilder private func digitView(
        _ component: any VRollingCounterComponentProtocol
    ) -> some View {
        switch component {
        case let digit as VRollingCounterDigitComponent:
            Text(digit.stringRepresentation)
                .foregroundStyle(textColor(digit.isHighlighted, defaultValue: uiModel.digitTextColor))
                .font(uiModel.digitTextFont)
                .padding(uiModel.digitTextMargins)
                .offset(y: uiModel.digitTextOffsetY)
                .transition(.rollingEdge(edge: (uiModel.digitTextRollEdge).map { Edge(verticalEdge: $0) }) ?? .identity)

        case let fractionDigit as VRollingCounterFractionDigitComponent:
            Text(fractionDigit.stringRepresentation)
                .foregroundStyle(textColor(fractionDigit.isHighlighted, defaultValue: uiModel.fractionDigitTextColor))
                .font(uiModel.fractionDigitTextFont)
                .padding(uiModel.fractionDigitTextMargins)
                .offset(y: uiModel.fractionDigitTextOffsetY)
                .transition(.rollingEdge(edge: (uiModel.fractionDigitTextRollEdge).map { Edge(verticalEdge: $0) }) ?? .identity)

        case let groupingSeparator as VRollingCounterGroupingSeparatorComponent:
            Text(groupingSeparator.stringRepresentation)
                .foregroundStyle(textColor(groupingSeparator.isHighlighted, defaultValue: uiModel.groupingSeparatorTextColor))
                .font(uiModel.groupingSeparatorTextFont)
                .padding(uiModel.groupingSeparatorTextMargins)
                .offset(y: uiModel.groupingSeparatorTextOffsetY)
                .transition(.identity)

        case let decimalSeparator as VRollingCounterDecimalSeparatorComponent:
            Text(decimalSeparator.stringRepresentation)
                .foregroundStyle(textColor(decimalSeparator.isHighlighted, defaultValue: uiModel.fractionDigitTextColor))
                .font(uiModel.decimalSeparatorTextFont)
                .padding(uiModel.decimalSeparatorTextMargins)
                .offset(y: uiModel.decimalSeparatorTextOffsetY)
                .transition(.identity)

        default:
            fatalError()
        }
    }

    // MARK: Actions
    private func didChangeValue(to newValue: Double) {
        let oldValue: Double = VRollingCounterFactory.value(
            components: components,
            numberFormatter: numberFormatter
        )

        let newComponents: [any VRollingCounterComponentProtocol] = VRollingCounterFactory.components(
            oldComponents: components,
            newValue: newValue,
            uiModel: uiModel,
            numberFormatter: numberFormatter
        )

        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
            withAnimation(
                uiModel.highlightAnimation?.toSwiftUIAnimation,
                {
                    components = newComponents

                    highlightedColor = {
                        if newValue > oldValue {
                            uiModel.incrementHighlightColor
                        } else if newValue < oldValue {
                            uiModel.decrementHighlightColor
                        } else {
                            Color.clear
                        }
                    }()
                },
                completion: {
                    withAnimation(
                        uiModel.dehighlightAnimation?.toSwiftUIAnimation,
                        {
                            highlightedColor = .clear

                            for i in components.indices {
                                components[i].isHighlighted = false
                            }
                        }
                    )
                }
            )

        } else {
            withBasicAnimation(
                uiModel.highlightAnimation,
                body: {
                    components = newComponents

                    highlightedColor = {
                        if newValue > oldValue {
                            uiModel.incrementHighlightColor
                        } else if newValue < oldValue {
                            uiModel.decrementHighlightColor
                        } else {
                            Color.clear
                        }
                    }()
                },
                completion: {
                    withAnimation(
                        uiModel.dehighlightAnimation?.toSwiftUIAnimation, {
                            highlightedColor = .clear

                            for i in components.indices {
                                components[i].isHighlighted = false
                            }
                        }
                    )
                }
            )
        }
    }

    // MARK: Helpers
    private func textColor(
        _ isHighlighted: Bool,
        defaultValue: Color
    ) -> Color {
        guard isHighlighted, let highlightedColor else { return defaultValue }
        return highlightedColor
    }
}

// MARK: - Helpers
extension Edge {
    fileprivate init(verticalEdge: VerticalEdge) {
        switch verticalEdge {
        case .top: self = .top
        case .bottom: self = .bottom
        }
    }
}

extension AnyTransition {
    fileprivate static func rollingEdge(edge: Edge?) -> AnyTransition? {
        guard let edge else { return nil }

        if #available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *) {
            return AnyTransition.push(from: edge)
        } else {
            return AnyTransition.move(edge: edge).combined(with: .opacity)
        }
    }
}

// MARK: - Preview
// Developmental only
@available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *)
struct VRollingCounter_Previews: PreviewProvider {
    // Configuration
    private static var languageDirection: LayoutDirection { .leftToRight }
    private static var dynamicTypeSize: DynamicTypeSize? { nil }
    private static var colorScheme: ColorScheme { .light }

    // Previews
    static var previews: some View {
        Group(content: {
            Preview().previewDisplayName("*")
        })
        .environment(\.layoutDirection, languageDirection)
        .applyIfLet(dynamicTypeSize, transform: { $0.dynamicTypeSize($1) })
        .preferredColorScheme(colorScheme)
    }

    // Data
    private static var value: Double { 10_000 }

    // Previews (Scenes)
    private struct Preview: View {
        @State private var value: Double = VRollingCounter_Previews.value

        var body: some View {
            PreviewContainer(content: {
                VStack(spacing: 0, content: {
                    HStack(spacing: 20, content: {
                        Button( // No `VPlainButton` for unsupported platforms
                            "DECREMENT",
                            action: { value -= .random(in: 1...10) }
                        )

                        Button( // No `VPlainButton` for unsupported platforms
                            "INCREMENT",
                            action: { value += .random(in: 1...10) }
                        )
                    })
                    .padding(.top, 20)
                    .applyModifier({
#if os(watchOS)
                        $0.foregroundStyle(ColorBook.accentBlue)
#else
                        $0
#endif
                    })
                })

                ScrollView(content: {
                    PreviewRow(
                        axis: .vertical,
                        title: "Standard",
                        content: {
                            VRollingCounter(value: value)
                        }
                    )

                    PreviewRow(
                        axis: .vertical,
                        title: "No Fractions",
                        content: {
                            VRollingCounter(
                                uiModel: {
                                    var uiModel: VRollingCounterUIModel = .init()
                                    uiModel.hasFractionDigits = false
                                    return uiModel
                                }(),
                                value: value
                            )
                        }
                    )

                    PreviewRow(
                        axis: .vertical,
                        title: "No Grouping & No Fractions",
                        content: {
                            VRollingCounter(
                                uiModel: {
                                    var uiModel: VRollingCounterUIModel = .init()
                                    uiModel.hasGroupingSeparator = false
                                    uiModel.hasFractionDigits = false
                                    return uiModel
                                }(),
                                value: value
                            )
                        }
                    )

                    PreviewRow(
                        axis: .vertical,
                        title: "No Highlight",
                        content: {
                            VRollingCounter(
                                uiModel: {
                                    var uiModel: VRollingCounterUIModel = .init()
                                    uiModel.incrementHighlightColor = nil
                                    uiModel.decrementHighlightColor = nil
                                    return uiModel
                                }(),
                                value: value
                            )
                        }
                    )

                    PreviewRow(
                        axis: .vertical,
                        title: "Highlighted Symbols",
                        content: {
                            VRollingCounter(
                                uiModel: {
                                    var uiModel: VRollingCounterUIModel = .init()
                                    uiModel.groupingSeparatorTextIsHighlightable = true
                                    uiModel.decimalSeparatorTextIsHighlightable = true
                                    return uiModel
                                }(),
                                value: value
                            )
                        }
                    )

                    PreviewRow(
                        axis: .vertical,
                        title: "Full Highlight",
                        content: {
                            VRollingCounter(
                                uiModel: {
                                    var uiModel: VRollingCounterUIModel = .init()
                                    uiModel.highlightsOnlyTheAffectedCharacters = false
                                    uiModel.groupingSeparatorTextIsHighlightable = true
                                    uiModel.decimalSeparatorTextIsHighlightable = true
                                    return uiModel
                                }(),
                                value: value
                            )
                        }
                    )

                    PreviewRow(
                        axis: .vertical,
                        title: "Bottom Edge Roll",
                        content: {
                            VRollingCounter(
                                uiModel: {
                                    var uiModel: VRollingCounterUIModel = .init()
                                    uiModel.digitTextRollEdge = .bottom
                                    uiModel.fractionDigitTextRollEdge = .bottom
                                    return uiModel
                                }(),
                                value: value
                            )
                        }
                    )

                    PreviewRow(
                        axis: .vertical,
                        title: "Custom",
                        content: {
                            VRollingCounter(
                                uiModel: {
                                    var uiModel: VRollingCounterUIModel = .init()

                                    uiModel.decimalSeparatorTextColor = ColorBook.secondary
                                    uiModel.decimalSeparatorTextOffsetY = -10

                                    uiModel.fractionDigitTextColor = ColorBook.secondary
                                    uiModel.fractionDigitTextFont = .footnote.bold()
                                    uiModel.fractionDigitTextOffsetY = -2

                                    return uiModel
                                }(),
                                value: value
                            )
                        }
                    )
                })
                .padding(.vertical, 1)
            })
        }
    }
}
