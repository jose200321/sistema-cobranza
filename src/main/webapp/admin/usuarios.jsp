<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Usuarios - Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-slate-50 min-h-screen text-slate-800 font-sans">

    <!-- Navbar -->
    <header class="bg-slate-900 text-white px-6 py-4 flex justify-between items-center shadow-md">
        <div>
            <h1 class="font-bold text-lg">Sistema de Cobranza</h1>
            <p class="text-xs text-slate-400">Panel de Administración</p>
        </div>
        <div class="flex items-center gap-4">
            <a href="${pageContext.request.contextPath}/MainServlet" class="text-xs bg-slate-700 hover:bg-slate-600 text-white px-3 py-1.5 rounded-lg font-medium transition">Volver al Menú</a>
            <a href="${pageContext.request.contextPath}/login.jsp" class="text-xs bg-red-600 hover:bg-red-700 text-white px-3 py-1.5 rounded-lg font-medium transition">Salir</a>
        </div>
    </header>

    <!-- Contenido -->
    <main class="max-w-6xl mx-auto p-6 sm:p-8">
        <h2 class="text-2xl font-bold text-slate-900 mb-6">Gestión de Usuarios</h2>

        <!-- Formulario Registro -->
        <div class="bg-white p-6 rounded-xl shadow-sm border border-slate-200 mb-6">
            <h3 class="text-base font-semibold text-slate-900 mb-4">Registrar Nuevo Usuario</h3>
            <form action="usuarios" method="POST" class="grid grid-cols-1 sm:grid-cols-3 gap-4 items-end">
                <div>
                    <label class="block text-xs font-medium text-slate-600 mb-1">Nombre de Usuario</label>
                    <input type="text" name="nombreUsuario" required class="w-full px-3 py-2 border border-slate-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500">
                </div>
                <div>
                    <label class="block text-xs font-medium text-slate-600 mb-1">Contraseña</label>
                    <input type="password" name="contraseña" required class="w-full px-3 py-2 border border-slate-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500">
                </div>
                <div>
                    <button type="submit" class="w-full bg-emerald-600 hover:bg-emerald-700 text-white text-sm font-medium py-2 px-4 rounded-lg transition duration-150">Guardar Usuario</button>
                </div>
            </form>
        </div>

        <!-- Tabla de Listado -->
        <div class="bg-white rounded-xl shadow-sm border border-slate-200 overflow-hidden">
            <div class="p-4 bg-slate-100 border-b border-slate-200 font-semibold text-sm text-slate-700">Usuarios Registrados</div>
            <div class="overflow-x-auto">
                <table class="w-full text-left border-collapse text-sm">
                    <thead>
                        <tr class="bg-slate-50 border-b border-slate-200 text-slate-600 text-xs uppercase tracking-wider">
                            <th class="p-3">ID</th>
                            <th class="p-3">Usuario</th>
                            <th class="p-3">Intentos Fallidos</th>
                            <th class="p-3">Bloqueado</th>
                            <th class="p-3">Último Acceso</th>
                            <th class="p-3 text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="divide-y divide-slate-200">
                        <c:forEach var="u" items="${usuarios}">
                            <tr class="hover:bg-slate-50">
                                <td class="p-3">${u.idUsuario}</td>
                                <td class="p-3 font-medium text-slate-900">${u.nombreUsuario}</td>
                                <td class="p-3">${u.intentosFallidos}</td>
                                <td class="p-3">
                                    <c:choose>
                                        <c:when test="${u.bloqueado == 1}">
                                            <span class="bg-red-100 text-red-700 text-xs px-2 py-1 rounded-full font-medium">Sí</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="bg-emerald-100 text-emerald-700 text-xs px-2 py-1 rounded-full font-medium">No</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="p-3 text-slate-500 text-xs">${u.ultimoAcceso}</td>
                                <td class="p-3 text-center">
                                    <a href="usuarios?accion=eliminar&id=${u.idUsuario}" onclick="return confirm('¿Estás seguro de eliminar este usuario?');" class="bg-red-50 hover:bg-red-100 text-red-600 text-xs px-3 py-1 rounded-lg font-medium transition">Eliminar</a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

</body>
</html>