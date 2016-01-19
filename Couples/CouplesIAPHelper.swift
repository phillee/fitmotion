import Foundation

// Use enum as a simple namespace.  (It has no cases so you can't instantiate it.)
public enum CouplesProducts {

    /// TODO:  Change this to whatever you set on iTunes connect
    private static let Prefix = ""

    /// MARK: - Supported Product Identifiers
    public static let Strength = Prefix + "strength"

    // All of the products assembled into a set of product identifiers.
    private static let productIdentifiers: Set<ProductIdentifier> = [CouplesProducts.Strength]

    /// Static instance of IAPHelper that for rage products.
    public static let store = IAPHelper(productIdentifiers: CouplesProducts.productIdentifiers)
}

/// Return the resourcename for the product identifier.
func resourceNameForProductIdentifier(productIdentifier: String) -> String? {
    return productIdentifier.componentsSeparatedByString(".").last
}