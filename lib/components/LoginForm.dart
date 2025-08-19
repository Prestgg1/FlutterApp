import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:safatapp/services/auth/authbloc.dart';
import 'package:safatapp/services/auth/authevent.dart';
import 'package:safatapp/services/auth/authstate.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String email = '';
  String password = '';
  bool rememberMe = true;

  void _submit() {
    setState(() => _isLoading = true);
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(AuthLogin(email, password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          context.go('/'); // Login uğurlu → ana səhifəyə yönləndir
        } else if (state is Unauthenticated && state.error != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        }

        setState(() {
          _isLoading = state is AuthInitial || state is Authenticated
              ? false
              : state is Unauthenticated
              ? false
              : _isLoading;
        });
      },
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Example@gmail.com',
                filled: true,
                fillColor: Colors.grey.withAlpha(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) => setState(() => email = value),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email boş ola bilməz';
                } else if (!value.contains('@')) {
                  return 'Email düzgün deyil';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            const Text("Şifre", style: TextStyle(fontWeight: FontWeight.bold)),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'At least 8 characters',
                fillColor: Colors.grey.withAlpha(20),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.red),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Şifrə boş ola bilməz';
                } else if (value.length < 8) {
                  return 'Şifrə ən azı 8 simvol olmalıdır';
                }
                return null;
              },
              onChanged: (value) => setState(() => password = value),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Row(
                    children: [
                      Checkbox(
                        value: rememberMe,
                        onChanged: (value) =>
                            setState(() => rememberMe = value ?? false),
                      ),
                      const Text('Yadda saxla'),
                    ],
                  ),
                ),
                Flexible(
                  child: TextButton(
                    onPressed: () {
                      context.push('/forgot-password');
                    },
                    child: const Text(
                      'Şifrəni unutmusunuz?',
                      style: TextStyle(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text("Daxil ol"),
            ),
          ],
        ),
      ),
    );
  }
}
