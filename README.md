# MNEDP
# Métodos de Rayleigh-Ritz y Galerkin para Problemas de Sturm-Liouville
[![Licencia](https://img.shields.io/badge/Licencia-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![MATLAB](https://img.shields.io/badge/MATLAB-R2024a-orange.svg)](https://www.mathworks.com/)

**Autor:** Carlos Yanes Pérez  
**Institución:** Universidad de La Laguna (ULL)  
**Asignatura:** Métodos Numéricos en EDP  
**Fecha:** 2025  
**Práctica:** 4

## Descripción General

Este repositorio contiene scripts y funciones de MATLAB para resolver numéricamente problemas de tipo Sturm-Liouville utilizando los métodos de Rayleigh-Ritz y Galerkin con aproximantes spline. Se implementan espacios de aproximación S1 (splines lineales) y S3 (splines cúbicos) para comparar su eficiencia y precisión.

- **NOTA**: Posiblemente los códigos puedan ser optimizados. En esta implementación me he centrado en la funcionalidad, atendiendo a los plazos marcados.

## Planteamiento del Problema

El código resuelve el siguiente problema de Sturm-Liouville:

```
-d/dx(p(x)du/dx) + q(x)u = f(x)  para x ∈ [a,b]
```

donde:
- p(x) = x²
- q(x) = 6
- f(x) = 6x³

con condiciones de contorno homogéneas en los extremos del intervalo [a,b].

La solución exacta para este problema es:
```
u(x) = 63/31 * x² - 32/(31*x³) - x³
```

## Métodos Numéricos Implementados

Los métodos numéricos implementados son:

1. **Método de Rayleigh-Ritz** (`S3.m`):
   - Utiliza splines cúbicos como funciones de aproximación
   - Espacio de aproximación: S3

2. **Método de Galerkin** (`S1.m`):
   - Utiliza splines lineales como funciones de aproximación
   - Espacio de aproximación: S1

## Descripción de los Archivos

### Archivos Principales
- `practica4.m`: Script principal para ejecutar los métodos. Permite seleccionar entre Rayleigh-Ritz, Galerkin o comparación de ambos.
- `S3.m`: Implementa el método de Rayleigh-Ritz con splines cúbicos.
- `S1.m`: Implementa el método de Galerkin con splines lineales.

### Archivos de Comparación y Análisis
- `comparacion_spline.m`: Compara los resultados de ambos métodos para diferentes valores de n, generando análisis de errores y tiempos de ejecución.
- `error_fun.m`: Calcula el error absoluto entre la solución exacta y la aproximada.

### Archivos de Visualización
- `graficar_aprox_solucion.m`: Grafica la solución exacta vs. la aproximación para un valor específico de n.
- `graficar_comparacion_sol.m`: Genera gráficos comparativos de soluciones para múltiples valores de n.
- `graficar_comparacion_errores.m`: Visualiza la evolución de los errores para diferentes valores de n.
- `tiempos.m`: Grafica la comparación de tiempos de ejecución entre S1 y S3.

### Archivos de Salida
- `tabla_error_n.m`: Muestra una tabla de errores máximos para cada valor de n.
- `escribir_fich.m`: Guarda los errores en un archivo de texto para posterior análisis.

## Uso

1. Ejecutar `practica4.m` en MATLAB:
   ```matlab
   practica4(a, b, part_int)
   ```
   donde:
   - `a`: extremo izquierdo del intervalo (por defecto: 1)
   - `b`: extremo derecho del intervalo (por defecto: 2)
   - `part_int`: número de puntos de evaluación (por defecto: 100)

2. Seleccionar el método deseado:
   - 1: Método de Rayleigh-Ritz (S3)
   - 2: Método de Galerkin (S1)
   - 3: Comparación de ambos métodos

3. Si se elige la opción 3, seleccionar tipo de comparación:
   - 1: Solo Rayleigh-Ritz para diferentes n
   - 2: Solo Galerkin para diferentes n
   - 3: Ambos métodos simultáneamente

## Ejemplo

```matlab
% Ejecutar con parámetros por defecto
practica4()

% Ejecutar con intervalo personalizado
practica4(0.5, 3, 150)

% Para comparar ambos métodos:
% Seleccionar opción 3, luego opción 3
```

## Características Técnicas

### Espacios de Aproximación
- **S1**: Splines lineales continuos que se anulan en los extremos
- **S3**: Splines cúbicos continuos con condiciones de contorno especiales

### Integración Numérica
Los elementos de la matriz masa y el vector del lado derecho se calculan usando integración adaptativa de MATLAB con tolerancias configurables:
- `RelTol`: Tolerancia relativa (por defecto: 0)
- `AbsTol`: Tolerancia absoluta (por defecto: 1e-8)

### Análisis de Convergencia
El programa analiza la convergencia usando diferentes valores de n:
- Lista por defecto: [5, 10, 20, 40]
- Calcula errores máximos para cada n
- Genera gráficos de convergencia

## Resultados

El programa genera:
- Gráficos de las soluciones numéricas vs. solución exacta
- Visualización de los errores en función de x
- Análisis de convergencia para diferentes valores de n
- Comparación de tiempos de ejecución entre métodos
- Tablas de errores máximos
- Archivos de texto con datos de errores

## Estructura de las Funciones Spline

### Splines Lineales (S1)
- `patronB1(t)`: Patrón básico del spline lineal
- `bspline1(n,h,a,x)`: Evaluación de las funciones base
- `dBspline1(n,h,a,x)`: Derivadas de las funciones base

### Splines Cúbicos (S3)
- `patronB3(t)`: Patrón básico del spline cúbico
- `bspline3(n,h,a,x)`: Evaluación con condiciones de contorno
- `dBspline3(n,h,a,x)`: Derivadas con condiciones de contorno

## Conclusiones

Los resultados muestran:
- La eficiencia de ambos métodos para resolver problemas de Sturm-Liouville
- Mayor precisión de los splines cúbicos (S3) a costa de mayor tiempo computacional
- Convergencia mejorada con el aumento del parámetro n
- Trade-off entre precisión y eficiencia computacional

## Licencia

Este proyecto está licenciado bajo la Licencia MIT - consulte el archivo LICENSE para más detalles.
