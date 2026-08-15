import 'package:flutter/material.dart';
import '../app/data/models/product_model.dart';
import 'constants.dart';

class DummyHelper {
  const DummyHelper._();

  static List<ProductModel> products = [
    ProductModel(
      id: 1,
      image: Constants.product1,
      name: 'Cyber Oversized Tee',
      brand: 'AURA STUDIOS',
      category: 'Streetwear',
      quantity: 0,
      price: 49.99,
      oldPrice: 69.99,
      rating: 4.8,
      reviews: '2.4k reviews',
      size: 'M',
      isFavorite: false,
      tag: 'HOT DROP',
      discountPercent: 28,
      description:
          'Crafted from 280GSM heavyweight Japanese combed cotton with dropped shoulders and a boxy silhouette. Features custom high-density silicone chest branding and pre-shrunk vintage wash.',
      availableColors: [
        const Color(0xFF1E293B), // Midnight
        const Color(0xFF6366F1), // Electric Indigo
        const Color(0xFFE2E8F0), // Off White
      ],
      selectedColor: const Color(0xFF1E293B),
    ),
    ProductModel(
      id: 2,
      image: Constants.product2,
      name: 'Matrix Asymmetric Skirt',
      brand: 'NOVA LABS',
      category: 'Luxury',
      quantity: 0,
      price: 89.99,
      oldPrice: 120.00,
      rating: 4.9,
      reviews: '1.8k reviews',
      size: 'S',
      isFavorite: true,
      tag: 'BEST SELLER',
      discountPercent: 25,
      description:
          'Futuristic technical pleats combined with fluid drape tailoring. Features waterproof matte-coated zip hardware and adjustable modular waist belt with metallic clasp.',
      availableColors: [
        const Color(0xFF0F172A), // Noir
        const Color(0xFFEC4899), // Neon Rose
        const Color(0xFF06B6D4), // Cyan
      ],
      selectedColor: const Color(0xFF0F172A),
    ),
    ProductModel(
      id: 3,
      image: Constants.product3,
      name: 'Titan Knit Sweater',
      brand: 'VERVE PARIS',
      category: 'Hoodies',
      quantity: 0,
      price: 139.99,
      oldPrice: 189.99,
      rating: 4.7,
      reviews: '3.1k reviews',
      size: 'L',
      isFavorite: false,
      tag: 'LIMITED',
      discountPercent: 26,
      description:
          'Ultra-soft Merino wool blend ribbed knit offering supreme thermal comfort. Intricate double-layer collar and textured weave engineered for all-day luxury wear.',
      availableColors: [
        const Color(0xFF334155), // Slate
        const Color(0xFF8B5CF6), // Violet
        const Color(0xFFD97706), // Amber
      ],
      selectedColor: const Color(0xFF334155),
    ),
    ProductModel(
      id: 4,
      image: Constants.product4,
      name: 'Aero Utility Crop Top',
      brand: 'KINETIC NYC',
      category: 'Streetwear',
      quantity: 0,
      price: 54.99,
      oldPrice: 75.00,
      rating: 4.6,
      reviews: '1.5k reviews',
      size: 'M',
      isFavorite: false,
      tag: 'NEW SEASON',
      discountPercent: 27,
      description:
          'Breathable 4-way stretch compression tech fabric with ergonomic seam placement. Seamless underbust support and subtle reflective logo print.',
      availableColors: [
        const Color(0xFF1E1B4B), // Deep Iris
        const Color(0xFF10B981), // Emerald
        const Color(0xFF64748B), // Steel
      ],
      selectedColor: const Color(0xFF1E1B4B),
    ),
    ProductModel(
      id: 5,
      image: Constants.product5,
      name: 'Veloce Minimal Tank',
      brand: 'AURA STUDIOS',
      category: 'Accessories',
      quantity: 0,
      price: 38.99,
      oldPrice: 49.99,
      rating: 4.5,
      reviews: '980 reviews',
      size: 'M',
      isFavorite: false,
      tag: 'POPULAR',
      discountPercent: 22,
      description:
          'Minimalist clean-cut ribbed tank constructed with organic bamboo cotton. Naturally moisture-wicking and exceptionally breathable for warm climates.',
      availableColors: [
        const Color(0xFF0F172A),
        const Color(0xFFF472B6),
        const Color(0xFFFFFFFF),
      ],
      selectedColor: const Color(0xFF0F172A),
    ),
    ProductModel(
      id: 6,
      image: Constants.product1,
      name: 'Hyperion Raw Denim',
      brand: 'TOKYO ARCHIVE',
      category: 'Luxury',
      quantity: 0,
      price: 119.99,
      oldPrice: 159.99,
      rating: 4.9,
      reviews: '4.2k reviews',
      size: 'M',
      isFavorite: false,
      tag: 'HOT DROP',
      discountPercent: 25,
      description:
          '14oz Japanese red selvedge denim, raw untreated indigo finish with custom engraved antique copper hardware and reinforced hidden pocket rivets.',
      availableColors: [
        const Color(0xFF1E3A8A), // Raw Indigo
        const Color(0xFF0F172A), // Washed Black
      ],
      selectedColor: const Color(0xFF1E3A8A),
    ),
  ];
}