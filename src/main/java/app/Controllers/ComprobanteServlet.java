package app.Controllers;

import pe.distribuidora.model.Cliente;
import pe.distribuidora.model.Comprobante;
import pe.distribuidora.repository.ClienteRepositoryImpl;
import pe.distribuidora.repository.ComprobanteRepositoryImpl;
import pe.distribuidora.repository.IClienteRepository;
import pe.distribuidora.repository.IComprobanteRepository;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

@WebServlet("/comprobantes")
public class ComprobanteServlet extends HttpServlet {
    private IComprobanteRepository comprobanteRepository = new ComprobanteRepositoryImpl();
    private IClienteRepository clienteRepository = new ClienteRepositoryImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                List<Comprobante> lista = comprobanteRepository.listarTodos();
                request.setAttribute("comprobantes", lista);
                request.getRequestDispatcher("admin/comprobantes.jsp").forward(request, response);
                break;
            case "nuevo":
                List<Cliente> clientesNuevo = clienteRepository.listarTodos();
                request.setAttribute("clientes", clientesNuevo);
                request.getRequestDispatcher("admin/comprobante-form.jsp").forward(request, response);
                break;
            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id"));
                Comprobante compEditar = comprobanteRepository.buscarPorId(idEditar);
                List<Cliente> clientesEditar = clienteRepository.listarTodos();
                request.setAttribute("comprobante", compEditar);
                request.setAttribute("clientes", clientesEditar);
                request.getRequestDispatcher("admin/comprobante-form.jsp").forward(request, response);
                break;
            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                comprobanteRepository.eliminar(idEliminar);
                response.sendRedirect(request.getContextPath() + "/comprobantes?accion=listar");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/comprobantes?accion=listar");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("idComprobante");
        int idCliente = Integer.parseInt(request.getParameter("idCliente"));
        String tipoComprobante = request.getParameter("tipoComprobante");
        String numeroComprobante = request.getParameter("numeroComprobante");
        Date fechaEmision = Date.valueOf(request.getParameter("fechaEmision"));
        Date fechaVencimiento = Date.valueOf(request.getParameter("fechaVencimiento"));
        BigDecimal montoTotal = new BigDecimal(request.getParameter("montoTotal"));
        String estado = request.getParameter("estado");

        Comprobante comp = new Comprobante();
        comp.setIdCliente(idCliente);
        comp.setTipoComprobante(tipoComprobante);
        comp.setNumeroComprobante(numeroComprobante);
        comp.setFechaEmision(fechaEmision);
        comp.setFechaVencimiento(fechaVencimiento);
        comp.setMontoTotal(montoTotal);
        comp.setEstado(estado);

        if (idStr == null || idStr.isEmpty()) {
            comprobanteRepository.registrar(comp);
        } else {
            comp.setIdComprobante(Integer.parseInt(idStr));
            comprobanteRepository.actualizar(comp);
        }

        response.sendRedirect(request.getContextPath() + "/comprobantes?accion=listar");
    }
}