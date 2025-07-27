//
//  TrainingSessionWeekBar.swift
//  TrainingsLog
//
//  Created by Vlad Maltsev on 22.07.2025.
//

import SwiftUI
import SwiftData

struct TrainingSessionWeekBar: View {
    let summary: TrainingSessionWeekSummary

    var body: some View {
        HStack(spacing: 16) {
            Spacer(minLength: 8)
            ForEach(summary.days, id: \.date) { day in
                Item(day: day, maxLoad: summary.maxLoad ?? .zero)
            }
            Spacer(minLength: 16)
        }
    }
}

extension TrainingSessionWeekBar {
    struct Item: View {
        let day: TrainingSessionWeekSummary.DaySummary
        let maxLoad: WeightValue

        var body: some View {
            VStack {
                ZStack {
                    Capsule(style: .continuous)
                        .foregroundStyle(Color.gray.quinary)

                    let currentOutside = day.currentLoad?.value ?? 0 >= day.previousLoad?.value ?? 0
                    let color = day.kinds.first?.glyph?.tint.color ?? .accentColor

                    if let current = day.currentLoad {
                        Bar(
                            value: current.value,
                            maxValue: maxLoad.value,
                            outerInsets: currentOutside ? 0 : 4,
                            insets: currentOutside ? 4 : 8,
                        )
                        .foregroundStyle(color)
                    }
                    if let previousLoad = day.previousLoad {
                        Bar(
                            value: previousLoad.value,
                            maxValue: maxLoad.value,
                            outerInsets: currentOutside ? 4 : 0,
                            insets: currentOutside ? 8 : 4
                        )
                        .foregroundStyle(currentOutside ? Color.white.opacity(0.33) : color.opacity(0.25))
                    }
                }
                .aspectRatio(0.618, contentMode: .fit)
                Text(day.date.formatted(.dateTime.day()))
                    .font(.caption.monospaced())
            }
        }
    }

    struct Bar: Shape {

        let value: CGFloat
        let maxValue: CGFloat
        let outerInsets: CGFloat
        let insets: CGFloat

        func path(in rect: CGRect) -> Path {
            let innerRect = rect.insetBy(dx: insets, dy: insets)
            let cornerRadius = innerRect.width / 2
            let relHeight = maxValue > 0 ? value / maxValue : 1.0

            var height = innerRect.height * relHeight

            if outerInsets > 0 {
                let adjustedHeight = (rect.height - 2 * (insets - outerInsets)) * relHeight - 2 * outerInsets
                height = min(height, adjustedHeight)
            }

            let width = min(innerRect.width, height)

            return Path(
                roundedRect: CGRect(
                    x: rect.midX - width / 2,
                    y: innerRect.maxY - height,
                    width: width,
                    height: height
                ),
                cornerRadius: cornerRadius,
                style: .continuous
            )
        }
    }
}

#Preview {
    let summary = TrainingSessionWeekSummary(
        days: [
            .init(
                date: Date(),
                kinds: [],
                previousLoad: 16,
                currentLoad: 16
            ),
            .init(
                date: Date().addingTimeInterval(1 * 60 * 60 * 24),
                kinds: [TrainingKind(name: "Something", glyph: .init(tint: .orange))],
                previousLoad: 14,
                currentLoad: 14
            ),
            .init(
                date: Date().addingTimeInterval(2 * 60 * 60 * 24),
                kinds: [],
                previousLoad: 12,
                currentLoad: 12
            ),
            .init(
                date: Date().addingTimeInterval(3 * 60 * 60 * 24),
                kinds: [],
                previousLoad: 11,
                currentLoad: 10
            ),
            .init(
                date: Date().addingTimeInterval(4 * 60 * 60 * 24),
                kinds: [],
                previousLoad: 9,
                currentLoad: nil
            ),
            .init(
                date: Date().addingTimeInterval(5 * 60 * 60 * 24),
                kinds: [],
                previousLoad: 6,
                currentLoad: nil
            ),
            .init(
                date: Date().addingTimeInterval(6 * 60 * 60 * 24),
                kinds: [],
                previousLoad: 1,
                currentLoad: 1
            ),
        ]
    )
    TrainingSessionWeekBar(summary: summary)
}
