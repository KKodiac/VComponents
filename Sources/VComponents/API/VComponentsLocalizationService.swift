//
//  VComponentsLocalizationService.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 23.05.22.
//

import Foundation

// MARK: - VComponents Localization Service
/// Localization service that can be used to localize the package.
///
/// `localizationProvider` in `shared` instance can be set to override the localized values.
public final class VComponentsLocalizationService {
    // MARK: Properties
    /// Shared instance of `VComponentsLocalizationService`.
    public static let shared: VComponentsLocalizationService = .init()
    
    /// Localization provider. Defaults to `DefaultVComponentsLocalizationProvider`.
    public var localizationProvider: any VComponentsLocalizationProvider = DefaultVComponentsLocalizationProvider()
    
    // MARK: Initializers
    private init() {}
}

// MARK: - VComponents Localization Provider
/// Localization provider in package.
public protocol VComponentsLocalizationProvider {
    /// Localized value for `VAlertOKButton`.
    var vAlertOKButtonTitle: String { get }
    
    /// Localized value for `VAlertCancelButton`.
    var vAlertCancelButtonTitle: String { get }
    
    /// Localized value for `VConfirmationDialogOKButton`.
    var vConfirmationDialogOKButtonTitle: String { get }
    
    /// Localized value for `VConfirmationDialogCancelButton`.
    var vConfirmationDialogCancelButtonTitle: String { get }
}

// MARK: - Default VComponents Localization Provider
/// Defaults VComponents localization provider.
public struct DefaultVComponentsLocalizationProvider: VComponentsLocalizationProvider {
    // MARK: Initializers
    /// Initializes `VComponentsLocalizationProvider`.
    public init() {}
    
    // MARK: VComponents Localization Provider
    public var vAlertOKButtonTitle: String { "Ok" }
    public var vAlertCancelButtonTitle: String { "Cancel" }
    
    public var vConfirmationDialogOKButtonTitle: String { "Ok" }
    public var vConfirmationDialogCancelButtonTitle: String { "Cancel" }
}
