//
//  PresentationHost.swift
//  VComponents
//
//  Created by Vakhtang Kontridze on 4/14/22.
//

import SwiftUI

// MARK: - Presentation Host
/// Presentation Host that allows `SwiftUI` `View` to present another `View` modally in `UIKit` style.
///
/// `View` works by inserting an `UIViewController` in view hierarchy and using it as a presentation host.
/// `PresentationHost` presents content via `UIHostingController` embedded inside `PresentationHostViewController`.
///
/// When `isPresented` is set to `true` from code, and content is not yet presented, `PresentationHost` passes content to view hierarchy.
/// After this appear animations can occur.
///
/// When `dismiss` must be called from presented modal after dismiss animations have finished, `PresentationHost` will remove content from view hierarchy.
///
/// When `isPresented` is set to `false` from code, `PresentationHost` triggers external dismiss via `PresentationHostPresentationMode`.
/// This allows content to perform dismiss animations before being removed from view hierarchy.
/// For additional documentation, refer to `PresentationHostPresentationMode`.
///
///     extension View {
///         public func someModal<Content>(
///             isPresented: Binding<Bool>,
///             someModal: @escaping () -> SomeModal<Content>
///         ) -> some View
///             where Content: View
///         {
///             self
///                 .background(PresentationHost(
///                     isPresented: isPresented,
///                     content: {
///                         _SomeModal(
///                             content: someModal().content
///                         )
///                     }
///                 ))
///         }
///     }
///
///     public struct SomeModal<Content> where Content: View {
///         public let content: () -> Content
///     }
///
///     struct _SomeModal<Content>: View where Content: View {
///         @Environment(\.presentationHostPresentationMode) private var presentationMode
///         private let content: () -> Content
///
///         @State private var isInternallyPresented: Bool = false // Cane be used for animations
///
///         init(content: @escaping () -> Content) {
///             self.content = content
///         }
///
///         var body: some View {
///             content() // UI, customization, and animations go here...
///
///                 .onAppear(perform: animateIn)
///                 .onTapGesture(perform: animateOut)
///                 .onChange(
///                     of: presentationMode.isExternallyDismissed,
///                     perform: { if $0 && isInternallyPresented { animateOutFromExternalDismiss() } }
///                  )
///         }
///
///         private func animateIn() {
///             withBasicAnimation(
///                 .init(curve: .easeInOut, duration: 0.3),
///                 body: { isInternallyPresented = true },
///                 completion: nil
///             )
///         }
///
///         private func animateOut() {
///             withBasicAnimation(
///                 .init(curve: .easeInOut, duration: 0.3),
///                 body: { isInternallyPresented = false },
///                 completion: presentationMode.dismiss
///             )
///         }
///
///         private func animateOutFromExternalDismiss() {
///             withBasicAnimation(
///                 .init(curve: .easeInOut, duration: 0.3),
///                 body: { isInternallyPresented = false },
///                 completion: presentationMode.externalDismissCompletion
///             )
///         }
///     }
///
public struct PresentationHost<Content>: UIViewControllerRepresentable where Content: View {
    // MARK: Properties
    private let isPresented: Binding<Bool>
    private let allowsHitTests: Bool
    private let content: () -> Content
    
    @State private var wasInternallyDismissed: Bool = false
    
    // MARK: Initializers
    /// Initializes `PresentationHost` with condition and content.
    public init(
        isPresented: Binding<Bool>,
        allowsHitTests: Bool = true,
        content: @escaping () -> Content
    ) {
        self.isPresented = isPresented
        self.allowsHitTests = allowsHitTests
        self.content = content
    }
    
    // MARK: Representable
    public func makeUIViewController(context: Context) -> PresentationHostViewController {
        .init(allowsHitTests: allowsHitTests)
    }

    public func updateUIViewController(_ uiViewController: PresentationHostViewController, context: Context) {
        switch isPresented.wrappedValue {
        case false:
            if uiViewController.isPresentingView {
                uiViewController.dismissHostedView()
            }
            
        case true:
            let content: AnyView = .init(
                content()
                    .presentationHostPresentationMode(.init(
                        dismiss: {
                            wasInternallyDismissed = true
                            
                            isPresented.wrappedValue = false
                            uiViewController.dismissHostedView()
                            
                            DispatchQueue.main.async(execute: { wasInternallyDismissed = false })
                        },
                        
                        isExternallyDismissed:
                            uiViewController.isPresentingView &&
                            !isPresented.wrappedValue &&
                            !wasInternallyDismissed
                        ,
                        
                        externalDismissCompletion: uiViewController.dismissHostedView
                    ))
            )
            
            if !uiViewController.isPresentingView {
                uiViewController.presentHostedView(content)
            }
            
            uiViewController.updateHostedView(with: content)
        }
    }
}
