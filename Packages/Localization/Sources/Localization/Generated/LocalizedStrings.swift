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
  /// Localizable.strings
  ///   
  /// 
  ///   Created by Arturo Murillo on 25/5/24.
  public static let homeTitle = LocalizedString.tr("Localizable", "home_title", fallback: "Welcome")
  /// Products
  public static let productsTab = LocalizedString.tr("Localizable", "products_tab", fallback: "Products")
  /// View all
  public static let viewAll = LocalizedString.tr("Localizable", "view_all", fallback: "View all")
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
