<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Principal - Conciliación Transaccional</title>

    <!-- Fuente Poppins desde Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">

    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Poppins', 'sans-serif'],
                    },
                    colors: {
                        brand: {
                            800: '#0b2545',
                            900: '#07192e',
                        }
                    }
                }
            }
        }
    </script>
</head>
<body class="bg-slate-50 min-h-screen text-slate-800">

    <!-- Barra de navegación superior -->
    <header class="bg-slate-900 text-white px-6 py-4 flex justify-between items-center shadow-md">
        <div>
            <h1 class="font-bold text-lg">Test</h1>
            <p class="text-xs text-slate-400">POO II</p>
        </div>
        <div class="flex items-center gap-4">
            <span class="text-sm text-slate-300">Usuario: <strong class="text-white"><%= session.getAttribute("usuarioLogueado") %></strong></span>
            <a href="${pageContext.request.contextPath}/login.jsp" 
               class="text-xs bg-red-600 hover:bg-red-700 text-white px-3 py-1.5 rounded-lg font-medium transition duration-150">
                Salir
            </a>
        </div>
    </header>

    <!-- Contenedor Principal -->
    <main class="max-w-5xl mx-auto p-6 sm:p-8">
        <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-200">
            <h2 class="text-xl font-bold text-slate-900 mb-2">Modulo Inicial</h2>
            <p class="text-sm text-slate-600">Main <code class="bg-slate-100 text-sky-700 px-2 py-0.5 rounded font-mono text-xs">/main</code></p>
            <div class="mt-4 p-4 bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs rounded-lg">
                Pagina Principal
            </div>
        </div>
    </main>

</body>
</html>