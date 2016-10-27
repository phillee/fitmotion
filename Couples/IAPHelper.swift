import StoreKit

/// Notification that is generated when a product is purchased.
public let IAPHelperProductPurchasedNotification = "IAPHelperProductPurchasedNotification"

/// Product identifiers are unique strings registered on the app store.
public typealias ProductIdentifier = String

/// Completion handler called when products are fetched.
public typealias RequestProductsCompletionHandler = (_ success: Bool, _ products: [SKProduct]) -> ()


/// A Helper class for In-App-Purchases, it can fetch products, tell you if a product has been purchased,
/// purchase products, and restore purchases.  Uses NSUserDefaults to cache if a product has been purchased.
open class IAPHelper : NSObject  {
    /// MARK: - User facing API

    /// MARK: - Private Properties

    // Used to keep track of the possible products and which ones have been purchased.
    fileprivate let productIdentifiers: Set<ProductIdentifier>
    fileprivate var purchasedProductIdentifiers = Set<ProductIdentifier>()

    // Used by SKProductsRequestDelegate
    fileprivate var productsRequest: SKProductsRequest?
    fileprivate var completionHandler: RequestProductsCompletionHandler?

    /// Initialize the helper.  Pass in the set of ProductIdentifiers supported by the app.
    public init(productIdentifiers: Set<ProductIdentifier>) {
        self.productIdentifiers = productIdentifiers
        super.init()
    }

    /// Gets the list of SKProducts from the Apple server calls the handler with the list of products.
    open func requestProductsWithCompletionHandler(_ handler: @escaping RequestProductsCompletionHandler) {
        handler(false, [])
        completionHandler = handler
        productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers)
        productsRequest?.delegate = self
        productsRequest?.start()
    }

    /// Initiates purchase of a product.
    open func purchaseProduct(_ product: SKProduct) {
    }

    /// Given the product identifier, returns true if that product has been purchased.
    open func isProductPurchased(_ productIdentifier: ProductIdentifier) -> Bool {
        return false
    }

    /// If the state of whether purchases have been made is lost  (e.g. the
    /// user deletes and reinstalls the app) this will recover the purchases.
    open func restoreCompletedTransactions() {
    }
}

// MARK: - SKProductsRequestDelegate

extension IAPHelper: SKProductsRequestDelegate {
    public func productsRequest(_ request: SKProductsRequest!, didReceive response: SKProductsResponse!) {
        print("Loaded list of products...")
        let products = response.products 
        completionHandler?(true, products)
        clearRequest()

        // debug printing
        for p in products {
            print("Found product: \(p.productIdentifier) \(p.localizedTitle) \(p.price.floatValue)")
        }
    }

    public func request(_ request: SKRequest!, didFailWithError error: Error) {
        print("Failed to load list of products.")
        print("Error: \(error)")
        clearRequest()
    }

    fileprivate func clearRequest() {
        productsRequest = nil
        completionHandler = nil
    }
}
