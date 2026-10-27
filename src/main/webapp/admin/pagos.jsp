<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Gestión de Pagos - Sistema de Cobranzas</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans leading-normal tracking-normal">
    <div class="container mx-auto px-4 py-8">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-3xl font-bold text-gray-800">Listado de Pagos / Abonos</h1>
            <a href="${pageContext.request.contextPath}/pagos?accion=nuevo" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded shadow">Nuevo Pago</a>
        </div>
        
        <div class="bg-white shadow-md rounded-lg overflow-hidden">
            <table class="min-w-full leading-normal">
                <thead>
                    <tr class="bg-gray-200 text-gray-600 uppercase text-sm leading-normal">
                        <th class="py-3 px-6 text-left">ID</th>
                        <th class="py-3 px-6 text-left">Comprobante Ref</th>
                        <th class="py-3 px-6 text-left">Fecha de Pago</th>
                        <th class="py-3 px-6 text-right">Monto Pagado</th>
                        <th class="py-3 px-6 text-left">Método de Pago</th>
                        <th class="py-3 px-6 text-left">Referencia</th>
                        <th class="py-3 px-6 text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody class="text-gray-600 text-sm font-light">
                    <c:forEach var="p" items="${pagos}">
                        <tr class="border-b border-gray-200 hover:bg-gray-100">
                            <td class="py-3 px-6 text-left whitespace-nowrap">${p.idPago}</td>
                            <td class="py-3 px-6 text-left font-medium">${p.numeroComprobanteRef}</td>
                            <td class="py-3 px-6 text-left">${p.fechaPago}</td>
                            <td class="py-3 px-6 text-right font-semibold text-green-600">S/. ${p.montoPagado}</td>
                            <td class="py-3 px-6 text-left">${p.metodoPago}</td>
                            <td class="py-3 px-6 text-left">${p.referencia}</td>
                            <td class="py-3 px-6 text-center">
                                <div class="flex item-center justify-center space-x-4">
                                    <a href="${pageContext.request.contextPath}/pagos?accion=editar&id=${p.idPago}" class="text-yellow-600 hover:text-yellow-900 font-semibold">Editar</a>
                                    <a href="${pageContext.request.contextPath}/pagos?accion=eliminar&id=${p.idPago}" onclick="return confirm('¿Estás seguro de eliminar este pago?');" class="text-red-600 hover:text-red-900 font-semibold">Eliminar</a>
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