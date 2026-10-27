package pe.distribuidora.controllers;

import pe.distribuidora.model.Comprobante;
import pe.distribuidora.model.Pago;
import pe.distribuidora.repository.ComprobanteRepositoryImpl;
import pe.distribuidora.repository.IComprobanteRepository;
import pe.distribuidora.repository.IPagoRepository;
import pe.distribuidora.repository.PagoRepositoryImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

@WebServlet("/pagos")
public class PagoServlet extends HttpServlet {
    private IPagoRepository pagoRepository = new PagoRepositoryImpl();
    private IComprobanteRepository comprobanteRepository = new ComprobanteRepositoryImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                List<Pago> lista = pagoRepository.listarTodos();
                request.setAttribute("pagos", lista);
                request.getRequestDispatcher("admin/pagos.jsp").forward(request, response);
                break;
            case "nuevo":
                List<Comprobante> comprobantesNuevo = comprobanteRepository.listarTodos();
                request.setAttribute("comprobantes", comprobantesNuevo);
                request.getRequestDispatcher("admin/pago-form.jsp").forward(request, response);
                break;
            case "editar":
                int idEditar = Integer.parseInt(request.getParameter("id"));
                Pago pagoEditar = pagoRepository.buscarPorId(idEditar);
                List<Comprobante> comprobantesEditar = comprobanteRepository.listarTodos();
                request.setAttribute("pago", pagoEditar);
                request.setAttribute("comprobantes", comprobantesEditar);
                request.getRequestDispatcher("admin/pago-form.jsp").forward(request, response);
                break;
            case "eliminar":
                int idEliminar = Integer.parseInt(request.getParameter("id"));
                pagoRepository.eliminar(idEliminar);
                response.sendRedirect(request.getContextPath() + "/pagos?accion=listar");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/pagos?accion=listar");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idStr = request.getParameter("idPago");
        int idComprobante = Integer.parseInt(request.getParameter("idComprobante"));
        Date fechaPago = Date.valueOf(request.getParameter("fechaPago"));
        BigDecimal montoPagado = new BigDecimal(request.getParameter("montoPagado"));
        String metodoPago = request.getParameter("metodoPago");
        String referencia = request.getParameter("referencia");

        Pago pago = new Pago();
        pago.setIdComprobante(idComprobante);
        pago.setFechaPago(fechaPago);
        pago.setMontoPagado(montoPagado);
        pago.setMetodoPago(metodoPago);
        pago.setReferencia(referencia);

        if (idStr == null || idStr.isEmpty()) {
            pagoRepository.registrar(pago);
        } else {
            pago.setIdPago(Integer.parseInt(idStr));
            pagoRepository.actualizar(pago);
        }

        response.sendRedirect(request.getContextPath() + "/pagos?accion=listar");
    }
}