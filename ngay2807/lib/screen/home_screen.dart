import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ngay2807/bloc/weather_bloc.dart';
import 'package:ngay2807/bloc/weather_event.dart';
import 'package:ngay2807/bloc/weather_state.dart';
import 'package:ngay2807/routes/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _key = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        backgroundColor: Colors.lightBlueAccent[100],
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Tỉnh/Thành phố',
                        hintText: 'Nhập tên một tỉnh/thành phố',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Hãy nhập tên thành phố';
                        }
                        return null;
                      },
                    ),
                  ),

                  IconButton(
                    onPressed: () => _search(),
                    icon: Icon(Icons.search, size: 48),
                  ),
                ],
              ),

              BlocConsumer<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return const CircularProgressIndicator();
                  }
                  return const SizedBox.shrink();
                },
                listener: (context, state) {
                  if (state is WeatherLoaded) {
                    context.push('/weather', extra: state.weather);
                  } else if (state is WeatherError) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text(state.msg)));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _search() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      final city = _controller.text.trim();
      context.read<WeatherBloc>().add(WeatherFetched(city));
    }
  }
}
