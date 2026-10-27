<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${empty pago ? 'Nuevo Pago' : 'Editar Pago'} - Sistema de Cobranzas</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans leading-normal tracking-normal">
    <div class="container mx-auto px-4 py-8 max-w-xl">
        <div class="bg-white shadow-md rounded-lg p-6">
            <h1 class="text-2xl font-bold text-gray-800 mb-6">${empty pago ? 'Registrar Pago' : 'Editar Pago'}</h1>
            
            <form action="${pageContext.request.contextPath}/pagos" method="POST">
                <input type="hidden" name="idPago" value="${pago.idPago}">
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Comprobante Asociado</label>
                    <select name="idComprobante" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                        <option value="">Seleccione un comprobante</option>
                        <c:forEach var="comp" items="${comprobantes}">
                            <option value="${comp.idComprobante}" ${pago.idComprobante == comp.idComprobante ? 'selected' : ''}>
                                ${comp.numeroComprobante} - S/. ${comp.montoTotal} (${comp.estado})
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Fecha de Pago</label>
                    <input type="date" name="fechaPago" value="${pago.fechaPago}" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Monto Pagado (S/.)</label>
                    <input type="number" step="0.01" name="montoPagado" value="${pago.montoPagado}" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Método de Pago</label>
                    <select name="metodoPago" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                        <option value="EFECTIVO" ${pago.metodoPago == 'EFECTIVO' ? 'selected' : ''}>Efectivo</option>
                        <option value="TRANSFERENCIA" ${pago.metodoPago == 'TRANSFERENCIA' ? 'selected' : ''}>Transferencia</option>
                        <option value="YAPE" ${pago.metodoPago == 'YAPE' ? 'selected' : ''}>Yape</option>
                        <option value="PLIN" ${pago.metodoPago == 'PLIN' ? 'selected' : ''}>Plin</option>
                        <option value="TARJETA" ${pago.metodoPago == 'TARJETA' ? 'selected' : ''}>Tarjeta</option>
                    </select>
                </div>
                
                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Referencia / Nro. Operación</label>
                    <input type="text" name="referencia" value="${pago.referencia}" placeholder="Ej. Op-98765432" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                
                <div class="flex items-center justify-between">
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">Guardar</button>
                    <a href="${pageContext.request.contextPath}/pagos?accion=listar" class="text-gray-600 hover:text-gray-900 font-semibold">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>