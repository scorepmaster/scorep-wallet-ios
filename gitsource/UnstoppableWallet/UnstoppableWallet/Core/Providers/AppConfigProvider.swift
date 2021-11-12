import Foundation
import CoinKit

class AppConfigProvider: IAppConfigProvider {
    
    let companyWebPageLink = ""
    let appWebPageLink = ""
    let appGitHubLink = ""
    let telegramAccount = ""
    let twitterAccount = ""
    let facebookAccount = ""
    let linkedinAccount = ""
    let redditAccount = ""
    let reportEmail = ""

    var guidesIndexUrl: URL {
        URL(string: (Bundle.main.object(forInfoDictionaryKey: "GuidesIndexUrl") as! String))!
    }

    var faqIndexUrl: URL {
        URL(string: (Bundle.main.object(forInfoDictionaryKey: "FaqIndexUrl") as! String))!
    }

    var uniswapSubgraphUrl: String {
        (Bundle.main.object(forInfoDictionaryKey: "UniswapGraphUrl") as? String) ?? ""
    }

    var testMode: Bool {
        Bundle.main.object(forInfoDictionaryKey: "TestMode") as? String == "true"
    }

    var officeMode: Bool {
        Bundle.main.object(forInfoDictionaryKey: "OfficeMode") as? String == "true"
    }

    var sandbox: Bool {
        Bundle.main.object(forInfoDictionaryKey: "Sandbox") as? String == "true"
    }

    func defaultWords(count: Int) -> String {
        Bundle.main.object(forInfoDictionaryKey: "DefaultWords\(count)") as? String ?? ""
    }

    var infuraCredentials: (id: String, secret: String?) {
        let id = (Bundle.main.object(forInfoDictionaryKey: "InfuraProjectId") as? String) ?? ""
        let secret = Bundle.main.object(forInfoDictionaryKey: "InfuraProjectSecret") as? String
        return (id: id, secret: secret)
    }

    var btcCoreRpcUrl: String {
        (Bundle.main.object(forInfoDictionaryKey: "BtcCoreRpcUrl") as? String) ?? ""
    }

    var etherscanKey: String {
        (Bundle.main.object(forInfoDictionaryKey: "EtherscanApiKey") as? String) ?? ""
    }

    var bscscanKey: String {
        (Bundle.main.object(forInfoDictionaryKey: "BscscanApiKey") as? String) ?? ""
    }

    var coinMarketCapApiKey: String {
        (Bundle.main.object(forInfoDictionaryKey: "CoinMarketCapKey") as? String) ?? ""
    }

    var cryptoCompareApiKey: String? {
        (Bundle.main.object(forInfoDictionaryKey: "CryptoCompareApiKey") as? String).flatMap { $0.isEmpty ? nil : $0 }
    }

    var pnsUrl: String {
        let development = "https://pns-dev.horizontalsystems.xyz/api/v1/"
        let production = "https://pns-ext.horizontalsystems.xyz/api/v1/"

        return sandbox ? development : production
    }

    let currencyCodes: [String] = ["USD", "EUR", "GBP", "JPY"]
    let feeRateAdjustedForCurrencyCodes: [String] = ["USD", "EUR"]

    var featuredCoinTypes: [CoinType] {
        [
            .erc20(address: "0xc56b7399b7a2bb10db9e303f18ca46ab214bf9a7"),
            //.bep20(address: "0xc05873c48a06982b82bb44bfdb60c196e832dee5"),
            //.bep20(address: "0xb67e5fb0473320ae40b2adf0120a15968ebb0a85"),
            .bitcoin,
            .bitcoinCash,
            .ethereum,
            //.zcash,
            .binanceSmartChain
        ]
    }

    var defaultWords: String {
        Bundle.main.object(forInfoDictionaryKey: "DefaultWords") as? String ?? ""
    }

}




