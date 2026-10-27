package pe.distribuidora.controllers;

import pe.distribuidora.model.Cliente;
import pe.distribuidora.repository.ClienteRepositoryImpl;
import pe.distribuidora.repository.IClienteRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/clientes")
public class ClienteServlet extends HttpServlet {
    private IClienteRepository clienteRepository = new ClienteRepositoryImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                List<Cliente> lista = clienteRepository.listarTodos();
                request.setAttribute("clientes", lista);
                request.getRequestDispatcher("/admin/clientes.jsp").forward(request, response);
                break;
            case "nuevo":
                request.getRequestDispatcher("/admin/cliente-form.jsp").forward(request, response);
                break;
            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id"));
                Cliente clienteEditar = clienteRepository.buscarPorId(idEditar);
                request.setAttribute("cliente", clienteEditar);
                request.getRequestDispatcher("/admin/cliente-form.jsp").forward(request, response);
                break;
            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                clienteRepository.eliminar(idEliminar);
                response.sendRedirect(request.getContextPath() + "/clientes?accion=listar");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/clientes?accion=listar");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("idCliente");
        String tipoDoc = request.getParameter("tipoDocumento");
        String numDoc = request.getParameter("numeroDocumento");
        String razonSocial = request.getParameter("razonSocial");
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String email = request.getParameter("email");

        Cliente cliente = new Cliente();
        cliente.setTipoDocumento(tipoDoc);
        cliente.setNumeroDocumento(numDoc);
        cliente.setRazonSocial(razonSocial);
        cliente.setDireccion(direccion);
        cliente.setTelefono(telefono);
        cliente.setEmail(email);

        if (idStr == null || idStr.isEmpty()) {
            clienteRepository.registrar(cliente);
        } else {
            cliente.setIdCliente(Integer.parseInt(idStr));
            clienteRepository.actualizar(cliente);
        }

        response.sendRedirect(request.getContextPath() + "/clientes?accion=listar");
    }
}