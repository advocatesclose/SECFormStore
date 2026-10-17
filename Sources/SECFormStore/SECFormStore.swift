//
//  SECFormStore.swift
//  SECFormStore
//
//  Created by Javaad Ali on 10/17/26.
//  Copyright (c) 2026 Javaad Ali. All rights reserved.
//

import Foundation

// MARK: - Form Types
// MARK: - Master SEC Report Enum
public enum SECReport: Hashable, CaseIterable {
    
    // MARK: - 1. Nested Grouping Enums
    
    // Operating Companies
    public enum AnnualAndQuarterly: Hashable, CaseIterable {
        case annualReports, quarterlyReports, foreignAnnual, canadianAnnual
    }
    public enum MaterialEvents: Hashable, CaseIterable {
        case currentReports, foreignCurrent, regAEvents, earningsResults, pressReleasesAndRegFD, materialContracts, insiderTradePolicies
    }
    public enum ProxyAndShareholder: Hashable, CaseIterable {
        case proxyStatements, preliminary, additional, nonManagementSoliciting, mergerProxyStatements, definitiveInfo, preliminaryInfo, annualReportToSH
    }
    public enum CorporateInsiders: Hashable, CaseIterable {
        case initialOwnership, insiderTrading, annualDeferred, restrictedSales
    }
    
    // Capital Raising & Specialty
    public enum Prospectuses: Hashable, CaseIterable {
        case structuredProducts, finalIPO, freeWriting, prospectusSupplements, shelfSupplements, maCommunications
    }
    public enum ExemptOfferings: Hashable, CaseIterable {
        case regDPrivate, regAAnnual, crowdfunding, regAOfferings, regASemiAnnual, fundingPortals
    }
    public enum AssetBackedSecurities: Hashable, CaseIterable {
        case standardABSRegistration, distributionReports, repsAndWarranties, shelfABSRegistration, assetLevelData
    }
    public enum TenderOffersAndGoingPrivate: Hashable, CaseIterable {
        case preCommencementComms, issuerSelfTender, goingPrivate, thirdParty, targetResponse, crossBorderTransactions
    }
    public enum ConfidentialSubmissions: Hashable, CaseIterable {
        case draftRegistrations, draftRegA
    }
    
    // Funds & Public Offerings
    public enum BusinessDevelopment: Hashable, CaseIterable {
        case bdcElection, bdcAutoShelf, bdcRegistration
    }
    public enum FundProspectuses: Hashable, CaseIterable {
        case fundProspectus, variableInitialSummary, postEffectiveDelayed, summaryProspectus, variableUpdatingSummary, postEffectiveImmediate
    }
    public enum PublicOfferingsDomestic: Hashable, CaseIterable {
        case iposAndRegistration, businessCombinationsDomestic, reits, shelfRegistrations, employeePlans
    }
    public enum FundReports: Hashable, CaseIterable {
        case annualCensus, semiAnnualShareholderReports, proxyVoting, shareholderReports, moneyMarketEvents, variableProducts
    }
    public enum FundOperations: Hashable, CaseIterable {
        case securitiesSold, deregistration, repurchaseOffers, exemptiveApps
    }
    public enum PublicOfferingsForeign: Hashable, CaseIterable {
        case foreignRegistration, foreignCombinations, rightsOffering, mjdsRegistration, foreignShelf, adrs, businessCombinationForeign, mjdsExchangeTender
    }
    
    // Holdings & Markets
    public enum InstitutionalHoldings: Hashable, CaseIterable {
        case portfolioHoldings, coverPages
    }
    public enum BrokerDealersAndMarket: Hashable, CaseIterable {
        case bdAnnualReports, transferAgentRpt, altTradingSystems, swapDealers, transferAgentReg, municipalAdvisors, ratingAgencies
    }
    public enum FundRegistrationAndHoldings: Hashable, CaseIterable {
        case mutualFundsAndETFs, fundPortfolioHoldings, separateAccount, variableLifeInsurance, closedEndAndBDCs, moneyMarketFundPortfolioReports, variableAnnuity, fundMergers
    }
    public enum BeneficialOwnership: Hashable, CaseIterable {
        case activeActivist, passiveInstitutional
    }
    public enum SECAdministrative: Hashable, CaseIterable {
        case commentLetters, confidentialTreatmentOrders, effectiveness
    }
    
    // MARK: - 2. Wrapper Cases
    
    case annualAndQuarterly(AnnualAndQuarterly)
    case materialEvents(MaterialEvents)
    case proxyAndShareholder(ProxyAndShareholder)
    case corporateInsiders(CorporateInsiders)
    
    case prospectuses(Prospectuses)
    case exemptOfferings(ExemptOfferings)
    case assetBackedSecurities(AssetBackedSecurities)
    case tenderOffersAndGoingPrivate(TenderOffersAndGoingPrivate)
    case confidentialSubmissions(ConfidentialSubmissions)
    
    case businessDevelopment(BusinessDevelopment)
    case fundProspectuses(FundProspectuses)
    case publicOfferingsDomestic(PublicOfferingsDomestic)
    case fundReports(FundReports)
    case fundOperations(FundOperations)
    case publicOfferingsForeign(PublicOfferingsForeign)
    
    case institutionalHoldings(InstitutionalHoldings)
    case brokerDealersAndMarket(BrokerDealersAndMarket)
    case fundRegistrationAndHoldings(FundRegistrationAndHoldings)
    case beneficialOwnership(BeneficialOwnership)
    case secAdministrative(SECAdministrative)
    
    // MARK: - 3. CaseIterable Synthesis
    
    public static var allCases: [SECReport] {
        return AnnualAndQuarterly.allCases.map { .annualAndQuarterly($0) } +
               MaterialEvents.allCases.map { .materialEvents($0) } +
               ProxyAndShareholder.allCases.map { .proxyAndShareholder($0) } +
               CorporateInsiders.allCases.map { .corporateInsiders($0) } +
        
               Prospectuses.allCases.map { .prospectuses($0) } +
               ExemptOfferings.allCases.map { .exemptOfferings($0) } +
               AssetBackedSecurities.allCases.map { .assetBackedSecurities($0) } +
               TenderOffersAndGoingPrivate.allCases.map { .tenderOffersAndGoingPrivate($0) } +
               ConfidentialSubmissions.allCases.map { .confidentialSubmissions($0) } +
        
               BusinessDevelopment.allCases.map { .businessDevelopment($0) } +
               FundProspectuses.allCases.map { .fundProspectuses($0) } +
               PublicOfferingsDomestic.allCases.map { .publicOfferingsDomestic($0) } +
               FundReports.allCases.map { .fundReports($0) } +
               FundOperations.allCases.map { .fundOperations($0) } +
               PublicOfferingsForeign.allCases.map { .publicOfferingsForeign($0) } +
        
               InstitutionalHoldings.allCases.map { .institutionalHoldings($0) } +
               BrokerDealersAndMarket.allCases.map { .brokerDealersAndMarket($0) } +
               FundRegistrationAndHoldings.allCases.map { .fundRegistrationAndHoldings($0) } +
               BeneficialOwnership.allCases.map { .beneficialOwnership($0) } +
               SECAdministrative.allCases.map { .secAdministrative($0) }
    }
    
    // MARK: - 4. Properties
    
    public var title: String {
        switch self {
        case .annualAndQuarterly(let r):
            switch r {
            case .annualReports: return "Annual reports"
            case .quarterlyReports: return "Quarterly reports"
            case .foreignAnnual: return "Foreign annual"
            case .canadianAnnual: return "Canadian annual"
            }
        case .materialEvents(let r):
            switch r {
            case .currentReports: return "Current reports"
            case .foreignCurrent: return "Foreign current"
            case .regAEvents: return "Reg A events"
            case .earningsResults: return "Earnings results"
            case .pressReleasesAndRegFD: return "Press releases + Reg FD"
            case .materialContracts: return "Material contracts"
            case .insiderTradePolicies: return "Insider trade policies"
            }
        case .proxyAndShareholder(let r):
            switch r {
            case .proxyStatements: return "Proxy statements"
            case .preliminary: return "Preliminary"
            case .additional: return "Additional"
            case .nonManagementSoliciting: return "Non-management soliciting"
            case .mergerProxyStatements: return "Merger proxy statements"
            case .definitiveInfo: return "Definitive Info"
            case .preliminaryInfo: return "Preliminary info"
            case .annualReportToSH: return "Annual report to SH"
            }
        case .corporateInsiders(let r):
            switch r {
            case .initialOwnership: return "Initial ownership"
            case .insiderTrading: return "Insider Trading"
            case .annualDeferred: return "Annual deferred"
            case .restrictedSales: return "Restricted sales"
            }
        case .prospectuses(let r):
            switch r {
            case .structuredProducts: return "Structured products"
            case .finalIPO: return "Final IPO"
            case .freeWriting: return "Free writing"
            case .prospectusSupplements: return "Prospectus supplements"
            case .shelfSupplements: return "Shelf supplements"
            case .maCommunications: return "M&A communications"
            }
        case .exemptOfferings(let r):
            switch r {
            case .regDPrivate: return "Reg D private"
            case .regAAnnual: return "Reg A annual"
            case .crowdfunding: return "Crowdfunding"
            case .regAOfferings: return "Reg A offerings"
            case .regASemiAnnual: return "Reg A semi-annual"
            case .fundingPortals: return "Funding portals"
            }
        case .assetBackedSecurities(let r):
            switch r {
            case .standardABSRegistration: return "Standard ABS registration"
            case .distributionReports: return "Distribution reports"
            case .repsAndWarranties: return "Reps & warranties"
            case .shelfABSRegistration: return "Shelf ABS registration"
            case .assetLevelData: return "Asset-level data"
            }
        case .tenderOffersAndGoingPrivate(let r):
            switch r {
            case .preCommencementComms: return "Pre-commencement comms"
            case .issuerSelfTender: return "Issuer self-tender"
            case .goingPrivate: return "Going private"
            case .thirdParty: return "Third-party"
            case .targetResponse: return "Target response"
            case .crossBorderTransactions: return "Cross-border transactions"
            }
        case .confidentialSubmissions(let r):
            switch r {
            case .draftRegistrations: return "Draft registrations"
            case .draftRegA: return "Draft Reg A"
            }
        case .businessDevelopment(let r):
            switch r {
            case .bdcElection: return "BDC election"
            case .bdcAutoShelf: return "BDC auto shelf"
            case .bdcRegistration: return "BDC registration"
            }
        case .fundProspectuses(let r):
            switch r {
            case .fundProspectus: return "Fund prospectus"
            case .variableInitialSummary: return "Variable initial summary"
            case .postEffectiveDelayed: return "Post-effective (delayed)"
            case .summaryProspectus: return "Summary prospectus"
            case .variableUpdatingSummary: return "Variable updating summary"
            case .postEffectiveImmediate: return "Post-effective (immediate)"
            }
        case .publicOfferingsDomestic(let r):
            switch r {
            case .iposAndRegistration: return "IPOs & registration"
            case .businessCombinationsDomestic: return "Business combinations"
            case .reits: return "REITs"
            case .shelfRegistrations: return "Shelf registrations"
            case .employeePlans: return "Employee plans"
            }
        case .fundReports(let r):
            switch r {
            case .annualCensus: return "Annual census"
            case .semiAnnualShareholderReports: return "Semi-annual shareholder reports"
            case .proxyVoting: return "Proxy voting"
            case .shareholderReports: return "Shareholder reports"
            case .moneyMarketEvents: return "Money market events"
            case .variableProducts: return "Variable products"
            }
        case .fundOperations(let r):
            switch r {
            case .securitiesSold: return "Securities sold"
            case .deregistration: return "Deregistration"
            case .repurchaseOffers: return "Repurchase offers"
            case .exemptiveApps: return "Exemptive apps"
            }
        case .publicOfferingsForeign(let r):
            switch r {
            case .foreignRegistration: return "Foreign registration"
            case .foreignCombinations: return "Foreign combinations"
            case .rightsOffering: return "Rights offering"
            case .mjdsRegistration: return "MJDS registration"
            case .foreignShelf: return "Foreign shelf"
            case .adrs: return "ADRs"
            case .businessCombinationForeign: return "Business combination"
            case .mjdsExchangeTender: return "MJDS exchange/tender"
            }
        case .institutionalHoldings(let r):
            switch r {
            case .portfolioHoldings: return "Portfolio holdings"
            case .coverPages: return "Cover pages"
            }
        case .brokerDealersAndMarket(let r):
            switch r {
            case .bdAnnualReports: return "BD annual reports"
            case .transferAgentRpt: return "Transfer agent rpt"
            case .altTradingSystems: return "Alt trading systems"
            case .swapDealers: return "Swap dealers"
            case .transferAgentReg: return "Transfer agent reg"
            case .municipalAdvisors: return "Municipal advisors"
            case .ratingAgencies: return "Rating agencies"
            }
        case .fundRegistrationAndHoldings(let r):
            switch r {
            case .mutualFundsAndETFs: return "Mutual funds & ETFs"
            case .fundPortfolioHoldings: return "Portfolio holdings"
            case .separateAccount: return "Separate account"
            case .variableLifeInsurance: return "Variable life insurance"
            case .closedEndAndBDCs: return "Closed-end & BDCs"
            case .moneyMarketFundPortfolioReports: return "Money market fund portfolio reports"
            case .variableAnnuity: return "Variable annuity"
            case .fundMergers: return "Fund mergers"
            }
        case .beneficialOwnership(let r):
            switch r {
            case .activeActivist: return "Active / activist"
            case .passiveInstitutional: return "Passive / institutional"
            }
        case .secAdministrative(let r):
            switch r {
            case .commentLetters: return "Comment letters"
            case .confidentialTreatmentOrders: return "Confidential treatment orders"
            case .effectiveness: return "Effectiveness"
            }
        }
    }
    
    public var formCode: String {
        switch self {
        case .annualAndQuarterly(let r):
            switch r {
            case .annualReports: return "10-K"
            case .quarterlyReports: return "10-Q"
            case .foreignAnnual: return "20-F"
            case .canadianAnnual: return "40-F"
            }
        case .materialEvents(let r):
            switch r {
            case .currentReports: return "8-K"
            case .foreignCurrent: return "6-K"
            case .regAEvents: return "1-U"
            case .earningsResults: return "8-K, ITEM 2.02"
            case .pressReleasesAndRegFD: return "EX 99"
            case .materialContracts: return "EX 10"
            case .insiderTradePolicies: return "EX 19"
            }
        case .proxyAndShareholder(let r):
            switch r {
            case .proxyStatements: return "DEF 14A"
            case .preliminary: return "PRE 14A"
            case .additional: return "DEFA14A"
            case .nonManagementSoliciting: return "DFAN14A"
            case .mergerProxyStatements: return "DEFM14A"
            case .definitiveInfo: return "DEF 14C"
            case .preliminaryInfo: return "PRE 14C"
            case .annualReportToSH: return "ARS"
            }
        case .corporateInsiders(let r):
            switch r {
            case .initialOwnership: return "FORM 3"
            case .insiderTrading: return "FORM 4"
            case .annualDeferred: return "FORM 5"
            case .restrictedSales: return "FORM 144"
            }
        case .prospectuses(let r):
            switch r {
            case .structuredProducts: return "424B2"
            case .finalIPO: return "424B4"
            case .freeWriting: return "FWP"
            case .prospectusSupplements: return "424B3"
            case .shelfSupplements: return "424B5"
            case .maCommunications: return "425"
            }
        case .exemptOfferings(let r):
            switch r {
            case .regDPrivate: return "FORM D"
            case .regAAnnual: return "1-K"
            case .crowdfunding: return "FORM C"
            case .regAOfferings: return "1-A"
            case .regASemiAnnual: return "1-SA"
            case .fundingPortals: return "CFPORTAL"
            }
        case .assetBackedSecurities(let r):
            switch r {
            case .standardABSRegistration: return "SF-1"
            case .distributionReports: return "10-D"
            case .repsAndWarranties: return "ABS-15G"
            case .shelfABSRegistration: return "SF-3"
            case .assetLevelData: return "ABS-EE"
            }
        case .tenderOffersAndGoingPrivate(let r):
            switch r {
            case .preCommencementComms: return "SC TO-C"
            case .issuerSelfTender: return "SC TO-I"
            case .goingPrivate: return "SC 13E3"
            case .thirdParty: return "SC TO-T"
            case .targetResponse: return "SC 14D9"
            case .crossBorderTransactions: return "CB"
            }
        case .confidentialSubmissions(let r):
            switch r {
            case .draftRegistrations: return "DRS"
            case .draftRegA: return "DOS"
            }
        case .businessDevelopment(let r):
            switch r {
            case .bdcElection: return "N-54A"
            case .bdcAutoShelf: return "N-2ASR"
            case .bdcRegistration: return "N-2"
            }
        case .fundProspectuses(let r):
            switch r {
            case .fundProspectus: return "497"
            case .variableInitialSummary: return "497VPI"
            case .postEffectiveDelayed: return "485APOS"
            case .summaryProspectus: return "497K"
            case .variableUpdatingSummary: return "497VPU"
            case .postEffectiveImmediate: return "485BPOS"
            }
        case .publicOfferingsDomestic(let r):
            switch r {
            case .iposAndRegistration: return "S-1"
            case .businessCombinationsDomestic: return "S-4"
            case .reits: return "S-11"
            case .shelfRegistrations: return "S-3"
            case .employeePlans: return "S-8"
            }
        case .fundReports(let r):
            switch r {
            case .annualCensus: return "N-CEN"
            case .semiAnnualShareholderReports: return "N-CSRS"
            case .proxyVoting: return "N-PX"
            case .shareholderReports: return "N-CSR"
            case .moneyMarketEvents: return "N-CR"
            case .variableProducts: return "N-VP"
            }
        case .fundOperations(let r):
            switch r {
            case .securitiesSold: return "24F-2NT"
            case .deregistration: return "N-8F"
            case .repurchaseOffers: return "N-23C"
            case .exemptiveApps: return "40-APP"
            }
        case .publicOfferingsForeign(let r):
            switch r {
            case .foreignRegistration: return "F-1"
            case .foreignCombinations: return "F-4"
            case .rightsOffering: return "F-7"
            case .mjdsRegistration: return "F-10"
            case .foreignShelf: return "F-3"
            case .adrs: return "F-6"
            case .businessCombinationForeign: return "F-8"
            case .mjdsExchangeTender: return "F-80"
            }
        case .institutionalHoldings(let r):
            switch r {
            case .portfolioHoldings: return "13F-HR"
            case .coverPages: return "13F-HR"
            }
        case .brokerDealersAndMarket(let r):
            switch r {
            case .bdAnnualReports: return "X-17A-5"
            case .transferAgentRpt: return "TA-2"
            case .altTradingSystems: return "ATS-N"
            case .swapDealers: return "SBSE"
            case .transferAgentReg: return "TA-1"
            case .municipalAdvisors: return "MA"
            case .ratingAgencies: return "NRSRO-CE"
            }
        case .fundRegistrationAndHoldings(let r):
            switch r {
            case .mutualFundsAndETFs: return "N-1A"
            case .fundPortfolioHoldings: return "N-PORT"
            case .separateAccount: return "N-3"
            case .variableLifeInsurance: return "N-6"
            case .closedEndAndBDCs: return "N-2"
            case .moneyMarketFundPortfolioReports: return "N-MFP"
            case .variableAnnuity: return "N-4"
            case .fundMergers: return "N-14"
            }
        case .beneficialOwnership(let r):
            switch r {
            case .activeActivist: return "13D"
            case .passiveInstitutional: return "13G"
            }
        case .secAdministrative(let r):
            switch r {
            case .commentLetters: return "CORRESP / LETTER"
            case .confidentialTreatmentOrders: return "CT ORDER"
            case .effectiveness: return "EFFECT"
            }
        }
    }
    
    public var subCategoryTitle: String {
        switch self {
        case .annualAndQuarterly: return "Annual & Quarterly Reports"
        case .materialEvents: return "Material Events & Disclosures"
        case .proxyAndShareholder: return "Proxy & Shareholder Voting"
        case .corporateInsiders: return "Corporate Insiders (Section 16)"
            
        case .prospectuses: return "Prospectuses (424 Series)"
        case .exemptOfferings: return "Exempt Offerings"
        case .assetBackedSecurities: return "Asset-Backed Securities"
        case .tenderOffersAndGoingPrivate: return "Tender Offers & Going Private"
        case .confidentialSubmissions: return "Confidential Submissions"
            
        case .businessDevelopment: return "Business Development Cos"
        case .fundProspectuses: return "Fund Prospectuses & Supplements"
        case .publicOfferingsDomestic: return "Public Offerings — Domestic"
        case .fundReports: return "Fund Reports"
        case .fundOperations: return "Fund Operations"
        case .publicOfferingsForeign: return "Public Offerings — Foreign"
            
        case .institutionalHoldings: return "Institutional Holdings"
        case .brokerDealersAndMarket: return "Broker-Dealers & Market Infrastructure"
        case .fundRegistrationAndHoldings: return "Fund Registration & Holdings"
        case .beneficialOwnership: return "Beneficial Ownership (5%+)"
        case .secAdministrative: return "SEC Administrative"
        }
    }
    
    public var mainCategoryTitle: String {
        switch self {
        case .annualAndQuarterly, .materialEvents, .proxyAndShareholder, .corporateInsiders:
            return "Operating Companies"
        case .prospectuses, .exemptOfferings, .assetBackedSecurities, .tenderOffersAndGoingPrivate, .confidentialSubmissions:
            return "Capital Raising & Specialty"
        case .businessDevelopment, .fundProspectuses, .publicOfferingsDomestic, .fundReports, .fundOperations, .publicOfferingsForeign:
            return "Funds & Public Offerings"
        case .institutionalHoldings, .brokerDealersAndMarket, .fundRegistrationAndHoldings, .beneficialOwnership, .secAdministrative:
            return "Holdings & Markets"
        }
    }
}
// MARK: - Form Groups
public extension SECReport {
    // Each case represents a whole group; its forms carry the individual report values.
    enum FormGroups: CaseIterable, Hashable, Sendable {
        case annualAndQuarterly
        case materialEvents
        case proxyAndShareholder
        case corporateInsiders
        case prospectuses
        case exemptOfferings
        case assetBackedSecurities
        case tenderOffersAndGoingPrivate
        case confidentialSubmissions
        case businessDevelopment
        case fundProspectuses
        case publicOfferingsDomestic
        case fundReports
        case fundOperations
        case publicOfferingsForeign
        case institutionalHoldings
        case brokerDealersAndMarket
        case fundRegistrationAndHoldings
        case beneficialOwnership
        case secAdministrative

        public var title: String {
            switch self {
            case .annualAndQuarterly: return "Annual & Quarterly Reports"
            case .materialEvents: return "Material Events & Disclosures"
            case .proxyAndShareholder: return "Proxy & Shareholder Voting"
            case .corporateInsiders: return "Corporate Insiders (Section 16)"
            case .prospectuses: return "Prospectuses (424 Series)"
            case .exemptOfferings: return "Exempt Offerings"
            case .assetBackedSecurities: return "Asset-Backed Securities"
            case .tenderOffersAndGoingPrivate: return "Tender Offers & Going Private"
            case .confidentialSubmissions: return "Confidential Submissions"
            case .businessDevelopment: return "Business Development Cos"
            case .fundProspectuses: return "Fund Prospectuses & Supplements"
            case .publicOfferingsDomestic: return "Public Offerings — Domestic"
            case .fundReports: return "Fund Reports"
            case .fundOperations: return "Fund Operations"
            case .publicOfferingsForeign: return "Public Offerings — Foreign"
            case .institutionalHoldings: return "Institutional Holdings"
            case .brokerDealersAndMarket: return "Broker-Dealers & Market Infrastructure"
            case .fundRegistrationAndHoldings: return "Fund Registration & Holdings"
            case .beneficialOwnership: return "Beneficial Ownership (5%+)"
            case .secAdministrative: return "SEC Administrative"
            }
        }

        public var forms: [SECReport] {
            switch self {
            case .annualAndQuarterly:
                return SECReport.AnnualAndQuarterly.allCases.map(SECReport.annualAndQuarterly)
            case .materialEvents:
                return SECReport.MaterialEvents.allCases.map(SECReport.materialEvents)
            case .proxyAndShareholder:
                return SECReport.ProxyAndShareholder.allCases.map(SECReport.proxyAndShareholder)
            case .corporateInsiders:
                return SECReport.CorporateInsiders.allCases.map(SECReport.corporateInsiders)
            case .prospectuses:
                return SECReport.Prospectuses.allCases.map(SECReport.prospectuses)
            case .exemptOfferings:
                return SECReport.ExemptOfferings.allCases.map(SECReport.exemptOfferings)
            case .assetBackedSecurities:
                return SECReport.AssetBackedSecurities.allCases.map(SECReport.assetBackedSecurities)
            case .tenderOffersAndGoingPrivate:
                return SECReport.TenderOffersAndGoingPrivate.allCases.map(SECReport.tenderOffersAndGoingPrivate)
            case .confidentialSubmissions:
                return SECReport.ConfidentialSubmissions.allCases.map(SECReport.confidentialSubmissions)
            case .businessDevelopment:
                return SECReport.BusinessDevelopment.allCases.map(SECReport.businessDevelopment)
            case .fundProspectuses:
                return SECReport.FundProspectuses.allCases.map(SECReport.fundProspectuses)
            case .publicOfferingsDomestic:
                return SECReport.PublicOfferingsDomestic.allCases.map(SECReport.publicOfferingsDomestic)
            case .fundReports:
                return SECReport.FundReports.allCases.map(SECReport.fundReports)
            case .fundOperations:
                return SECReport.FundOperations.allCases.map(SECReport.fundOperations)
            case .publicOfferingsForeign:
                return SECReport.PublicOfferingsForeign.allCases.map(SECReport.publicOfferingsForeign)
            case .institutionalHoldings:
                return SECReport.InstitutionalHoldings.allCases.map(SECReport.institutionalHoldings)
            case .brokerDealersAndMarket:
                return SECReport.BrokerDealersAndMarket.allCases.map(SECReport.brokerDealersAndMarket)
            case .fundRegistrationAndHoldings:
                return SECReport.FundRegistrationAndHoldings.allCases.map(SECReport.fundRegistrationAndHoldings)
            case .beneficialOwnership:
                return SECReport.BeneficialOwnership.allCases.map(SECReport.beneficialOwnership)
            case .secAdministrative:
                return SECReport.SECAdministrative.allCases.map(SECReport.secAdministrative)
            }
        }
    }
}
