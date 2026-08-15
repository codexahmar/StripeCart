import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../app/components/custom_snackbar.dart';
import '../utils/constants.dart';

class StripeService {
  StripeService._();
  static final StripeService instance = StripeService._();

  bool _isStripeInitialized = false;

  /// Initialize Stripe with the publishable key loaded from .env
  Future<void> initStripe() async {
    final pubKey = Constants.stripePublishableKey;
    if (pubKey.isNotEmpty && !_isStripeInitialized) {
      Stripe.publishableKey = pubKey;
      Stripe.merchantIdentifier = 'merchant.flutter.stripecart';
      await Stripe.instance.applySettings();
      _isStripeInitialized = true;
      debugPrint("Stripe initialized with key from .env: ${pubKey.substring(0, pubKey.length > 8 ? 8 : pubKey.length)}...");
    }
  }

  /// Entry point to make a payment. Returns true if successful, false otherwise.
  Future<bool> makePayment({
    required num amount,
    required String currency,
    required BuildContext context,
  }) async {
    final secretKey = Constants.stripeSecretKey;
    final pubKey = Constants.stripePublishableKey;

    // If keys are empty in .env, simulate successful demo payment for video showcase
    if (secretKey.isEmpty || pubKey.isEmpty) {
      debugPrint("Demo mode: Keys not found in .env, simulating Stripe Payment Sheet");
      await Future.delayed(const Duration(milliseconds: 800));
      handlePaymentSuccess();
      return true;
    }

    try {
      await initStripe();

      debugPrint("Stripe Step 1: Creating PaymentIntent for amount: $amount $currency...");
      final clientSecret = await createPaymentIntent(amount, currency);
      if (clientSecret == null) {
        throw Exception("Failed to retrieve client_secret from Stripe server");
      }
      debugPrint("Stripe Step 2: Client Secret created: ${clientSecret.substring(0, clientSecret.length > 12 ? 12 : clientSecret.length)}...");

      debugPrint("Stripe Step 3: Initializing PaymentSheet...");
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'StripeCart Luxury Drops',
          style: ThemeMode.system,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Color(0xFF6366F1),
            ),
          ),
        ),
      );

      debugPrint("Stripe Step 4: Presenting PaymentSheet...");
      await Stripe.instance.presentPaymentSheet();

      debugPrint("Stripe Step 5: PaymentSheet completed successfully!");
      handlePaymentSuccess();
      return true;
    } on StripeException catch (e) {
      debugPrint("StripeException: ${e.error.localizedMessage} (code: ${e.error.code})");
      if (e.error.code != FailureCode.Canceled) {
        handlePaymentError(e);
      } else {
        debugPrint("Payment was cancelled by the user.");
      }
      return false;
    } catch (e, stackTrace) {
      debugPrint("Payment Error: $e\n$stackTrace");
      handlePaymentError(e);
      return false;
    }
  }

  /// Create a payment intent and return the client secret
  Future<String?> createPaymentIntent(num amount, String currency) async {
    try {
      final Dio dio = Dio();
      final secretKey = Constants.stripeSecretKey;

      final Map<String, dynamic> data = {
        'amount': calculateAmount(amount),
        'currency': currency.toLowerCase(),
        'automatic_payment_methods[enabled]': 'true',
      };

      final response = await dio.post(
        'https://api.stripe.com/v1/payment_intents',
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            'Authorization': 'Bearer $secretKey',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      if (response.data != null && response.data['client_secret'] != null) {
        debugPrint('Payment Intent Created: ${response.data['id']}');
        return response.data['client_secret'] as String;
      }

      return null;
    } catch (e) {
      debugPrint('Error creating PaymentIntent on Stripe: $e');
      return null;
    }
  }

  /// Convert amount in dollars to cents
  String calculateAmount(num amount) {
    final amountInCents = (amount * 100).round();
    return amountInCents.toString();
  }

  /// Handle successful payment
  void handlePaymentSuccess() {
    debugPrint("Payment successful!");
    CustomSnackBar.showCustomSnackBar(
      title: 'Payment Successful! 🎉',
      message: 'Thank you for your purchase. Order confirmed.',
    );
  }

  /// Handle payment failure or error
  void handlePaymentError(dynamic error) {
    if (error is StripeException) {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Payment Incomplete',
        message: error.error.localizedMessage ?? 'Transaction was not completed.',
      );
    } else {
      CustomSnackBar.showCustomErrorSnackBar(
        title: 'Payment Notice',
        message: 'Could not process transaction. Please verify Stripe keys.',
      );
    }
  }
}
