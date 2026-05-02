import 'package:ecommerce_app/core/theme/app_palette.dart';
import 'package:ecommerce_app/features/produits/presentation/providers/cart_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cityController = TextEditingController(text: "Dakar"); // Par défaut

  @override
  void dispose() {
    _addressController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // on écoute le provider du prix total
    final total = ref.watch(cartTotalprovider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails de livraison"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Où devons-nous livrer ?",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Champ Adresse
              _buildInputLabel("Adresse exacte (Rue, Appartement...)"),
              _buildTextField(
                controller: _addressController,
                hint: "ex: Liberté 6, Villa 123",
                icon: Icons.location_on_outlined,
                validator: (v) => v!.isEmpty ? "L'adresse est requise" : null,
              ),

              const SizedBox(height: 20),

              // Champ Téléphone
              _buildInputLabel("Numéro de téléphone (Wave/OM)"),
              _buildTextField(
                controller: _phoneController,
                hint: "77 000 00 00",
                icon: Icons.phone_android_outlined,
                keyboardType: TextInputType.phone,
                validator: (v) => v!.length < 9 ? "Numéro invalide" : null,
              ),

              const SizedBox(height: 20),

              // Champ Ville
              _buildInputLabel("Ville"),
              _buildTextField(
                controller: _cityController,
                hint: "Dakar",
                icon: Icons.apartment_outlined,
              ),

              const SizedBox(height: 40),

              // Récapitulatif rapide
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total à payer",
                      style: TextStyle(color: Colors.grey),
                    ),
                    Text(
                      "$total FCFA",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppPalette.primaryColor, size: 20),
        hintText: hint,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPalette.primaryColor,
          minimumSize: const Size(double.infinity, 55),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            // Ici, on passera à l'étape du choix de paiement (Wave/OM)

            // 1. Petite vibration ou retour visuel
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Adresse enregistrée avec succès !"),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 1),
              ),
            );

            // 2. On attend une fraction de seconde pour l'effet visuel
            Future.delayed(const Duration(milliseconds: 500), () {
              if(mounted){
                 _showPaymentMethodSelector(context);
              }
              
            });
          }
        },
        child: const Text(
          "Continuer vers le paiement",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  // choix payment
  void _showPaymentMethodSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Choisir le mode de paiement",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Option WAVE
              _buildPaymentOption(
                title: "Wave",
                color: Colors.blue.shade400,
                icon: Icons.water_drop, // Simulation du logo Wave
                onTap: () => _processPayment("Wave"),
              ),

              const SizedBox(height: 12),

              // Option ORANGE MONEY
              _buildPaymentOption(
                title: "Orange Money",
                color: Colors.orange.shade700,
                icon: Icons.money, // Simulation du logo OM
                onTap: () => _processPayment("Orange Money"),
              ),
            ],
          ),
        );
      },
    );
  }

  // procédure piement
  Widget _buildPaymentOption({
    required String title,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color,
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  void _processPayment(String method) async {
    Navigator.pop(context); // Ferme le sélecteur

    // Afficher un dialogue de chargement
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // On simule l'attente de l'API (2 secondes)
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    Navigator.pop(context); // Enlever le chargement

    // VIDE LE PANIER (Grâce à Riverpod !)
    ref.read(cartProvider.notifier).viderToutLePanier();

    // Afficher le succès final
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
        content: const Text(
          "Commande validée !\nVotre colis arrivera bientôt à Dakar.",
          textAlign: TextAlign.center,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            child: const Text("Retour à l'accueil"),
          ),
        ],
      ),
    );
  }
}
