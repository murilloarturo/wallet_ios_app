// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum LocalizedString {
  /// Coming soon
  public static let comingSoon = LocalizedString.tr("Localizable", "coming_soon", fallback: "Coming soon")
  /// Colombian peso
  public static let copCurrency = LocalizedString.tr("Localizable", "cop_currency", fallback: "Colombian peso")
  /// Euro
  public static let eurCurrency = LocalizedString.tr("Localizable", "eur_currency", fallback: "Euro")
  /// Pound sterling
  public static let gbpCurrency = LocalizedString.tr("Localizable", "gbp_currency", fallback: "Pound sterling")
  /// Ooops... something weird happen.
  public static let genericError = LocalizedString.tr("Localizable", "generic_error", fallback: "Ooops... something weird happen.")
  /// Please try again later.
  public static let genericErrorSubtitle = LocalizedString.tr("Localizable", "generic_error_subtitle", fallback: "Please try again later.")
  /// Localizable.strings
  ///   
  /// 
  ///   Created by Arturo Murillo on 25/5/24.
  public static let homeTitle = LocalizedString.tr("Localizable", "home_title", fallback: "Welcome")
  /// Japanese Yen
  public static let jpyCurrency = LocalizedString.tr("Localizable", "jpy_currency", fallback: "Japanese Yen")
  /// South Korean won
  public static let krwCurrency = LocalizedString.tr("Localizable", "krw_currency", fallback: "South Korean won")
  /// Please wait a moment...
  public static let loading = LocalizedString.tr("Localizable", "loading", fallback: "Please wait a moment...")
  /// We are downloading all your wallets
  public static let loadingSubtitle = LocalizedString.tr("Localizable", "loading_subtitle", fallback: "We are downloading all your wallets")
  /// Products
  public static let productsTab = LocalizedString.tr("Localizable", "products_tab", fallback: "Products")
  /// United States Dollar
  public static let usdCurrency = LocalizedString.tr("Localizable", "usd_currency", fallback: "United States Dollar")
  /// Venezuelan Bolívar
  public static let vefCurrency = LocalizedString.tr("Localizable", "vef_currency", fallback: "Venezuelan Bolívar")
  /// View all
  public static let viewAll = LocalizedString.tr("Localizable", "view_all", fallback: "View all")
  /// View less
  public static let viewLess = LocalizedString.tr("Localizable", "view_less", fallback: "View less")
  /// Home
  public static let walletTab = LocalizedString.tr("Localizable", "wallet_tab", fallback: "Home")
  /// We are currently working in more features to offer the best experience
  public static let workInProgress = LocalizedString.tr("Localizable", "work_in_progress", fallback: "We are currently working in more features to offer the best experience")
  /// Your currencies
  public static let yourCurrencies = LocalizedString.tr("Localizable", "your_currencies", fallback: "Your currencies")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension LocalizedString {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
