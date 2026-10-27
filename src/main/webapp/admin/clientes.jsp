<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Clientes - Sistema de Cobranzas</title>

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
            <p class="text-xs text-slate-400">Módulo de Clientes</p>
        </div>
        <div class="flex items-center gap-4">
            <a href="${pageContext.request.contextPath}/main.jsp" 
               class="text-xs bg-slate-700 hover:bg-slate-600 text-white px-3 py-1.5 rounded-lg font-medium transition duration-150">
                Panel Principal
            </a>
            <a href="${pageContext.request.contextPath}/login.jsp" 
               class="text-xs bg-red-600 hover:bg-red-700 text-white px-3 py-1.5 rounded-lg font-medium transition duration-150">
                Salir
            </a>
        </div>
    </header>

    <!-- Contenedor Principal -->
    <main class="max-w-6xl mx-auto p-6 sm:p-8">
        <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-200">
            
            <div class="flex justify-between items-center mb-6">
                <div>
                    <h2 class="text-xl font-bold text-slate-900">Listado de Clientes</h2>
                    <p class="text-xs text-slate-500 mt-1">Administra la base de datos de clientes registrados.</p>
                </div>
                <a href="${pageContext.request.contextPath}/clientes?accion=nuevo" 
                   class="bg-sky-600 hover:bg-sky-700 text-white text-xs px-4 py-2 rounded-lg font-medium transition duration-150 shadow-sm">
                    Nuevo Cliente
                </a>
            </div>

            <!-- Tabla de Clientes -->
            <div class="overflow-x-auto border border-slate-200 rounded-lg">
                <table class="w-full text-left border-collapse text-xs">
                    <thead>
                        <tr class="bg-slate-100 text-slate-700 uppercase font-semibold">
                            <th class="p-3">ID</th>
                            <th class="p-3">Tipo Doc</th>
                            <th class="p-3">Nro Documento</th>
                            <th class="p-3">Razón Social / Nombre</th>
                            <th class="p-3">Dirección</th>
                            <th class="p-3">Teléfono</th>
                            <th class="p-3">Email</th>
                            <th class="p-3 text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-200">
                        <c:choose>
                            <c:when test="${not empty clientes}">
                                <c:forEach var="c" items="${clientes}">
                                    <tr class="hover:bg-slate-50 transition duration-150">
                                        <td class="p-3 font-medium text-slate-900">${c.idCliente}</td>
                                        <td class="p-3">${c.tipoDocumento}</td>
                                        <td class="p-3">${c.numeroDocumento}</td>
                                        <td class="p-3 font-medium text-slate-900">${c.razonSocial}</td>
                                        <td class="p-3 text-slate-600">${c.direccion}</td>
                                        <td class="p-3 text-slate-600">${c.telefono}</td>
                                        <td class="p-3 text-slate-600">${c.email}</td>
                                        <td class="p-3 text-center space-x-2">
                                            <a href="${pageContext.request.contextPath}/clientes?accion=editar&id=${c.idCliente}" 
                                               class="text-amber-600 hover:text-amber-800 font-medium">Editar</a>
                                            <a href="${pageContext.request.contextPath}/clientes?accion=eliminar&id=${c.idCliente}" 
                                               onclick="return confirm('¿Estás seguro de eliminar este cliente?');"
                                               class="text-red-600 hover:text-red-800 font-medium">Eliminar</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="8" class="p-4 text-center text-slate-500">No hay clientes registrados en el sistema.</td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

        </div>
    </main>

</body>
</html>