<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${empty comprobante ? 'Nuevo Comprobante' : 'Editar Comprobante'} - Sistema de Cobranzas</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans leading-normal tracking-normal">
    <div class="container mx-auto px-4 py-8 max-w-xl">
        <div class="bg-white shadow-md rounded-lg p-6">
            <h1 class="text-2xl font-bold text-gray-800 mb-6">${empty comprobante ? 'Registrar Comprobante' : 'Editar Comprobante'}</h1>
            
            <form action="${pageContext.request.contextPath}/comprobantes" method="POST">
                <input type="hidden" name="idComprobante" value="${comprobante.idComprobante}">
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Cliente</label>
                    <select name="idCliente" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                        <option value="">Seleccione un cliente</option>
                        <c:forEach var="cli" items="${clientes}">
                            <option value="${cli.idCliente}" ${comprobante.idCliente == cli.idCliente ? 'selected' : ''}>
                                ${cli.razonSocial} (${cli.numeroDocumento})
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Tipo de Comprobante</label>
                    <select name="tipoComprobante" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                        <option value="FACTURA" ${comprobante.tipoComprobante == 'FACTURA' ? 'selected' : ''}>Factura</option>
                        <option value="BOLETA" ${comprobante.tipoComprobante == 'BOLETA' ? 'selected' : ''}>Boleta</option>
                        <option value="NOTA DE VENTA" ${comprobante.tipoComprobante == 'NOTA DE VENTA' ? 'selected' : ''}>Nota de Venta</option>
                    </select>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Número de Comprobante</label>
                    <input type="text" name="numeroComprobante" value="${comprobante.numeroComprobante}" placeholder="Ej. F001-000123" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Fecha de Emisión</label>
                    <input type="date" name="fechaEmision" value="${comprobante.fechaEmision}" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Fecha de Vencimiento</label>
                    <input type="date" name="fechaVencimiento" value="${comprobante.fechaVencimiento}" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Monto Total (S/.)</label>
                    <input type="number" step="0.01" name="montoTotal" value="${comprobante.montoTotal}" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                </div>
                
                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Estado</label>
                    <select name="estado" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                        <option value="PENDIENTE" ${comprobante.estado == 'PENDIENTE' ? 'selected' : ''}>Pendiente</option>
                        <option value="PAGADO" ${comprobante.estado == 'PAGADO' ? 'selected' : ''}>Pagado</option>
                        <option value="ANULADO" ${comprobante.estado == 'ANULADO' ? 'selected' : ''}>Anulado</option>
                    </select>
                </div>
                
                <div class="flex items-center justify-between">
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">Guardar</button>
                    <a href="${pageContext.request.contextPath}/comprobantes?accion=listar" class="text-gray-600 hover:text-gray-900 font-semibold">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>