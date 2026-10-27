<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panel Principal - Sistema de Cobranzas</title>

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
            <h1 class="font-bold text-lg">Sistema de Cobranzas</h1>
            <p class="text-xs text-slate-400">Panel de Administración</p>
        </div>
        <div class="flex items-center gap-4">
            <span class="text-sm text-slate-300">Usuario: <strong class="text-white"><%= session.getAttribute("usuarioLogueado") != null ? session.getAttribute("usuarioLogueado") : "Administrador" %></strong></span>
            <a href="${pageContext.request.contextPath}/login.jsp" 
               class="text-xs bg-red-600 hover:bg-red-700 text-white px-3 py-1.5 rounded-lg font-medium transition duration-150">
                Salir
            </a>
        </div>
    </header>

    <!-- Contenedor Principal -->
    <main class="max-w-5xl mx-auto p-6 sm:p-8">
        <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-200">
            <h2 class="text-xl font-bold text-slate-900 mb-2">Panel de Control</h2>
            <p class="text-sm text-slate-600">Selecciona el módulo que deseas administrar:</p>
            <div class="mt-4 p-4 bg-emerald-50 border border-emerald-200 text-emerald-800 text-xs rounded-lg">
                Sesión activa correctamente en el sistema
            </div>

            <!-- Accesos a Módulos del Sistema -->
            <div class="mt-6 grid grid-cols-1 sm:grid-cols-3 gap-4">
                <div class="p-4 border border-slate-200 rounded-lg bg-slate-50 flex flex-col justify-between">
                    <div>
                        <h3 class="font-semibold text-slate-900">Gestión de Usuarios</h3>
                        <p class="text-xs text-slate-500 mt-1">Administra los usuarios del sistema, accesos y permisos.</p>
                    </div>
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/usuarios?accion=listar" 
                           class="inline-block bg-sky-600 hover:bg-sky-700 text-white text-xs px-4 py-2 rounded-lg font-medium transition duration-150">
                            Ir al CRUD
                        </a>
                    </div>
                </div>
                <!-- Módulo Clientes -->
                <div class="p-4 border border-slate-200 rounded-lg bg-slate-50 flex flex-col justify-between">
                    <div>
                        <h3 class="font-semibold text-slate-900">Gestión de Clientes</h3>
                        <p class="text-xs text-slate-500 mt-1">Administra la base de datos de clientes, DNI, RUC y contactos.</p>
                    </div>
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/clientes?accion=listar" 
                           class="inline-block bg-sky-600 hover:bg-sky-700 text-white text-xs px-4 py-2 rounded-lg font-medium transition duration-150">
                            Ir a Clientes
                        </a>
                    </div>
                </div>

                <!-- Módulo Comprobantes -->
                <div class="p-4 border border-slate-200 rounded-lg bg-slate-50 flex flex-col justify-between">
                    <div>
                        <h3 class="font-semibold text-slate-900">Comprobantes</h3>
                        <p class="text-xs text-slate-500 mt-1">Gestiona facturas, boletas, notas de venta y estados de deuda.</p>
                    </div>
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/comprobantes?accion=listar" 
                           class="inline-block bg-amber-600 hover:bg-amber-700 text-white text-xs px-4 py-2 rounded-lg font-medium transition duration-150">
                            Ir a Comprobantes
                        </a>
                    </div>
                </div>

                <!-- Módulo Pagos -->
                <div class="p-4 border border-slate-200 rounded-lg bg-slate-50 flex flex-col justify-between">
                    <div>
                        <h3 class="font-semibold text-slate-900">Registro de Pagos</h3>
                        <p class="text-xs text-slate-500 mt-1">Registra abonos, transferencias, Yape/Plin y referencias asociadas.</p>
                    </div>
                    <div class="mt-4">
                        <a href="${pageContext.request.contextPath}/pagos?accion=listar" 
                           class="inline-block bg-emerald-600 hover:bg-emerald-700 text-white text-xs px-4 py-2 rounded-lg font-medium transition duration-150">
                            Ir a Pagos
                        </a>
                    </div>
                </div>

            </div>

        </div>
    </main>

</body>
</html>