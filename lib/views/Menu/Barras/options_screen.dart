import 'package:flutter/material.dart';
import 'package:plan_izi_v2/theme/app_colors.dart';
import 'package:plan_izi_v2/views/Menu/Barras/Suscripciones/emp_primium.dart';
import 'package:plan_izi_v2/views/Menu/Barras/Suscripciones/plu_primium.dart';
import 'package:plan_izi_v2/views/Menu/Barras/Suscripciones/sus_primium.dart';
import 'package:provider/provider.dart';
import 'package:plan_izi_v2/views/Login/estado_usuario.dart';
import 'package:plan_izi_v2/views/Login/login_screen.dart';
import 'package:url_launcher/url_launcher.dart';


class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // estado usuario
    final user = Provider.of<EstadoUsuario>(context).user;

    return SingleChildScrollView(
      child: Container(
        decoration: const BoxDecoration(color: AppColors.cardBackground),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Perfil
              const Center(
                child: Text(
                  'Etiqueta (Estudiante o Labor)',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.background,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: AppColors.cardBackground,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Nombre o correo del usuario
              Center(
                child: Text(
                  user != null
                      ? (user.displayName ?? user.email ?? 'No autenticado')
                      : 'No autenticado',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Center(
                child: Text('No premium',
                    style: TextStyle(color: AppColors.textPrimary)),
              ),
              const Divider(
                height: 30,
                thickness: 5,
                color: AppColors.background,
              ),
              // BOTONES
              _buildListTile(
                context,
                Icons.upgrade,
                'Obtener Suscripción Premium',
                'Sin límites, sin publicidad y más alternativas para tu bienestar sin perder tu tiempo.',
                SusPrimium(),
              ),
              const Divider(
                  height: 30, thickness: 2, color: AppColors.background),
              _buildListTile(
                context,
                Icons.ad_units,
                'Publicidad',
                '¿Deseas publicar contenido de tu tienda o negocio en nuestro aplicativo? ',
                PluPrimium(),
              ),
              const Divider(
                  height: 30, thickness: 2, color: AppColors.background),
              _buildListTile(
                context,
                Icons.business,
                '¿Eres empresario?',
                '¿Necesitas publicidad o un lugar donde ofrecer tus productos? Estás en el lugar perfecto para tu negocio.',
                EmpPrimium(),
              ),
              const Divider(
                  height: 30, thickness: 2, color: AppColors.background),
              const Text('Notificaciones',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ListTile(
                leading: const Icon(Icons.notifications, color: Colors.teal),
                title: const Text('Sonido'),
                trailing: DropdownButton<String>(
                  value: 'Predeterminado',
                  items: const [
                    DropdownMenuItem(
                        value: 'Predeterminado', child: Text('Predeterminado')),
                    DropdownMenuItem(
                        value: 'Silencio', child: Text('Silencio')),
                  ],
                  onChanged: (value) {},
                ),
              ),
              SwitchListTile(
                value: true,
                onChanged: (value) {},
                title: const Text('Vibración'),
                activeColor: Colors.teal,
              ),
              SwitchListTile(
                value: true,
                onChanged: (value) {},
                title: const Text('Notificaciones de tarea '),
                activeColor: Colors.teal,
              ),
              const Divider(
                  height: 30, thickness: 2, color: AppColors.background),
              const FooterSection(),
              const Divider(
                  height: 30, thickness: 2, color: AppColors.background),
              // CERRAR SESIÓN
              ListTile(
                leading:
                    const Icon(Icons.logout, size: 30, color: AppColors.error),
                title: const Text('Cerrar Sesión y salir',
                    style: TextStyle(color: AppColors.error)),
                trailing: const Icon(Icons.arrow_forward_ios,
                    size: 25, color: AppColors.error),
                onTap: () async {
                  try {
                    await context.read<EstadoUsuario>().signOut();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Sesión cerrada exitosamente")),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Error al cerrar sesión')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title,
      String subtitle, Widget nextScreen) {
    return ListTile(
      leading: Icon(icon, color: Colors.teal),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => nextScreen));
      },
    );
  }
}

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {

    final Uri websiteUriF = Uri(scheme: 'https', host: 'www.facebook.com', path: 'people/Planizi-Corporation/61570113523002/' );
    final websiteUriI = Uri.parse('https://www.intagram.com');
    final websiteUriW = Uri.parse('https://planizi.weebly.com');

    return Container(
      color: AppColors.cardBackground,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Acerca de la aplicación',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          _buildOptionButton('Invita amigos a la aplicación'),
          const SizedBox(height: 8),
          _buildOptionButton('Califícanos y comenta'),
          const SizedBox(height: 8),
          _buildOptionButton('¿Necesitas ayuda?'),
          const SizedBox(height: 20),
          const Text('Redes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(Icons.facebook, size: 30, color: Colors.blue),
                onPressed: () {
                    launchUrl(
                      websiteUriF,
                      mode: LaunchMode.externalApplication,
                  );},
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt,
                    size: 30, color: Colors.pink), // Instagram
                onPressed: () {
                  launchUrl(
                    websiteUriI,
                    mode: LaunchMode.externalApplication,
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.public, size: 30, color: Colors.teal),
                onPressed: () {
                  launchUrl(
                    websiteUriW,
                    mode: LaunchMode.inAppWebView,
                  );
                },
              ),
            ],
          ),
          const Divider(
              height: 30, thickness: 2, color: AppColors.cardBackground),
          const Center(
            child: Column(
              children: [
                Icon(Icons.calendar_today, size: 40, color: AppColors.primary),
                SizedBox(height: 5),
                Text(
                  'Versión 1.0a',
                  style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(height: 30, thickness: 2, color: AppColors.background),
        ],
      ),
    );
  }

  Widget _buildOptionButton(String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: AppColors.primary,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
