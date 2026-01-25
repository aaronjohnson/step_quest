import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'supporter_service.dart';

/// Handles In-App Purchase functionality for tip jar.
class IAPService {
  static final IAPService _instance = IAPService._internal();
  factory IAPService() => _instance;
  IAPService._internal();

  final InAppPurchase _iap = InAppPurchase.instance;
  final SupporterService _supporterService = SupporterService();

  StreamSubscription<List<PurchaseDetails>>? _subscription;
  List<ProductDetails> _products = [];
  bool _isAvailable = false;
  bool _isInitialized = false;

  /// Product IDs matching Google Play Console
  static const Set<String> _productIds = {
    'tip_coffee',
    'tip_guild',
    'tip_dragon',
  };

  /// Stream controller for purchase updates
  final _purchaseController = StreamController<PurchaseUpdate>.broadcast();
  Stream<PurchaseUpdate> get purchaseUpdates => _purchaseController.stream;

  /// Whether IAP is available on this device
  bool get isAvailable => _isAvailable;

  /// Available products with pricing
  List<ProductDetails> get products => _products;

  /// Initialize the IAP service
  Future<void> initialize() async {
    if (_isInitialized) return;

    _isAvailable = await _iap.isAvailable();
    if (!_isAvailable) {
      debugPrint('IAP: Store not available');
      _isInitialized = true;
      return;
    }

    // Listen for purchase updates
    _subscription = _iap.purchaseStream.listen(
      _handlePurchaseUpdates,
      onDone: () => _subscription?.cancel(),
      onError: (error) => debugPrint('IAP: Purchase stream error: $error'),
    );

    // Load products
    await _loadProducts();
    _isInitialized = true;
  }

  /// Load product details from the store
  Future<void> _loadProducts() async {
    try {
      final response = await _iap.queryProductDetails(_productIds);

      if (response.error != null) {
        debugPrint('IAP: Error loading products: ${response.error}');
        return;
      }

      if (response.notFoundIDs.isNotEmpty) {
        debugPrint('IAP: Products not found: ${response.notFoundIDs}');
      }

      _products = response.productDetails;
      debugPrint('IAP: Loaded ${_products.length} products');

      // Update supporter service with localized prices
      for (final product in _products) {
        final tierKey = _getTierKeyFromProductId(product.id);
        if (tierKey != null && SupporterService.tiers.containsKey(tierKey)) {
          SupporterService.tiers[tierKey]!.localizedPrice = product.price;
        }
      }
    } catch (e) {
      debugPrint('IAP: Exception loading products: $e');
    }
  }

  /// Handle purchase updates from the store
  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> purchases) async {
    for (final purchase in purchases) {
      debugPrint('IAP: Purchase update - ${purchase.productID}: ${purchase.status}');

      switch (purchase.status) {
        case PurchaseStatus.pending:
          _purchaseController.add(PurchaseUpdate(
            productId: purchase.productID,
            status: PurchaseUpdateStatus.pending,
          ));
          break;

        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          // Verify and complete the purchase
          final valid = await _verifyPurchase(purchase);
          if (valid) {
            await _completePurchase(purchase);
            _purchaseController.add(PurchaseUpdate(
              productId: purchase.productID,
              status: PurchaseUpdateStatus.success,
            ));
          } else {
            _purchaseController.add(PurchaseUpdate(
              productId: purchase.productID,
              status: PurchaseUpdateStatus.error,
              message: 'Verification failed',
            ));
          }
          break;

        case PurchaseStatus.error:
          _purchaseController.add(PurchaseUpdate(
            productId: purchase.productID,
            status: PurchaseUpdateStatus.error,
            message: purchase.error?.message ?? 'Purchase failed',
          ));
          // Complete to remove from queue
          if (purchase.pendingCompletePurchase) {
            await _iap.completePurchase(purchase);
          }
          break;

        case PurchaseStatus.canceled:
          _purchaseController.add(PurchaseUpdate(
            productId: purchase.productID,
            status: PurchaseUpdateStatus.canceled,
          ));
          break;
      }
    }
  }

  /// Verify purchase (for consumables, we trust the store)
  Future<bool> _verifyPurchase(PurchaseDetails purchase) async {
    // For tip jar (consumable), we trust the store's verification
    // In production with server-side verification, you'd validate here
    return purchase.status == PurchaseStatus.purchased ||
        purchase.status == PurchaseStatus.restored;
  }

  /// Complete purchase and update supporter status
  Future<void> _completePurchase(PurchaseDetails purchase) async {
    // Mark as supporter
    final tierKey = _getTierKeyFromProductId(purchase.productID);
    if (tierKey != null) {
      await _supporterService.markAsSupporter(tierKey);
    }

    // Complete the purchase with the store
    if (purchase.pendingCompletePurchase) {
      await _iap.completePurchase(purchase);
    }
  }

  /// Start a purchase
  Future<bool> purchaseProduct(String productId) async {
    if (!_isAvailable) {
      debugPrint('IAP: Store not available');
      return false;
    }

    final product = _products.firstWhere(
      (p) => p.id == productId,
      orElse: () => throw Exception('Product not found: $productId'),
    );

    // Tips are consumable (can buy multiple times)
    final purchaseParam = PurchaseParam(productDetails: product);

    try {
      final success = await _iap.buyConsumable(
        purchaseParam: purchaseParam,
        autoConsume: true,
      );
      return success;
    } catch (e) {
      debugPrint('IAP: Purchase error: $e');
      return false;
    }
  }

  /// Get product by tier key
  ProductDetails? getProductForTier(String tierKey) {
    final productId = SupporterService.tiers[tierKey]?.id;
    if (productId == null) return null;

    try {
      return _products.firstWhere((p) => p.id == productId);
    } catch (_) {
      return null;
    }
  }

  /// Map product ID to tier key
  String? _getTierKeyFromProductId(String productId) {
    for (final entry in SupporterService.tiers.entries) {
      if (entry.value.id == productId) {
        return entry.key;
      }
    }
    return null;
  }

  /// Clean up
  void dispose() {
    _subscription?.cancel();
    _purchaseController.close();
  }
}

/// Purchase update event
class PurchaseUpdate {
  final String productId;
  final PurchaseUpdateStatus status;
  final String? message;

  PurchaseUpdate({
    required this.productId,
    required this.status,
    this.message,
  });
}

enum PurchaseUpdateStatus {
  pending,
  success,
  error,
  canceled,
}
