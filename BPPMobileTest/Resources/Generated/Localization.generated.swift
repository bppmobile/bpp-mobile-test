// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// swiftlint:disable explicit_type_interface identifier_name line_length nesting type_body_length type_name
enum Localization {
  /// Enviar
  static let loginButtonTitle = Localization.tr("Localizable", "login_button_title")
  /// E-mail
  static let loginEmailTextfieldPlaceholder = Localization.tr("Localizable", "login_email_textfield_placeholder")
  /// E-mail e/ou senha inválidos
  static let loginErrorInvalidEmailOrPasswordMessage = Localization.tr("Localizable", "login_error_invalid_email_or_password_message")
  /// E-mail em formato inválido
  static let loginErrorInvalidFormattedEmail = Localization.tr("Localizable", "login_error_invalid_formatted_email")
  /// Senha
  static let loginPasswordTextfieldPlaceholder = Localization.tr("Localizable", "login_password_textfield_placeholder")
}
// swiftlint:enable explicit_type_interface identifier_name line_length nesting type_body_length type_name

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
