import SwiftUI
import SECFormStore

public struct FormTypeCard: View {
    private let form: SECReport

    public init(form: SECReport) {
        self.form = form
    }

    private var palette: FormCardPalette {
        switch form {
        case .annualAndQuarterly, .publicOfferingsDomestic, .publicOfferingsForeign:
            return .blue
        case .materialEvents, .fundReports, .fundOperations:
            return .teal
        case .proxyAndShareholder, .beneficialOwnership, .institutionalHoldings:
            return .indigo
        case .corporateInsiders, .tenderOffersAndGoingPrivate, .businessDevelopment:
            return .amber
        case .prospectuses, .fundProspectuses, .confidentialSubmissions:
            return .plum
        case .exemptOfferings, .assetBackedSecurities, .brokerDealersAndMarket,
             .fundRegistrationAndHoldings, .secAdministrative:
            return .slate
        }
    }

    public var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Image(systemName: palette.symbol)
                .font(.title2)
                .padding(10)
                .background(.white.opacity(0.12), in: RoundedRectangle(cornerRadius: 12))
                .accessibilityHidden(true)

            Text(form.formCode)
                .font(.title3.weight(.semibold))

            Spacer()
            HStack {
                Spacer()
                Text(form.title.capitalized(with: .autoupdatingCurrent))
                    .font(.largeTitle)
                    
            }
        }
        .foregroundStyle(.white)
        .fixedSize(horizontal: false, vertical: true)
        .padding(20)
        .frame(maxWidth: .infinity, minHeight: 210, alignment: .topLeading)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(
                    LinearGradient(
                        colors: [palette.color, palette.color.mix(with: .black, by: 0.45)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay {
                    // A quiet highlight adds depth without requiring image assets.
                    RoundedRectangle(cornerRadius: 24)
                        .fill(
                            RadialGradient(
                                colors: [.white.opacity(0.14), .clear],
                                center: .topTrailing,
                                startRadius: 0,
                                endRadius: 220
                            )
                        )
                }
        }
        .overlay {
            RoundedRectangle(cornerRadius: 24)
                .strokeBorder(
                    LinearGradient(
                        colors: [.white.opacity(0.35), .white.opacity(0.06)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                )
        }
        .accessibilityElement(children: .combine)
    }
}

private enum FormCardPalette {
    case blue, teal, indigo, amber, plum, slate

    var color: Color {
        // Deep base colors preserve white text contrast in either appearance.
        switch self {
        case .blue: return Color(red: 0.12, green: 0.30, blue: 0.56)
        case .teal: return Color(red: 0.06, green: 0.36, blue: 0.39)
        case .indigo: return Color(red: 0.28, green: 0.25, blue: 0.53)
        case .amber: return Color(red: 0.47, green: 0.27, blue: 0.10)
        case .plum: return Color(red: 0.43, green: 0.22, blue: 0.41)
        case .slate: return Color(red: 0.23, green: 0.32, blue: 0.43)
        }
    }

    var symbol: String {
        switch self {
        case .blue: return "doc.text"
        case .teal: return "waveform.path"
        case .indigo: return "person.2"
        case .amber: return "building.2"
        case .plum: return "doc.richtext"
        case .slate: return "chart.bar"
        }
    }
}
