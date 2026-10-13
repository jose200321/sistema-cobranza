<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso al Sistema - Conciliación Transaccional</title>

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

    <%
        Boolean bloqueado = (Boolean) request.getAttribute("bloqueado");
        if (bloqueado != null && bloqueado) {
    %>
    <script>
        alert("ALERTA DE SEGURIDAD: Usuario bloqueado por exceder 3 intentos erróneos. La ventana se cerrará.");
        window.open('', '_self', '');
        window.close();
    </script>
    <% } %>
</head>
<body class="bg-gradient-to-br from-brand-900 via-slate-900 to-brand-800 min-h-screen flex items-center justify-center p-4">

    <div class="w-full max-w-md bg-white rounded-2xl shadow-2xl border border-slate-100 overflow-hidden">
        
        <!-- Encabezado -->
        <div class="bg-slate-50 border-b border-slate-100 p-6 text-center">
            <span class="inline-block bg-sky-100 text-sky-800 text-xs font-semibold px-3 py-1 rounded-full uppercase tracking-wider mb-2">
                Login
            </span>
            <h1 class="text-xl font-bold text-slate-800">Sistema de Conciliación</h1>
            <p class="text-xs text-slate-500 mt-1">Cuentas por Cobrar &middot; Distribuidora Comercial</p>
        </div>

        <!-- Contenido / Formulario -->
        <div class="p-6 sm:p-8">

            <% 
                String error = (String) request.getAttribute("error");
                if (error != null) { 
            %>
                <div class="mb-5 flex items-start gap-3 bg-red-50 border border-red-200 text-red-700 p-3.5 rounded-xl text-xs sm:text-sm">
                    <svg class="w-5 h-5 flex-shrink-0 text-red-500 mt-0.5" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd"/>
                    </svg>
                    <span class="font-medium"><%= error %></span>
                </div>
            <% } %>

            <form action="${pageContext.request.contextPath}/LoginServlet" method="POST" autocomplete="off" class="space-y-5">
                
                <!-- Campo Usuario -->
                <div>
                    <label for="username" class="block text-xs font-semibold uppercase tracking-wider text-slate-700 mb-1.5">
                        Usuario
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"/>
                            </svg>
                        </div>
                        <input type="text" id="username" name="username" required autofocus
                               placeholder="Ej. admin"
                               class="w-full pl-10 pr-4 py-2.5 text-sm bg-slate-50 border border-slate-300 rounded-lg text-slate-900 placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-sky-500 focus:border-sky-500 focus:bg-white transition duration-150">
                    </div>
                </div>

                <!-- Campo Contraseña -->
                <div>
                    <label for="password" class="block text-xs font-semibold uppercase tracking-wider text-slate-700 mb-1.5">
                        Contraseña
                    </label>
                    <div class="relative">
                        <div class="absolute inset-y-0 left-0 pl-3.5 flex items-center pointer-events-none text-slate-400">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"/>
                            </svg>
                        </div>
                        <input type="password" id="password" name="password" required
                               placeholder="••••••••"
                               class="w-full pl-10 pr-10 py-2.5 text-sm bg-slate-50 border border-slate-300 rounded-lg text-slate-900 placeholder-slate-400 focus:outline-none focus:ring-2 focus:ring-sky-500 focus:border-sky-500 focus:bg-white transition duration-150">
                        <button type="button" onclick="togglePasswordVisibility()" title="Mostrar contraseña"
                                class="absolute inset-y-0 right-0 pr-3 flex items-center text-slate-400 hover:text-slate-600 focus:outline-none">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"/>
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"/>
                            </svg>
                        </button>
                    </div>
                </div>

                <!-- Botón de Ingreso -->
                <button type="submit"
                        class="w-full py-2.5 px-4 bg-sky-600 hover:bg-sky-700 active:bg-sky-800 text-white font-medium text-sm rounded-lg shadow-md hover:shadow-lg transition duration-150 focus:outline-none focus:ring-2 focus:ring-sky-400 focus:ring-offset-1">
                    Ingresar
                </button>
            </form>

            <!-- Pie de tarjeta -->
            <div class="mt-6 pt-4 border-t border-slate-100 text-center text-xs text-slate-400">
                Iniciar Sesion &middot; Máximo 3 intentos
            </div>
        </div>
    </div>

    <script>
        function togglePasswordVisibility() {
            const passInput = document.getElementById("password");
            passInput.type = passInput.type === "password" ? "text" : "password";
        }
    </script>
</body>
</html>