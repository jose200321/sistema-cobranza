package pe.distribuidora.repository;

import pe.distribuidora.model.Pago;
import java.util.List;

public interface IPagoRepository {
    List<Pago> listarTodos();
    Pago buscarPorId(int idPago);
    boolean registrar(Pago pago);
    boolean actualizar(Pago pago);
    boolean eliminar(int idPago);
}