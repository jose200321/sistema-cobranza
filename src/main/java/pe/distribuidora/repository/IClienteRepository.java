package pe.distribuidora.repository;

import pe.distribuidora.model.Cliente;
import java.util.List;

public interface IClienteRepository {
    List<Cliente> listarTodos();
    Cliente buscarPorId(int idCliente);
    boolean registrar(Cliente cliente);
    boolean actualizar(Cliente cliente);
    boolean eliminar(int idCliente);
}