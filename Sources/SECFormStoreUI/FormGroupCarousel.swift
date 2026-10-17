import SwiftUI
import SECFormStore

public struct FormGroupCarousel: View {
    private let group: SECReport.FormGroups

    public init(group: SECReport.FormGroups) {
        self.group = group
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(group.title)
                .font(.title2.bold())
                .accessibilityAddTraits(.isHeader)
                .padding(.horizontal, 20)

            ScrollView(.horizontal) {
                // These small groups use an eager stack so the tallest card
                // determines the carousel height, including at larger text sizes.
                HStack(alignment: .top, spacing: 12) {
                    ForEach(group.forms, id: \.self) { form in
                        FormTypeCard(form: form)
                            .containerRelativeFrame(.horizontal) { width, _ in
                                min(280, width * 0.85)
                            }
                    }
                }
                .scrollTargetLayout()
                .padding(.vertical, 4)
            }
            .contentMargins(.horizontal, 20, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
        }
    }
}
