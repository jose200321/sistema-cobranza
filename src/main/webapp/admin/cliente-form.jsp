<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>${empty cliente ? 'Nuevo Cliente' : 'Editar Cliente'} - Sistema de Cobranzas</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans leading-normal tracking-normal">
    <div class="container mx-auto px-4 py-8 max-w-xl">
        <div class="bg-white shadow-md rounded-lg p-6">
            <h1 class="text-2xl font-bold text-gray-800 mb-6">${empty cliente ? 'Registrar Nuevo Cliente' : 'Editar Cliente'}</h1>
            
            <form action="${pageContext.request.contextPath}/clientes" method="POST">
                <input type="hidden" name="idCliente" value="${cliente.idCliente}">
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Tipo de Documento</label>
                    <select name="tipoDocumento" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                        <option value="DNI" ${cliente.tipoDocumento == 'DNI' ? 'selected' : ''}>DNI</option>
                        <option value="RUC" ${cliente.tipoDocumento == 'RUC' ? 'selected' : ''}>RUC</option>
                        <option value="PASAPORTE" ${cliente.tipoDocumento == 'PASAPORTE' ? 'selected' : ''}>Pasaporte</option>
                    </select>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Número de Documento</label>
                    <input type="text" name="numeroDocumento" value="${cliente.numeroDocumento}" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Razón Social / Nombre Completo</label>
                    <input type="text" name="razonSocial" value="${cliente.razonSocial}" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Dirección</label>
                    <input type="text" name="direccion" value="${cliente.direccion}" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Teléfono</label>
                    <input type="text" name="telefono" value="${cliente.telefono}" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                
                <div class="mb-6">
                    <label class="block text-gray-700 text-sm font-bold mb-2">Correo Electrónico</label>
                    <input type="email" name="email" value="${cliente.email}" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                </div>
                
                <div class="flex items-center justify-between">
                    <button type="submit" class="bg-blue-600 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline">Guardar</button>
                    <a href="${pageContext.request.contextPath}/clientes?accion=listar" class="text-gray-600 hover:text-gray-900 font-semibold">Cancelar</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>