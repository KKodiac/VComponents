//
//  VSquareButtonDemoView.swift
//  VComponentsDemo
//
//  Created by Vakhtang Kontridze on 18.12.20.
//

import SwiftUI
import VComponents

// MARK:- V Circular Button Demo View
struct VSquareButtonDemoView: View {
    // MARK: Properties
    static let navigationBarTitle: String = "Circular Button"
    
    private let buttonTitle: String = "Press"
    
    private func buttonContent() -> some View {
        Image(systemName: "swift")
            .resizable()
            .frame(size: .init(width: 20, height: 20))
            .foregroundColor(ColorBook.primaryInverted)
    }

    @State private var buttonState: VSquareButtonState = .enabled
}

// MARK:- Body
extension VSquareButtonDemoView {
    var body: some View {
        BaseDemoView(title: Self.navigationBarTitle, controller: { controller }, content: {
            shapeButtons
            filledButton
            borderedButton
            imageButtons
            biggerHitBoxButton
        })
    }
    
    private var controller: some View {
        DemoRowView(type: .controller, content: {
            ToggleSettingView(
                isOn: .init(
                    get: { buttonState == .disabled },
                    set: { buttonState = $0 ? .disabled : .enabled }
                ),
                title: "Disabled"
            )
        })
    }
    
    private var shapeButtons: some View {
        let roundedButtonModel: VSquareButtonFilledModel = .init(
            layout: .init(
                frame: .rounded()
            )
        )
        
        return VStack(content: {
            DemoRowView(type: .titled("Circle"), content: {
                VSquareButton(state: buttonState, action: action, title: buttonTitle)
            })
            
            DemoRowView(type: .titled("Rounded"), content: {
                VSquareButton(.filled(roundedButtonModel), state: buttonState, action: action, title: buttonTitle)
            })
        })
    }

    private var filledButton: some View {
        VStack(content: {
            DemoRowView(type: .titled("Filled"), content: {
                VSquareButton(.filled(), state: buttonState, action: action, title: buttonTitle)
            })
        })
    }
    
    private var borderedButton: some View {
        let dashedButtonModel: VSquareButtonBorderedModel = .init(
            layout: .init(
                borderType: .dashed()
            )
        )
        
        return VStack(content: {
            DemoRowView(type: .titled("Continous Border"), content: {
                VSquareButton(.bordered(), state: buttonState, action: action, title: buttonTitle)
            })
            
            DemoRowView(type: .titled("Dashed Border"), content: {
                VSquareButton(.bordered(dashedButtonModel), state: buttonState, action: action, title: buttonTitle)
            })
        })
    }
    
    private var imageButtons: some View {
        VStack(content: {
            DemoRowView(type: .titled("Image"), content: {
                VSquareButton(state: buttonState, action: action, content: buttonContent)
            })

            DemoRowView(type: .titled("Image and Text"), content: {
                VSquareButton(state: buttonState, action: action, content: {
                    HStack(spacing: 5, content: {
                        buttonContent()
                        Text("A")
                    })
                })
            })
        })
    }
    
    private var biggerHitBoxButton: some View {
        let biggerHitBoxButtonModel: VSquareButtonFilledModel = .init(
            layout: .init(
                hitBoxSpacingX: 20,
                hitBoxSpacingY: 20
            )
        )
        
        return VStack(content: {
            DemoRowView(type: .titled("Bigger Hit Box"), content: {
                VSquareButton(.filled(biggerHitBoxButtonModel), state: buttonState, action: action, title: buttonTitle)
            })
        })
    }
}

// MARK:- Action
private extension VSquareButtonDemoView {
    func action() {
        print("Pressed")
    }
}

// MARK: Preview
struct VSquareButtonDemoView_Previews: PreviewProvider {
    static var previews: some View {
        VSquareButtonDemoView()
    }
}
