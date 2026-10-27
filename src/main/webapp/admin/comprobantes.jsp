<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Comprobantes - Sistema de Cobranzas</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans leading-normal tracking-normal">
    <div class="container mx-auto px-4 py-8">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-gray-800">Listado de Comprobantes / Deudas</h1>
            <a href="${pageContext.request.contextPath}/comprobantes?accion=nuevo" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded shadow">Nuevo Comprobante</a>
        </div>
        
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <table class="min-w-full leading-normal">
                <thead>
                    <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
                        <th class="py-3 px-6 text-left">ID</th>
                        <th class="py-3 px-6 text-left">Cliente</th>
                        <th class="py-3 px-6 text-left">Tipo</th>
                        <th class="py-3 px-6 text-left">Nro Comprobante</th>
                        <th class="py-3 px-6 text-left">Emisión</th>
                        <th class="py-3 px-6 text-left">Vencimiento</th>
                        <th class="py-3 px-6 text-right">Monto Total</th>
                        <th class="py-3 px-6 text-center">Estado</th>
                        <th class="py-3 px-6 text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody class="text-gray-600 text-sm font-light">
                    <c:forEach var="c" items="${comprobantes}">
                        <tr class="border-b border-gray-200 hover:bg-gray-100">
                            <td class="py-3 px-6 text-left whitespace-nowrap">${c.idComprobante}</td>
                            <td class="py-3 px-6 text-left font-medium">${c.razonSocialCliente}</td>
                            <td class="py-3 px-6 text-left">${c.tipoComprobante}</td>
                            <td class="py-3 px-6 text-left">${c.numeroComprobante}</td>
                            <td class="py-3 px-6 text-left">${c.fechaEmision}</td>
                            <td class="py-3 px-6 text-left">${c.fechaVencimiento}</td>
                            <td class="py-3 px-6 text-right font-semibold">S/. ${c.montoTotal}</td>
                            <td class="py-3 px-6 text-center">
                                <span class="px-3 py-1 rounded-full text-xs font-semibold 
                                    ${c.estado == 'PAGADO' ? 'bg-green-200 text-green-800' : (c.estado == 'PENDIENTE' ? 'bg-yellow-200 text-yellow-800' : 'bg-red-200 text-red-800')}">
                                    ${c.estado}
                                </span>
                            </td>
                            <td class="py-3 px-6 text-center">
                                <div class="flex item-center justify-center space-x-4">
                                    <a href="${pageContext.request.contextPath}/comprobantes?accion=editar&id=${c.idComprobante}" class="text-yellow-600 hover:text-yellow-900 font-semibold">Editar</a>
                                    <a href="${pageContext.request.contextPath}/comprobantes?accion=eliminar&id=${c.idComprobante}" onclick="return confirm('¿Estás seguro de eliminar este comprobante?');" class="text-red-600 hover:text-red-900 font-semibold">Eliminar</a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>