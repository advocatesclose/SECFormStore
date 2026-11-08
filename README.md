# **SECFormStore**

**A zero-dependency, type-safe Swift taxonomy and metadata store for SEC EDGAR filings, exhibits, and administrative disclosures.**  
SECFormStore replaces fragile, stringly-typed SEC form identifiers with a compiler-verified, hierarchical Swift enumeration (SECReport). Built purely on Foundation, it models **106 distinct SEC filing types and exhibit codes** organized across **4 primary market pillars** and **20 functional subcategories**—making it ideal for EDGAR data pipelines, securities research platforms, and native macOS/iOS financial interfaces.

## **Key Features**

### Dot Syntax
Dot syntax is supported.

```swift 
SECReport.CorporateInsiders 

SECReport.AssetBackedSecurities
```
or accept any valid SEC filing globally via SECReport.  

### Converting to String
Filing cases automatically resolve to human-readable forms. So , to get title, do `.title`. To get the official form code, do `.formCode`, and so on.

### CaseIterable
CaseIterable conformance is synthesized across all nested enumerations (`SECReport.allCases`). 

A group descriptor is provided at `SECReport.FormGroups`. The descriptor maps each of the 20 regulatory categories to the related `\[SECReport\]` array.  

### Thread Safety

`FormStore` conforms to `Hashable` and `CaseIterable`. `FormGroups` are `Sendable` and can be used in SwiftUI List, Picker, and OutlineGroup views, NSTokenField filter bars, or concurrent server-side Swift ingestion workers.

## Use

### Resolving Filing Metadata and EDGAR Form Codes

Suppose you're looking at an IPO. 

```swift 
import SECFormStore

let filing: SECReport = .publicOfferingsDomestic(.iposAndRegistration)

print(filing.formCode)          // "S-1"  
print(filing.title)             // "IPOs & registration"  
print(filing.subCategoryTitle)  // "Public Offerings — Domestic"  
print(filing.mainCategoryTitle) // "Funds & Public Offerings"
```

### Regulatory

Each subcategory is a standalone nested enum inside SECReport. Functions and query builders can be restricted to specific subsets.
```swift 
func fetchSection16Filings(for type: SECReport.CorporateInsiders) -> String {  
    let report = SECReport.corporateInsiders(type)  
    return "Querying EDGAR for \(report.formCode) (\(report.title))"  
}

let query = fetchSection16Filings(for: .insiderTrading)  
// "Querying EDGAR for FORM 4 (Insider Trading)"
```

### UI applications

Use `SECReport.FormGroups` to iterate through all 20 subcategories. Access their underlying SECReport cases without need for manual grouping logic:  

```swift 
for group in SECReport.FormGroups.allCases {  
    print("## \(group.title)")  
    for report in group.forms {  
        print("  - [\(report.formCode)\] \(report.title)")  
    }  
}
```
### Search & Reverse Lookup Across All Filings

SECReport.allCases builds autocomplete tokens and can be reverse-mapped for raw EDGAR strings. You can search for `formCode` as "14A" and `title` as "proxy":
```swift
// Find filings that match a query. So, if 
let searchResults = SECReport.allCases.filter { report in  
    report.formCode.localizedCaseInsensitiveContains("14A") ||  
    report.title.localizedCaseInsensitiveContains("proxy")  
}

// Group all 106 filings by their 4 top-level market pillars  
let pillars = Dictionary(grouping: SECReport.allCases, by: .mainCategoryTitle)
```
## Full Taxonomy

SECFormStore organizes filings into four top-level domains (mainCategoryTitle): 

- Operating Companies
- Capital Raising & Specialty
- Funds & Public Offerings 
- Holdings & Markets**.

### **1\. Operating Companies**

| Subcategory (FormGroups) | Nested Enum & Case | Title (title) | EDGAR Code (formCode) |
| :---- | :---- | :---- | :---- |
| **Annual & Quarterly Reports** | AnnualAndQuarterly.annualReports | Annual reports | 10-K |
|  | AnnualAndQuarterly.quarterlyReports | Quarterly reports | 10-Q |
|  | AnnualAndQuarterly.foreignAnnual | Foreign annual | 20-F |
|  | AnnualAndQuarterly.canadianAnnual | Canadian annual | 40-F |
| **Material Events & Disclosures** | MaterialEvents.currentReports | Current reports | 8-K |
|  | MaterialEvents.foreignCurrent | Foreign current | 6-K |
|  | MaterialEvents.regAEvents | Reg A events | 1-U |
|  | MaterialEvents.earningsResults | Earnings results | 8-K, ITEM 2.02 |
|  | MaterialEvents.pressReleasesAndRegFD | Press releases \+ Reg FD | EX 99 |
|  | MaterialEvents.materialContracts | Material contracts | EX 10 |
|  | MaterialEvents.insiderTradePolicies | Insider trade policies | EX 19 |
| **Proxy & Shareholder Voting** | ProxyAndShareholder.proxyStatements | Proxy statements | DEF 14A |
|  | ProxyAndShareholder.preliminary | Preliminary | PRE 14A |
|  | ProxyAndShareholder.additional | Additional | DEFA14A |
|  | ProxyAndShareholder.nonManagementSoliciting | Non-management soliciting | DFAN14A |
|  | ProxyAndShareholder.mergerProxyStatements | Merger proxy statements | DEFM14A |
|  | ProxyAndShareholder.definitiveInfo | Definitive Info | DEF 14C |
|  | ProxyAndShareholder.preliminaryInfo | Preliminary info | PRE 14C |
|  | ProxyAndShareholder.annualReportToSH | Annual report to SH | ARS |
| **Corporate Insiders (Section 16\)** | CorporateInsiders.initialOwnership | Initial ownership | FORM 3 |
|  | CorporateInsiders.insiderTrading | Insider Trading | FORM 4 |
|  | CorporateInsiders.annualDeferred | Annual deferred | FORM 5 |
|  | CorporateInsiders.restrictedSales | Restricted sales | FORM 144 |

### **2\. Capital Raising & Specialty**

| Subcategory (FormGroups) | Nested Enum & Case | Title (title) | EDGAR Code (formCode) |
| :---- | :---- | :---- | :---- |
| **Prospectuses (424 Series)** | Prospectuses.structuredProducts | Structured products | 424B2 |
|  | Prospectuses.finalIPO | Final IPO | 424B4 |
|  | Prospectuses.freeWriting | Free writing | FWP |
|  | Prospectuses.prospectusSupplements | Prospectus supplements | 424B3 |
|  | Prospectuses.shelfSupplements | Shelf supplements | 424B5 |
|  | Prospectuses.maCommunications | M\&A communications | 425 |
| **Exempt Offerings** | ExemptOfferings.regDPrivate | Reg D private | FORM D |
|  | ExemptOfferings.regAAnnual | Reg A annual | 1-K |
|  | ExemptOfferings.crowdfunding | Crowdfunding | FORM C |
|  | ExemptOfferings.regAOfferings | Reg A offerings | 1-A |
|  | ExemptOfferings.regASemiAnnual | Reg A semi-annual | 1-SA |
|  | ExemptOfferings.fundingPortals | Funding portals | CFPORTAL |
| **Asset-Backed Securities** | AssetBackedSecurities.standardABSRegistration | Standard ABS registration | SF-1 |
|  | AssetBackedSecurities.distributionReports | Distribution reports | 10-D |
|  | AssetBackedSecurities.repsAndWarranties | Reps & warranties | ABS-15G |
|  | AssetBackedSecurities.shelfABSRegistration | Shelf ABS registration | SF-3 |
|  | AssetBackedSecurities.assetLevelData | Asset-level data | ABS-EE |
| **Tender Offers & Going Private** | TenderOffersAndGoingPrivate.preCommencementComms | Pre-commencement comms | SC TO-C |
|  | TenderOffersAndGoingPrivate.issuerSelfTender | Issuer self-tender | SC TO-I |
|  | TenderOffersAndGoingPrivate.goingPrivate | Going private | SC 13E3 |
|  | TenderOffersAndGoingPrivate.thirdParty | Third-party | SC TO-T |
|  | TenderOffersAndGoingPrivate.targetResponse | Target response | SC 14D9 |
|  | TenderOffersAndGoingPrivate.crossBorderTransactions | Cross-border transactions | CB |
| **Confidential Submissions** | ConfidentialSubmissions.draftRegistrations | Draft registrations | DRS |
|  | ConfidentialSubmissions.draftRegA | Draft Reg A | DOS |

### **3\. Funds & Public Offerings**

| Subcategory (FormGroups) | Nested Enum & Case | Title (title) | EDGAR Code (formCode) |
| :---- | :---- | :---- | :---- |
| **Business Development Cos** | BusinessDevelopment.bdcElection | BDC election | N-54A |
|  | BusinessDevelopment.bdcAutoShelf | BDC auto shelf | N-2ASR |
|  | BusinessDevelopment.bdcRegistration | BDC registration | N-2 |
| **Fund Prospectuses & Supplements** | FundProspectuses.fundProspectus | Fund prospectus | 497 |
|  | FundProspectuses.variableInitialSummary | Variable initial summary | 497VPI |
|  | FundProspectuses.postEffectiveDelayed | Post-effective (delayed) | 485APOS |
|  | FundProspectuses.summaryProspectus | Summary prospectus | 497K |
|  | FundProspectuses.variableUpdatingSummary | Variable updating summary | 497VPU |
|  | FundProspectuses.postEffectiveImmediate | Post-effective (immediate) | 485BPOS |
| **Public Offerings — Domestic** | PublicOfferingsDomestic.iposAndRegistration | IPOs & registration | S-1 |
|  | PublicOfferingsDomestic.businessCombinationsDomestic | Business combinations | S-4 |
|  | PublicOfferingsDomestic.reits | REITs | S-11 |
|  | PublicOfferingsDomestic.shelfRegistrations | Shelf registrations | S-3 |
|  | PublicOfferingsDomestic.employeePlans | Employee plans | S-8 |
| **Fund Reports** | FundReports.annualCensus | Annual census | N-CEN |
|  | FundReports.semiAnnualShareholderReports | Semi-annual shareholder reports | N-CSRS |
|  | FundReports.proxyVoting | Proxy voting | N-PX |
|  | FundReports.shareholderReports | Shareholder reports | N-CSR |
|  | FundReports.moneyMarketEvents | Money market events | N-CR |
|  | FundReports.variableProducts | Variable products | N-VP |
| **Fund Operations** | FundOperations.securitiesSold | Securities sold | 24F-2NT |
|  | FundOperations.deregistration | Deregistration | N-8F |
|  | FundOperations.repurchaseOffers | Repurchase offers | N-23C |
|  | FundOperations.exemptiveApps | Exemptive apps | 40-APP |
| **Public Offerings — Foreign** | PublicOfferingsForeign.foreignRegistration | Foreign registration | F-1 |
|  | PublicOfferingsForeign.foreignCombinations | Foreign combinations | F-4 |
|  | PublicOfferingsForeign.rightsOffering | Rights offering | F-7 |
|  | PublicOfferingsForeign.mjdsRegistration | MJDS registration | F-10 |
|  | PublicOfferingsForeign.foreignShelf | Foreign shelf | F-3 |
|  | PublicOfferingsForeign.adrs | ADRs | F-6 |
|  | PublicOfferingsForeign.businessCombinationForeign | Business combination | F-8 |
|  | PublicOfferingsForeign.mjdsExchangeTender | MJDS exchange/tender | F-80 |

### **4\. Holdings & Markets**

| Subcategory (FormGroups) | Nested Enum & Case | Title (title) | EDGAR Code (formCode) |
| :---- | :---- | :---- | :---- |
| **Institutional Holdings** | InstitutionalHoldings.portfolioHoldings | Portfolio holdings | 13F-HR |
|  | InstitutionalHoldings.coverPages | Cover pages | 13F-HR |
| **Broker-Dealers & Market Infrastructure** | BrokerDealersAndMarket.bdAnnualReports | BD annual reports | X-17A-5 |
|  | BrokerDealersAndMarket.transferAgentRpt | Transfer agent rpt | TA-2 |
|  | BrokerDealersAndMarket.altTradingSystems | Alt trading systems | ATS-N |
|  | BrokerDealersAndMarket.swapDealers | Swap dealers | SBSE |
|  | BrokerDealersAndMarket.transferAgentReg | Transfer agent reg | TA-1 |
|  | BrokerDealersAndMarket.municipalAdvisors | Municipal advisors | MA |
|  | BrokerDealersAndMarket.ratingAgencies | Rating agencies | NRSRO-CE |
| **Fund Registration & Holdings** | FundRegistrationAndHoldings.mutualFundsAndETFs | Mutual funds & ETFs | N-1A |
|  | FundRegistrationAndHoldings.fundPortfolioHoldings | Portfolio holdings | N-PORT |
|  | FundRegistrationAndHoldings.separateAccount | Separate account | N-3 |
|  | FundRegistrationAndHoldings.variableLifeInsurance | Variable life insurance | N-6 |
|  | FundRegistrationAndHoldings.closedEndAndBDCs | Closed-end & BDCs | N-2 |
|  | FundRegistrationAndHoldings.moneyMarketFundPortfolioReports | Money market fund portfolio reports | N-MFP |
|  | FundRegistrationAndHoldings.variableAnnuity | Variable annuity | N-4 |
|  | FundRegistrationAndHoldings.fundMergers | Fund mergers | N-14 |
| **Beneficial Ownership (5%+)** | BeneficialOwnership.activeActivist | Active / activist | 13D |
|  | BeneficialOwnership.passiveInstitutional | Passive / institutional | 13G |
| **SEC Administrative** | SECAdministrative.commentLetters | Comment letters | CORRESP / LETTER |
|  | SECAdministrative.confidentialTreatmentOrders | Confidential treatment orders | CT ORDER |
|  | SECAdministrative.effectiveness | Effectiveness | EFFECT |

## **API Reference**

### **SECReport**

> * static var allCases: \[SECReport\] — Flattened array of all 106 report cases across all 20 nested category enums.  
> * var title: String — Concise, human-readable label for UI display (e.g., "Merger proxy statements").  
> * var formCode: String — Official SEC EDGAR form or exhibit identifier (e.g., "DEFM14A", "EX 10").  
> * var subCategoryTitle: String — Display name of the immediate functional group (e.g., "Proxy & Shareholder Voting").  
> * var mainCategoryTitle: String — Display name of the top-level market pillar (e.g., "Operating Companies").

### SECReport.FormGroup

> * static var allCases: \[SECReport.FormGroups\] — All 20 functional filing groups.  
> * var title: String — Display name of the group, matching SECReport.subCategoryTitle.  
> * var forms: \[SECReport\] — All SECReport cases belonging to the group.

## **Author & License**

Created by **Javaad Ali**. Copyright © 2026 Javaad Ali. All rights reserved.
