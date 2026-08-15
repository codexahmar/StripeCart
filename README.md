<div align="center">

# 🛍️ StripeCart

**A sleek, modern luxury e-commerce mobile application built with Flutter & GetX.**

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
[![GetX](https://img.shields.io/badge/GetX-State%20Management-8A2BE2?style=for-the-badge)](https://pub.dev/packages/get)
[![Stripe](https://img.shields.io/badge/Stripe-Payment%20Gateway-635BFF?style=for-the-badge&logo=stripe&logoColor=white)](https://stripe.com)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

<br/>

<img src="screenshot/stripecart.png" alt="StripeCart App Preview" width="100%" />

</div>

---

## 📖 About

**StripeCart** is an editorial-grade mobile shopping experience engineered for modern e-commerce brands. Designed with a cyber-luxury aesthetic, it features smooth 60fps micro-animations, glassmorphic UI elements, dynamic color/size fitting previews, and a complete end-to-end Stripe PaymentSheet integration.

---

## ✨ Features

- **🎨 Modern Design System**: Deep obsidian dark mode and porcelain light mode with electric indigo (`#6366F1`) and neon pink accents.
- **🏷️ Editorial Home Feed**: Limited-drop promotional banners, instant category filtering, and high-contrast luxury product cards.
- **👕 Interactive Product Details**:
  - Real-time ambient background tinting based on selected color swatches.
  - Interactive size fitting preview that physically scales the product view.
  - Quantity steppers and sticky frosted-glass action bars.
- **💳 Stripe Payment Gateway**: Complete native PaymentSheet integration supporting Apple Pay, Google Pay, and credit/debit cards with local `.env` secret management.
- **🎟️ Promo Code Engine**: Instant discount verification (try code `CODEX20` for 20% off) with real-time order breakdown recalculations.
- **❤️ Wishlist & Activity Center**: Quick-save favorites with "Add All to Bag" batch action, and categorized notification feed.
- **🧭 Frosted Glass Navigation**: Custom blurred backdrop navigation shell with live cart count badges.

---

## 🛠️ Tech Stack

| Technology | Purpose |
| :--- | :--- |
| **[Flutter](https://flutter.dev)** | Cross-platform UI toolkit |
| **[GetX](https://pub.dev/packages/get)** | Reactive state management, dependency injection & routing |
| **[flutter_stripe](https://pub.dev/packages/flutter_stripe)** | Native mobile Stripe PaymentSheet integration |
| **[flutter_screenutil](https://pub.dev/packages/flutter_screenutil)** | Pixel-perfect responsive screen adaptation |
| **[flutter_animate](https://pub.dev/packages/flutter_animate)** | Fluid micro-interactions and transition animations |
| **[flutter_dotenv](https://pub.dev/packages/flutter_dotenv)** | Secure environment variable configuration |
| **[dio](https://pub.dev/packages/dio)** | HTTP networking for Stripe PaymentIntent creation |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (`>= 3.7.2`)
- Xcode (for iOS) & Android Studio (for Android)
- A [Stripe Account](https://dashboard.stripe.com/register) (for test/live API keys)

### 1. Clone the repository
```bash
git clone https://github.com/codexahmar/StripeCart.git
cd StripeCart
```

### 2. Install dependencies
```bash
flutter pub get
```

### 3. Configure Environment Variables
Copy the template `.env.example` file to create your local `.env`:
```bash
cp .env.example .env
```
Open `.env` and add your Stripe API keys:
```env
STRIPE_PUBLISHABLE_KEY=pk_test_your_publishable_key
STRIPE_SECRET_KEY=sk_test_your_secret_key
```
*(Note: If left empty, the app runs in demo simulation mode for testing UI flows without live keys).*

### 4. iOS Setup (CocoaPods)
```bash
cd ios
pod install
cd ..
```

### 5. Run the application
```bash
flutter run
```

---

## 📁 Project Structure

```
lib/
├── app/
│   ├── components/       # Reusable UI widgets (buttons, snackbars, cards, empty states)
│   ├── data/             # Models & local storage (SharedPreferences)
│   ├── modules/          # Feature screens with GetX Controllers & Bindings
│   │   ├── base/         # Frosted glass bottom navigation shell
│   │   ├── cart/         # Shopping bag, promo discounts & Stripe checkout
│   │   ├── favorites/    # Saved drops wishlist
│   │   ├── home/         # Header, search, promo carousel, product feed
│   │   ├── notifications/# Activity & status updates
│   │   ├── product_details/ # Hero showcase, dynamic swatches & size scaling
│   │   ├── settings/     # VIP profile & theme switcher
│   │   └── splash/       # Animated brand intro
│   └── routes/           # Declarative GetX routing table
├── config/
│   └── theme/            # Color palettes, typography & theme definitions
├── services/             # Stripe payment gateway service
└── utils/                # Constants, dummy data & helper utilities
```

---

## 👤 Author

**Ahmaryar Khan (Codex Ahmar)**

- GitHub: [@codexahmar](https://github.com/codexahmar)
- Instagram: [@codexahmar](https://www.instagram.com/codexahmar/)
- LinkedIn: [Ahmaryar Khan](https://www.linkedin.com/in/ahmaryarkhan)
- Email: codexahmar@gmail.com

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
