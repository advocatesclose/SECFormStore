//
//  SECFormStore.swift
//  SECFormStore
//
//  Created by Javaad Ali on 10/17/26.
//  Copyright (c) 2026 Javaad Ali. All rights reserved.
//

import SwiftUI
import SECFormStore

public struct SECFormBrowser: View {
    private let groups: [SECReport.FormGroups]

    public init(groups: [SECReport.FormGroups] = SECReport.FormGroups.allCases) {
        self.groups = groups
    }

    public var body: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 28) {
                ForEach(groups, id: \.self) { group in
                    FormGroupCarousel(group: group)
                }
            }
            .padding(.vertical, 20)
        }
        .foregroundStyle(.white)
        .background {
            FormAtmosphereBackground()
        }
    }
}
