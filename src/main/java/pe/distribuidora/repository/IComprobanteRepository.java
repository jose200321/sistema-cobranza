package pe.distribuidora.repository;

import pe.distribuidora.model.Comprobante;
import java.util.List;

public interface IComprobanteRepository {
    List<Comprobante> listarTodos();
    Comprobante buscarPorId(int idComprobante);
    boolean registrar(Comprobante comprobante);
    boolean actualizar(Comprobante comprobante);
    boolean eliminar(int idComprobante);
}