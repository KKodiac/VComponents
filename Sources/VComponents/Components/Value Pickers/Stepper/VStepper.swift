//
//  VStepper.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 2/2/21.
//

import SwiftUI
import VCore

// MARK: - V Stepper
/// Value picker component that selects value from a bounded linear range of values.
///
/// UI Model, step, and state can be passed as parameters.
///
///     @State private var value: Double = 0.5
///
///     var body: some View {
///         VStepper(
///             range: 1...10,
///             value: $value
///         )
///             .padding()
///     }
///
public struct VStepper: View {
    // MARK: Properties
    private let uiModel: VStepperUIModel
    
    @Environment(\.isEnabled) private var isEnabled: Bool
    private var internalState: VStepperInternalState { .init(isEnabled: isEnabled) }
    @State private var pressedButton: VStepperButton?
    private func buttonInternalState(_ button: VStepperButton) -> VStepperButtonInternalState {
        .init(
            isEnabled: buttonIsEnabled(for: button),
            isPressed: pressedButton == button
        )
    }
    
    private let range: ClosedRange<Int>
    private let step: Int
    
    @Binding private var value: Int
    
    @State private var longPressSchedulerTimer: Timer?
    @State private var longPressIncrementTimer: Timer?
    @State private var longPressIncrementTimerIncremental: Timer?
    @State private var longPressIncrementTimeElapsed: TimeInterval = 0
    @State private var shouldSkipIncrementBecauseOfLongPressIncrementFinish: Bool = false
    
    // MARK: Initializers
    /// Initializes `VStepper` with range and value.
    public init(
        uiModel: VStepperUIModel = .init(),
        range: ClosedRange<Int>,
        step: Int = 1,
        value: Binding<Int>
    ) {
        self.uiModel = uiModel
        self.range = range
        self.step = step
        self._value = value
    }

    // MARK: Body
    public var body: some View {
        ZStack(content: {
            background
            buttons
        })
            .frame(size: uiModel.layout.size)
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: uiModel.layout.cornerRadius)
            .foregroundColor(uiModel.colors.background.value(for: internalState))
    }
    
    private var buttons: some View {
        HStack(spacing: 0, content: {
            button(.minus)
            divider
            button(.plus)
        })
            .frame(maxWidth: .infinity)
    }
    
    private func button(_ button: VStepperButton) -> some View {
        SwiftUIGestureBaseButton(
            onStateChange: { gestureHandler(button: button, gestureState: $0) },
            label: {
                ZStack(content: {
                    RoundedRectangle(cornerRadius: uiModel.layout.cornerRadius)
                        .foregroundColor(uiModel.colors.buttonBackground.value(for: buttonInternalState(button)))
                    
                    button.icon
                        .resizable()
                        .frame(dimension: uiModel.layout.iconDimension)
                        .foregroundColor(uiModel.colors.buttonIcon.value(for: buttonInternalState(button)))
                })
                    .frame(maxWidth: .infinity)
            }
        )
            .disabled(!buttonIsEnabled(for: button))
    }
    
    private var divider: some View {
        Rectangle()
            .frame(size: uiModel.layout.divider)
            .foregroundColor(uiModel.colors.divider.value(for: internalState))
    }
    
    // MARK: Actions
    private func gestureHandler(button: VStepperButton, gestureState: GestureBaseButtonGestureState) {
        pressGestureHandler(button, isPressed: gestureState.isPressed)
        if gestureState.isClicked { clickGestureHandler(button) }
    }

    private func clickGestureHandler(_ button: VStepperButton) {
        guard !shouldSkipIncrementBecauseOfLongPressIncrementFinish else {
            shouldSkipIncrementBecauseOfLongPressIncrementFinish = false
            return
        }
        
        switch button {
        case .minus:
            if value <= range.lowerBound {
                zeroLongPressTimers()
            } else {
                value -= step
            }
        
        case .plus:
            if value >= range.upperBound {
                zeroLongPressTimers()
            } else {
                value += step
            }
        }
    }
    
    private func pressGestureHandler(_ button: VStepperButton, isPressed: Bool) {
        if !isPressed {
            pressedButton = nil
            shouldSkipIncrementBecauseOfLongPressIncrementFinish = longPressIncrementTimer != nil
            zeroLongPressTimers()
            
        } else if pressedButton != button {
            pressedButton = button
            scheduleLongPressIncrementSchedulerTimer(for: button)
        }
    }

    // MARK: Long Press Increment
    private func scheduleLongPressIncrementSchedulerTimer(for button: VStepperButton) {
        zeroLongPressTimers()
        
        longPressSchedulerTimer = .scheduledTimer(withTimeInterval: uiModel.misc.intervalToStartLongPressIncrement, repeats: false, block: { _ in
            scheduleLongPressIncrementTimer()
        })
    }
    
    private func scheduleLongPressIncrementTimer() {
        zeroLongPressTimers()
        
        longPressIncrementTimer = .scheduledTimer(withTimeInterval: 1, repeats: true, block: { timer in
            longPressIncrementTimeElapsed += timer.timeInterval
            incrementFromLongPress()
        })
        
        longPressIncrementTimeElapsed = 1
        longPressIncrementTimer?.fire()
    }
    
    private func incrementFromLongPress() {
        longPressIncrementTimerIncremental?.invalidate()
        longPressIncrementTimerIncremental = nil

        let interval: TimeInterval = {
            let adjustedStep: Int = .init(pow(.init(uiModel.misc.longPressIncrementExponent), longPressIncrementTimeElapsed)) * step
            let interval: TimeInterval = 1 / .init(adjustedStep)
            return interval
        }()
        
        longPressIncrementTimerIncremental = .scheduledTimer(withTimeInterval: interval, repeats: true, block: { timer in
            if let pressedButton {
                clickGestureHandler(pressedButton)
            } else {
                zeroLongPressTimers()
            }
        })
        
        longPressIncrementTimerIncremental?.fire()
    }
    
    private func zeroLongPressTimers() {
        longPressSchedulerTimer?.invalidate()
        longPressSchedulerTimer = nil
        
        longPressIncrementTimer?.invalidate()
        longPressIncrementTimer = nil
        
        longPressIncrementTimerIncremental?.invalidate()
        longPressIncrementTimerIncremental = nil
        
        longPressIncrementTimeElapsed = 0
    }
    
    // MARK: Helpers
    private func buttonIsEnabled(for button: VStepperButton) -> Bool {
        switch (internalState, button) {
        case (.disabled, _): return false
        case (.enabled, .minus): return !(value <= range.lowerBound)
        case (.enabled, .plus): return !(value >= range.upperBound)
        }
    }
}

// MARK: - Preview
struct VStepper_Previews: PreviewProvider {
    static var previews: some View {
        Preview()
    }
    
    private struct Preview: View {
        @State private var value: Int = 5
        
        var body: some View {
            VStack(content: {
                VStepper(
                    range: 1...10,
                    value: $value
                )
                
                Text(String(value))
            })
        }
    }
}
