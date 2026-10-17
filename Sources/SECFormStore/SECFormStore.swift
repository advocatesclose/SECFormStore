//
//  SECFormStore.swift
//  SECFormStore
//
//  Created by Javaad Ali on 10/17/26.
//  Copyright (c) 2026 Javaad Ali. All rights reserved.
//

import Foundation

// MARK: - Core Protocol
protocol SECReport {
    var title: String { get }
    var formCode: String { get }
}

// MARK: - 1. Operating Companies
enum OperatingCompany {
    enum AnnualAndQuarterly: Hashable, CaseIterable, SECReport {
        case annualReports, quarterlyReports, foreignAnnual, canadianAnnual
        var title: String {
            switch self {
            case .annualReports: return "Annual reports"
            case .quarterlyReports: return "Quarterly reports"
            case .foreignAnnual: return "Foreign annual"
            case .canadianAnnual: return "Canadian annual"
            }
        }
        var formCode: String {
            switch self {
            case .annualReports: return "10-K"
            case .quarterlyReports: return "10-Q"
            case .foreignAnnual: return "20-F"
            case .canadianAnnual: return "40-F"
            }
        }
    }
    
    enum MaterialEvents: Hashable, CaseIterable, SECReport {
        case currentReports, foreignCurrent, regAEvents, earningsResults, pressReleasesAndRegFD, materialContracts, insiderTradePolicies
        var title: String {
            switch self {
            case .currentReports: return "Current reports"
            case .foreignCurrent: return "Foreign current"
            case .regAEvents: return "Reg A events"
            case .earningsResults: return "Earnings results"
            case .pressReleasesAndRegFD: return "Press releases + Reg FD"
            case .materialContracts: return "Material contracts"
            case .insiderTradePolicies: return "Insider trade policies"
            }
        }
        var formCode: String {
            switch self {
            case .currentReports: return "8-K"
            case .foreignCurrent: return "6-K"
            case .regAEvents: return "1-U"
            case .earningsResults: return "8-K, ITEM 2.02"
            case .pressReleasesAndRegFD: return "EX 99"
            case .materialContracts: return "EX 10"
            case .insiderTradePolicies: return "EX 19"
            }
        }
    }
    
    enum ProxyAndShareholder: Hashable, CaseIterable, SECReport {
        case proxyStatements, preliminary, additional, nonManagementSoliciting, mergerProxyStatements, definitiveInfo, preliminaryInfo, annualReportToSH
        var title: String {
            switch self {
            case .proxyStatements: return "Proxy statements"
            case .preliminary: return "Preliminary"
            case .additional: return "Additional"
            case .nonManagementSoliciting: return "Non-management soliciting"
            case .mergerProxyStatements: return "Merger proxy statements"
            case .definitiveInfo: return "Definitive Info"
            case .preliminaryInfo: return "Preliminary info"
            case .annualReportToSH: return "Annual report to SH"
            }
        }
        var formCode: String {
            switch self {
            case .proxyStatements: return "DEF 14A"
            case .preliminary: return "PRE 14A"
            case .additional: return "DEFA14A"
            case .nonManagementSoliciting: return "DFAN14A"
            case .mergerProxyStatements: return "DEFM14A"
            case .definitiveInfo: return "DEF 14C"
            case .preliminaryInfo: return "PRE 14C"
            case .annualReportToSH: return "ARS"
            }
        }
    }
    
    enum CorporateInsiders: Hashable, CaseIterable, SECReport {
        case initialOwnership, insiderTrading, annualDeferred, restrictedSales
        var title: String {
            switch self {
            case .initialOwnership: return "Initial ownership"
            case .insiderTrading: return "Insider Trading"
            case .annualDeferred: return "Annual deferred"
            case .restrictedSales: return "Restricted sales"
            }
        }
        var formCode: String {
            switch self {
            case .initialOwnership: return "FORM 3"
            case .insiderTrading: return "FORM 4"
            case .annualDeferred: return "FORM 5"
            case .restrictedSales: return "FORM 144"
            }
        }
    }
    
    // Wrapper Enum
    enum ReportType: Hashable, CaseIterable, SECReport {
        case annualAndQuarterly(AnnualAndQuarterly)
        case materialEvents(MaterialEvents)
        case proxyAndShareholder(ProxyAndShareholder)
        case corporateInsiders(CorporateInsiders)
        
        static var allCases: [ReportType] {
            return AnnualAndQuarterly.allCases.map { .annualAndQuarterly($0) } +
                   MaterialEvents.allCases.map { .materialEvents($0) } +
                   ProxyAndShareholder.allCases.map { .proxyAndShareholder($0) } +
                   CorporateInsiders.allCases.map { .corporateInsiders($0) }
        }
        
        var title: String { extractReport.title }
        var formCode: String { extractReport.formCode }
        
        var categoryTitle: String {
            switch self {
            case .annualAndQuarterly: return "Annual & Quarterly Reports"
            case .materialEvents: return "Material Events & Disclosures"
            case .proxyAndShareholder: return "Proxy & Shareholder Voting"
            case .corporateInsiders: return "Corporate Insiders (Section 16)"
            }
        }
        
        private var extractReport: SECReport {
            switch self {
            case .annualAndQuarterly(let r): return r
            case .materialEvents(let r): return r
            case .proxyAndShareholder(let r): return r
            case .corporateInsiders(let r): return r
            }
        }
    }
}

// MARK: - 2. Capital Raising & Specialty
enum CapitalRaising {
    enum Prospectuses: Hashable, CaseIterable, SECReport {
        case structuredProducts, finalIPO, freeWriting, prospectusSupplements, shelfSupplements, maCommunications
        var title: String {
            switch self {
            case .structuredProducts: return "Structured products"
            case .finalIPO: return "Final IPO"
            case .freeWriting: return "Free writing"
            case .prospectusSupplements: return "Prospectus supplements"
            case .shelfSupplements: return "Shelf supplements"
            case .maCommunications: return "M&A communications"
            }
        }
        var formCode: String {
            switch self {
            case .structuredProducts: return "424B2"
            case .finalIPO: return "424B4"
            case .freeWriting: return "FWP"
            case .prospectusSupplements: return "424B3"
            case .shelfSupplements: return "424B5"
            case .maCommunications: return "425"
            }
        }
    }
    
    enum ExemptOfferings: Hashable, CaseIterable, SECReport {
        case regDPrivate, regAAnnual, crowdfunding, regAOfferings, regASemiAnnual, fundingPortals
        var title: String {
            switch self {
            case .regDPrivate: return "Reg D private"
            case .regAAnnual: return "Reg A annual"
            case .crowdfunding: return "Crowdfunding"
            case .regAOfferings: return "Reg A offerings"
            case .regASemiAnnual: return "Reg A semi-annual"
            case .fundingPortals: return "Funding portals"
            }
        }
        var formCode: String {
            switch self {
            case .regDPrivate: return "FORM D"
            case .regAAnnual: return "1-K"
            case .crowdfunding: return "FORM C"
            case .regAOfferings: return "1-A"
            case .regASemiAnnual: return "1-SA"
            case .fundingPortals: return "CFPORTAL"
            }
        }
    }
    
    enum AssetBackedSecurities: Hashable, CaseIterable, SECReport {
        case standardABSRegistration, distributionReports, repsAndWarranties, shelfABSRegistration, assetLevelData
        var title: String {
            switch self {
            case .standardABSRegistration: return "Standard ABS registration"
            case .distributionReports: return "Distribution reports"
            case .repsAndWarranties: return "Reps & warranties"
            case .shelfABSRegistration: return "Shelf ABS registration"
            case .assetLevelData: return "Asset-level data"
            }
        }
        var formCode: String {
            switch self {
            case .standardABSRegistration: return "SF-1"
            case .distributionReports: return "10-D"
            case .repsAndWarranties: return "ABS-15G"
            case .shelfABSRegistration: return "SF-3"
            case .assetLevelData: return "ABS-EE"
            }
        }
    }
    
    enum TenderOffersAndGoingPrivate: Hashable, CaseIterable, SECReport {
        case preCommencementComms, issuerSelfTender, goingPrivate, thirdParty, targetResponse, crossBorderTransactions
        var title: String {
            switch self {
            case .preCommencementComms: return "Pre-commencement comms"
            case .issuerSelfTender: return "Issuer self-tender"
            case .goingPrivate: return "Going private"
            case .thirdParty: return "Third-party"
            case .targetResponse: return "Target response"
            case .crossBorderTransactions: return "Cross-border transactions"
            }
        }
        var formCode: String {
            switch self {
            case .preCommencementComms: return "SC TO-C"
            case .issuerSelfTender: return "SC TO-I"
            case .goingPrivate: return "SC 13E3"
            case .thirdParty: return "SC TO-T"
            case .targetResponse: return "SC 14D9"
            case .crossBorderTransactions: return "CB"
            }
        }
    }
    
    enum ConfidentialSubmissions: Hashable, CaseIterable, SECReport {
        case draftRegistrations, draftRegA
        var title: String {
            switch self {
            case .draftRegistrations: return "Draft registrations"
            case .draftRegA: return "Draft Reg A"
            }
        }
        var formCode: String {
            switch self {
            case .draftRegistrations: return "DRS"
            case .draftRegA: return "DOS"
            }
        }
    }
    
    // Wrapper Enum
    enum ReportType: Hashable, CaseIterable, SECReport {
        case prospectuses(Prospectuses)
        case exemptOfferings(ExemptOfferings)
        case assetBacked(AssetBackedSecurities)
        case tenderOffers(TenderOffersAndGoingPrivate)
        case confidential(ConfidentialSubmissions)
        
        static var allCases: [ReportType] {
            return Prospectuses.allCases.map { .prospectuses($0) } +
                   ExemptOfferings.allCases.map { .exemptOfferings($0) } +
                   AssetBackedSecurities.allCases.map { .assetBacked($0) } +
                   TenderOffersAndGoingPrivate.allCases.map { .tenderOffers($0) } +
                   ConfidentialSubmissions.allCases.map { .confidential($0) }
        }
        
        var title: String { extractReport.title }
        var formCode: String { extractReport.formCode }
        
        var categoryTitle: String {
            switch self {
            case .prospectuses: return "Prospectuses (424 Series)"
            case .exemptOfferings: return "Exempt Offerings"
            case .assetBacked: return "Asset-Backed Securities"
            case .tenderOffers: return "Tender Offers & Going Private"
            case .confidential: return "Confidential Submissions"
            }
        }
        
        private var extractReport: SECReport {
            switch self {
            case .prospectuses(let r): return r
            case .exemptOfferings(let r): return r
            case .assetBacked(let r): return r
            case .tenderOffers(let r): return r
            case .confidential(let r): return r
            }
        }
    }
}

// MARK: - 3. Funds & Public Offerings
enum FundsAndOfferings {
    enum BusinessDevelopment: Hashable, CaseIterable, SECReport {
        case bdcElection, bdcAutoShelf, bdcRegistration
        var title: String {
            switch self {
            case .bdcElection: return "BDC election"
            case .bdcAutoShelf: return "BDC auto shelf"
            case .bdcRegistration: return "BDC registration"
            }
        }
        var formCode: String {
            switch self {
            case .bdcElection: return "N-54A"
            case .bdcAutoShelf: return "N-2ASR"
            case .bdcRegistration: return "N-2"
            }
        }
    }
    
    enum FundProspectuses: Hashable, CaseIterable, SECReport {
        case fundProspectus, variableInitialSummary, postEffectiveDelayed, summaryProspectus, variableUpdatingSummary, postEffectiveImmediate
        var title: String {
            switch self {
            case .fundProspectus: return "Fund prospectus"
            case .variableInitialSummary: return "Variable initial summary"
            case .postEffectiveDelayed: return "Post-effective (delayed)"
            case .summaryProspectus: return "Summary prospectus"
            case .variableUpdatingSummary: return "Variable updating summary"
            case .postEffectiveImmediate: return "Post-effective (immediate)"
            }
        }
        var formCode: String {
            switch self {
            case .fundProspectus: return "497"
            case .variableInitialSummary: return "497VPI"
            case .postEffectiveDelayed: return "485APOS"
            case .summaryProspectus: return "497K"
            case .variableUpdatingSummary: return "497VPU"
            case .postEffectiveImmediate: return "485BPOS"
            }
        }
    }
    
    enum PublicOfferingsDomestic: Hashable, CaseIterable, SECReport {
        case iposAndRegistration, businessCombinationsDomestic, reits, shelfRegistrations, employeePlans
        var title: String {
            switch self {
            case .iposAndRegistration: return "IPOs & registration"
            case .businessCombinationsDomestic: return "Business combinations"
            case .reits: return "REITs"
            case .shelfRegistrations: return "Shelf registrations"
            case .employeePlans: return "Employee plans"
            }
        }
        var formCode: String {
            switch self {
            case .iposAndRegistration: return "S-1"
            case .businessCombinationsDomestic: return "S-4"
            case .reits: return "S-11"
            case .shelfRegistrations: return "S-3"
            case .employeePlans: return "S-8"
            }
        }
    }
    
    enum FundReports: Hashable, CaseIterable, SECReport {
        case annualCensus, semiAnnualShareholderReports, proxyVoting, shareholderReports, moneyMarketEvents, variableProducts
        var title: String {
            switch self {
            case .annualCensus: return "Annual census"
            case .semiAnnualShareholderReports: return "Semi-annual shareholder reports"
            case .proxyVoting: return "Proxy voting"
            case .shareholderReports: return "Shareholder reports"
            case .moneyMarketEvents: return "Money market events"
            case .variableProducts: return "Variable products"
            }
        }
        var formCode: String {
            switch self {
            case .annualCensus: return "N-CEN"
            case .semiAnnualShareholderReports: return "N-CSRS"
            case .proxyVoting: return "N-PX"
            case .shareholderReports: return "N-CSR"
            case .moneyMarketEvents: return "N-CR"
            case .variableProducts: return "N-VP"
            }
        }
    }
    
    enum FundOperations: Hashable, CaseIterable, SECReport {
        case securitiesSold, deregistration, repurchaseOffers, exemptiveApps
        var title: String {
            switch self {
            case .securitiesSold: return "Securities sold"
            case .deregistration: return "Deregistration"
            case .repurchaseOffers: return "Repurchase offers"
            case .exemptiveApps: return "Exemptive apps"
            }
        }
        var formCode: String {
            switch self {
            case .securitiesSold: return "24F-2NT"
            case .deregistration: return "N-8F"
            case .repurchaseOffers: return "N-23C"
            case .exemptiveApps: return "40-APP"
            }
        }
    }
    
    enum PublicOfferingsForeign: Hashable, CaseIterable, SECReport {
        case foreignRegistration, foreignCombinations, rightsOffering, mjdsRegistration, foreignShelf, adrs, businessCombinationForeign, mjdsExchangeTender
        var title: String {
            switch self {
            case .foreignRegistration: return "Foreign registration"
            case .foreignCombinations: return "Foreign combinations"
            case .rightsOffering: return "Rights offering"
            case .mjdsRegistration: return "MJDS registration"
            case .foreignShelf: return "Foreign shelf"
            case .adrs: return "ADRs"
            case .businessCombinationForeign: return "Business combination"
            case .mjdsExchangeTender: return "MJDS exchange/tender"
            }
        }
        var formCode: String {
            switch self {
            case .foreignRegistration: return "F-1"
            case .foreignCombinations: return "F-4"
            case .rightsOffering: return "F-7"
            case .mjdsRegistration: return "F-10"
            case .foreignShelf: return "F-3"
            case .adrs: return "F-6"
            case .businessCombinationForeign: return "F-8"
            case .mjdsExchangeTender: return "F-80"
            }
        }
    }
    
    // Wrapper Enum
    enum ReportType: Hashable, CaseIterable, SECReport {
        case businessDevelopment(BusinessDevelopment)
        case fundProspectuses(FundProspectuses)
        case domesticOfferings(PublicOfferingsDomestic)
        case fundReports(FundReports)
        case fundOperations(FundOperations)
        case foreignOfferings(PublicOfferingsForeign)
        
        static var allCases: [ReportType] {
            return BusinessDevelopment.allCases.map { .businessDevelopment($0) } +
                   FundProspectuses.allCases.map { .fundProspectuses($0) } +
                   PublicOfferingsDomestic.allCases.map { .domesticOfferings($0) } +
                   FundReports.allCases.map { .fundReports($0) } +
                   FundOperations.allCases.map { .fundOperations($0) } +
                   PublicOfferingsForeign.allCases.map { .foreignOfferings($0) }
        }
        
        var title: String { extractReport.title }
        var formCode: String { extractReport.formCode }
        
        var categoryTitle: String {
            switch self {
            case .businessDevelopment: return "Business Development Cos"
            case .fundProspectuses: return "Fund Prospectuses & Supplements"
            case .domesticOfferings: return "Public Offerings — Domestic"
            case .fundReports: return "Fund Reports"
            case .fundOperations: return "Fund Operations"
            case .foreignOfferings: return "Public Offerings — Foreign"
            }
        }
        
        private var extractReport: SECReport {
            switch self {
            case .businessDevelopment(let r): return r
            case .fundProspectuses(let r): return r
            case .domesticOfferings(let r): return r
            case .fundReports(let r): return r
            case .fundOperations(let r): return r
            case .foreignOfferings(let r): return r
            }
        }
    }
}

// MARK: - 4. Holdings & Markets
enum HoldingsAndMarkets {
    enum InstitutionalHoldings: Hashable, CaseIterable, SECReport {
        case portfolioHoldings, coverPages
        var title: String {
            switch self {
            case .portfolioHoldings: return "Portfolio holdings"
            case .coverPages: return "Cover pages"
            }
        }
        var formCode: String {
            switch self {
            case .portfolioHoldings: return "13F-HR"
            case .coverPages: return "13F-HR"
            }
        }
    }
    
    enum BrokerDealersAndMarket: Hashable, CaseIterable, SECReport {
        case bdAnnualReports, transferAgentRpt, altTradingSystems, swapDealers, transferAgentReg, municipalAdvisors, ratingAgencies
        var title: String {
            switch self {
            case .bdAnnualReports: return "BD annual reports"
            case .transferAgentRpt: return "Transfer agent rpt"
            case .altTradingSystems: return "Alt trading systems"
            case .swapDealers: return "Swap dealers"
            case .transferAgentReg: return "Transfer agent reg"
            case .municipalAdvisors: return "Municipal advisors"
            case .ratingAgencies: return "Rating agencies"
            }
        }
        var formCode: String {
            switch self {
            case .bdAnnualReports: return "X-17A-5"
            case .transferAgentRpt: return "TA-2"
            case .altTradingSystems: return "ATS-N"
            case .swapDealers: return "SBSE"
            case .transferAgentReg: return "TA-1"
            case .municipalAdvisors: return "MA"
            case .ratingAgencies: return "NRSRO-CE"
            }
        }
    }
    
    enum FundRegistrationAndHoldings: Hashable, CaseIterable, SECReport {
        case mutualFundsAndETFs, fundPortfolioHoldings, separateAccount, variableLifeInsurance, closedEndAndBDCs, moneyMarketFundPortfolioReports, variableAnnuity, fundMergers
        var title: String {
            switch self {
            case .mutualFundsAndETFs: return "Mutual funds & ETFs"
            case .fundPortfolioHoldings: return "Portfolio holdings"
            case .separateAccount: return "Separate account"
            case .variableLifeInsurance: return "Variable life insurance"
            case .closedEndAndBDCs: return "Closed-end & BDCs"
            case .moneyMarketFundPortfolioReports: return "Money market fund portfolio reports"
            case .variableAnnuity: return "Variable annuity"
            case .fundMergers: return "Fund mergers"
            }
        }
        var formCode: String {
            switch self {
            case .mutualFundsAndETFs: return "N-1A"
            case .fundPortfolioHoldings: return "N-PORT"
            case .separateAccount: return "N-3"
            case .variableLifeInsurance: return "N-6"
            case .closedEndAndBDCs: return "N-2"
            case .moneyMarketFundPortfolioReports: return "N-MFP"
            case .variableAnnuity: return "N-4"
            case .fundMergers: return "N-14"
            }
        }
    }
    
    enum BeneficialOwnership: Hashable, CaseIterable, SECReport {
        case activeActivist, passiveInstitutional
        var title: String {
            switch self {
            case .activeActivist: return "Active / activist"
            case .passiveInstitutional: return "Passive / institutional"
            }
        }
        var formCode: String {
            switch self {
            case .activeActivist: return "13D"
            case .passiveInstitutional: return "13G"
            }
        }
    }
    
    enum SECAdministrative: Hashable, CaseIterable, SECReport {
        case commentLetters, confidentialTreatmentOrders, effectiveness
        var title: String {
            switch self {
            case .commentLetters: return "Comment letters"
            case .confidentialTreatmentOrders: return "Confidential treatment orders"
            case .effectiveness: return "Effectiveness"
            }
        }
        var formCode: String {
            switch self {
            case .commentLetters: return "CORRESP / LETTER"
            case .confidentialTreatmentOrders: return "CT ORDER"
            case .effectiveness: return "EFFECT"
            }
        }
    }
    
    // Wrapper Enum
    enum ReportType: Hashable, CaseIterable, SECReport {
        case institutionalHoldings(InstitutionalHoldings)
        case brokerDealers(BrokerDealersAndMarket)
        case fundRegistration(FundRegistrationAndHoldings)
        case beneficialOwnership(BeneficialOwnership)
        case secAdministrative(SECAdministrative)
        
        static var allCases: [ReportType] {
            return InstitutionalHoldings.allCases.map { .institutionalHoldings($0) } +
                   BrokerDealersAndMarket.allCases.map { .brokerDealers($0) } +
                   FundRegistrationAndHoldings.allCases.map { .fundRegistration($0) } +
                   BeneficialOwnership.allCases.map { .beneficialOwnership($0) } +
                   SECAdministrative.allCases.map { .secAdministrative($0) }
        }
        
        var title: String { extractReport.title }
        var formCode: String { extractReport.formCode }
        
        var categoryTitle: String {
            switch self {
            case .institutionalHoldings: return "Institutional Holdings"
            case .brokerDealers: return "Broker-Dealers & Market Infrastructure"
            case .fundRegistration: return "Fund Registration & Holdings"
            case .beneficialOwnership: return "Beneficial Ownership (5%+)"
            case .secAdministrative: return "SEC Administrative"
            }
        }
        
        private var extractReport: SECReport {
            switch self {
            case .institutionalHoldings(let r): return r
            case .brokerDealers(let r): return r
            case .fundRegistration(let r): return r
            case .beneficialOwnership(let r): return r
            case .secAdministrative(let r): return r
            }
        }
    }
}

