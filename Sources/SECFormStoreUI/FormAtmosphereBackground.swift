//
//  SECFormStore.swift
//  SECFormStore
//
//  Created by Javaad Ali on 10/17/26.
//  Copyright (c) 2026 Javaad Ali. All rights reserved.
//

import SwiftUI

public struct FormAtmosphereBackground: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.scenePhase) private var scenePhase

    public init() {}

    public var body: some View {
        TimelineView(.animation(minimumInterval: 1.0 / 30.0,
                                paused: reduceMotion || scenePhase != .active)) { context in
            // A full drift takes about a minute. Only the background redraws.
            let phase = reduceMotion ? 0 : context.date.timeIntervalSinceReferenceDate / 12
            GeometryReader { geometry in
                let radius = max(geometry.size.width, geometry.size.height)

                ZStack {
                    LinearGradient(
                        colors: [
                            Color(red: 0.07, green: 0.12, blue: 0.25),
                            Color(red: 0.10, green: 0.08, blue: 0.22),
                            Color(red: 0.04, green: 0.07, blue: 0.16)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )

                    RadialGradient(
                        colors: [Color(red: 0.32, green: 0.20, blue: 0.52).opacity(0.55), .clear],
                        center: UnitPoint(
                            x: 0.75 + 0.20 * sin(phase),
                            y: 0.30 + 0.18 * cos(phase)
                        ),
                        startRadius: 0,
                        endRadius: radius * 0.85
                    )

                    RadialGradient(
                        colors: [Color(red: 0.12, green: 0.30, blue: 0.48).opacity(0.4), .clear],
                        center: UnitPoint(
                            x: 0.20 + 0.20 * cos(phase * 0.8),
                            y: 0.75 + 0.15 * sin(phase * 0.8)
                        ),
                        startRadius: 0,
                        endRadius: radius * 0.7
                    )
                }
            }
        }
        .ignoresSafeArea()
        .allowsHitTesting(false)
        .accessibilityHidden(true)
    }
}
