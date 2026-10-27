package pe.distribuidora.repository;

import pe.distribuidora.model.Usuario;
import java.util.List;

public interface IUsuarioRepository {
    List<Usuario> listarTodos();
    Usuario buscarPorId(int idUsuario);
    boolean registrar(Usuario usuario);
    boolean actualizar(Usuario usuario);
    boolean eliminar(int idUsuario);
}