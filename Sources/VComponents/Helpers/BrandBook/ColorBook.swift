//
//  ColorBook.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 19.12.20.
//

import SwiftUI

// MARK: - Color Book
/// Contains fundamental colors used throughout the library.
public struct ColorBook {
    // MARK: Properties
    /// Canvas color that can be used as background.
    public static let canvas: Color = .init(componentAsset: "Canvas")
    
    /// Layer color for container components.
    public static let layer: Color = .init(componentAsset: "Layer")
    
    /// Primary text color.
    public static let primary: Color = .init(componentAsset: "Primary")
    
    /// Primary text color that inverts color scheme.
    public static let primaryInverted: Color = .init(componentAsset: "PrimaryInverted")
    
    /// Primary white text color.
    public static let primaryWhite: Color = .init(componentAsset: "PrimaryWhite")
    
    /// Primary black text color that inverts.
    public static let primaryBlack: Color = .init(componentAsset: "PrimaryBlack")
    
    /// Secondary text color.
    public static let secondary: Color = .init(componentAsset: "Secondary")
    
    static let primaryPressedDisabled: Color = .init(componentAsset: "Primary.presseddisabled")
    
    static let primaryInvertedPressedDisabled: Color = .init(componentAsset: "PrimaryInverted.presseddisabled")
    
    static let primaryWhitePressedDisabled: Color = .init(componentAsset: "PrimaryWhite.presseddisabled")
    
    static let primaryBlackPressedDisabled: Color = .init(componentAsset: "PrimaryBlack.presseddisabled")
    
    static let secondaryPressedDisabled: Color = .init(componentAsset: "Secondary.presseddisabled")
    
    /// Blue accent color.
    public static let accent: Color = .init(componentAsset: "Accent")
    
    // MARK: Initializers
    private init() {}
}

// MARK: - Helpers
extension Color {
    /// Initializes color from library's local assets library from a name.
    public init(componentAsset name: String) {
        guard
            let uiColor: UIColor = .init(named: name, in: .module, compatibleWith: nil)
        else {
            fatalError()
        }
        
        self.init(uiColor)
    }
}

// MARK: - Assets
/*
 
 Accent
 0.122.255 // Apple
 10.132.255 // Apple
 
 Canvas
 247.247.247
 0.0.0
 
 Layer
 254.254.254
 20.20.20
 
 Primary
 0.0.0
 255.255.255
 
 PrimaryBlack
 0.0.0
 0.0.0
 
 PrimaryInverted
 255.255.255
 0.0.0
 
 PrimaryWhite
 255.255.255
 255.255.255
 
 Secondary
 120.120.120
 140.140.140
 
*/

/*

 CheckBox.Border.disabled
 230.230.230
 40.40.40
 
 CheckBox.Border.off
 200.200.200
 80.80.80
 
 CheckBox.Border.pressedOff
 180.180.180
 60.60.60
 
 ChevronButton.Background.disabled
 250.250.250
 80.80.80
 
 ChevronButton.Background.enabled
 235.235.235
 55.55.55
 
 ChevronButton.Background.pressed
 210.210.210
 45.45.45

 Dialog.DestructiveButton.Background.disabled
 255.140.140
 
 Dialog.DestructiveButton.Background.enabled
 255.59.48 // Apple
 255.69.68 // Apple
 
 Dialog.SecondaryButton.Background.pressed
 235.235.235
 70.70.70
 
 BottomSheet.Grabber
 230.230.230
 100.100.100
 
 List.Divider
 60.60.60 @ 30
 85.85.85 @ 60
 
 Modal.Blinding
 100.100.100 @ 30
 0.0.0 @ 60
 
 Modal.CloseButton.Icon.enabled
 100.100.100
 160.160.160
 
 PageIndicator.Dot
 190.190.190
 120.120.120
 
 PlainButton.Text.enabled
 0.122.255
 10.132.255
 
 PrimaryButton.Background.disabled
 128.176.240
 
 PrimaryButton.Background.enabled
 24.126.240
 25.131.255
 
 PrimaryButton.Background.pressed
 31.104.182
 36.106.186
 
 SegmentedPicker.Background.enabled
 240.240.240
 40.40.40
 
 SegmentedPicker.Divider.disabled
 230.230.230
 50.50.50
 
 SegmentedPicker.Divider.enabled
 215.215.215
 70.70.70
 
 SegmentedPicker.Header.enabled
 60.60.60
 210.210.210
 
 SegmentedPicker.Indicator.disabled
 254.254.254
 60.60.60
 
 SegmentedPicker.Indicator.enabled
 254.254.254
 90.90.90
 
 Slider.Thumb.Border.disabled
 192.192.192
 
 Slider.Thumb.Border.enabled
 96.96.96
 
 Slider.Thumb.Shadow.disabled
 96.96.96 @ 20
 
 Slider.Thumb.Shadow.enabled
 96.96.96 @ 50
 
 Stepper.Button.Background.pressed
 200.200.200
 70.70.70
 
 TextField.Background.focused
 225.225.225
 50.50.50
 
 TextField.ClearButton.Background.disabled
 220.220.220
 40.40.40
 
 TextField.ClearButton.Background.enabled
 170.170.170
 30.30.30
 
 TextField.ClearButton.Background.pressed
 150.150.150
 20.20.20
 
 TextField.ClearButton.Icon
 255.255.255
 230.230.230
 
 TextField.Error.Background.enabled
 250.240.240
 229.125.125
 
 TextField.Error.Foreground.enabled
 235.110.105
 
 TextField.PlainButton.enabled
 70.70.70
 240.240.240
 
 TextField.Success.Background.enabled
 235.250.240
 130.180.140
 
 TextField.Success.Foreground.enabled
 85.195.135
 
 TextField.Warning.Background.enabled
 255.250.240
 245.150.90
 
 TextField.Warning.Foreground.enabled
 255.190.35
 
 Toggle.Fill.disabled
 244.244.244
 40.40.40
 
 Toggle.Fill.off
 233.233.233
 55.55.55
 
 Toggle.Fill.pressedOff
 220.220.220
 50.50.50
 
 Toggle.Thumb
 254.254.254
 
*/
