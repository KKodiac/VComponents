//
//  VDisclosureGroupDemoView.swift
//  VComponentsDemo
//
//  Created by Vakhtang Kontridze on 1/11/21.
//

import SwiftUI
import VComponents

// MARK: - V Disclosure Group Demo View
struct VDisclosureGroupDemoView: View {
    // MARK: Properties
    static var navBarTitle: String { "Disclosure Group" }
    
    @State private var isEnabled: Bool = true
    @State private var isExpanded: Bool = true
    @State private var expandCollapseOnHeaderTap: Bool = true
    @State private var hasDivider: Bool = VDisclosureGroupModel.Layout().dividerHeight > 0
    
    private var model: VDisclosureGroupModel {
        var model: VDisclosureGroupModel = .init()
        
        model.layout.dividerHeight = hasDivider ? (model.layout.dividerHeight == 0 ? 1 : model.layout.dividerHeight) : 0
        model.colors.divider = hasDivider ? (model.colors.divider == .clear ? .gray : model.colors.divider) : .clear
        
        model.misc.expandsAndCollapsesOnHeaderTap = expandCollapseOnHeaderTap
        
        return model
    }

    // MARK: Body
    var body: some View {
        DemoView(
            hasLayer: false,
            component: component,
            settings: settings
        )
            .standardNavigationTitle(Self.navBarTitle)
    }
    
    private func component() -> some View {
        ZStack(alignment: .top, content: {
            ColorBook.canvas.ignoresSafeArea(.all, edges: .all)

            VDisclosureGroup(
                model: model,
                isExpanded: $isExpanded,
                headerTitle: "Lorem Ipsum",
                content: {
                    VList(data: 0..<10, content: { num in
                        Text(String(num))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    })
                }
            )
                .disabled(!isEnabled)
        })
    }
    
    @ViewBuilder private func settings() -> some View {
        VSegmentedPicker(
            selection: .init(
                get: { _VDisclosureGroupState(isEnabled: isEnabled, isExpanded: isExpanded) },
                set: { state in
                    isEnabled = state != .disabled
                    isExpanded = state == .expanded
                }
            ),
            headerTitle: "State"
        )
        
        ToggleSettingView(isOn: $expandCollapseOnHeaderTap, title: "Expand/Collapse on Header Tap")
        
        ToggleSettingView(isOn: $hasDivider, title: "Divider")
    }
}

// MARK: - Helpers
private enum _VDisclosureGroupState: PickableTitledEnumeration {
    case collapsed
    case expanded
    case disabled
    
    init(isEnabled: Bool, isExpanded: Bool) {
        switch (isEnabled, isExpanded) {
        case (false, _): self = .disabled
        case (true, false): self = .collapsed
        case (true, true): self = .expanded
        }
    }
    
    var pickerTitle: String {
        switch self {
        case .collapsed: return "Collapsed"
        case .expanded: return "Expanded"
        case .disabled: return "Disabled"
        }
    }
}

// MARK: - Preview
struct VDisclosureGroupDemoView_Previews: PreviewProvider {
    static var previews: some View {
        VDisclosureGroupDemoView()
    }
}
