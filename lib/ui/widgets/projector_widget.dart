import 'package:flutter/material.dart';

class ProjectorWidget extends StatelessWidget {
  const ProjectorWidget({
    required this.child,
    this.designWidth = 412,
    this.designHeight = 892,
    super.key,
  });

  final Widget child;
  final double designWidth;
  final double designHeight;

  @override
  Widget build(BuildContext context) {
    // Aqui solo presumiremos un poco sobre adaptabilidad desde nuestro Jr 😊
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double screenWidth = constraints.maxWidth;
        final double screenHeight = constraints.maxHeight;

        // Calculamos la relacion de aspecto para generar la escala
        // En teoria deberiamos ahora poder trabajar unidades absolutas
        // sin tener que preocuparnos por los tamaños de los elementos
        // simplemente les pasaremos los del figma 😊 Espero salga bien...
        // Ahora si lo tenemos listo
        final double aspectRatio = designWidth / designHeight;
        double widthScale = screenWidth;
        double heightScale = widthScale / aspectRatio;

        if (heightScale > screenHeight) {
          heightScale = screenHeight;
          widthScale = heightScale * aspectRatio;
        }

        return Center(
          child: SizedBox(
            width: widthScale,
            height: heightScale,
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: FittedBox(
                child: SizedBox(
                  width: designWidth,
                  height: designHeight,
                  child: child,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
