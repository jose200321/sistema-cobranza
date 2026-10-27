package pe.distribuidora.repository;

import pe.distribuidora.config.ConexionBD;
import pe.distribuidora.model.Usuario;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UsuarioRepositoryImpl implements IUsuarioRepository {
    
    

    @Override
    public List<Usuario> listarTodos() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT idUsuario, nombreUsuario, intentosFallidos, bloqueado, ultimoAcceso FROM Usuarios";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setIdUsuario(rs.getInt("idUsuario"));
                u.setNombreUsuario(rs.getString("nombreUsuario"));
                u.setIntentosFallidos(rs.getInt("intentosFallidos"));
                u.setBloqueado(rs.getInt("bloqueado"));
                u.setUltimoAcceso(rs.getTimestamp("ultimoAcceso"));
                lista.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Usuario buscarPorId(int idUsuario) {
        Usuario u = null;
        String sql = "SELECT idUsuario, nombreUsuario, intentosFallidos, bloqueado, ultimoAcceso FROM Usuarios WHERE idUsuario = ?";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    u = new Usuario();
                    u.setIdUsuario(rs.getInt("idUsuario"));
                    u.setNombreUsuario(rs.getString("nombreUsuario"));
                    u.setIntentosFallidos(rs.getInt("intentosFallidos"));
                    u.setBloqueado(rs.getInt("bloqueado"));
                    u.setUltimoAcceso(rs.getTimestamp("ultimoAcceso"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return u;
    }

    @Override
    public boolean registrar(Usuario usuario) {
        // Se incluyen rol_id y permiso_id exigidos por la estructura de tu tabla
        String sql = "INSERT INTO usuarios (nombreUsuario, contraseña, rol_id, permiso_id, intentosFallidos, bloqueado) VALUES (?, ?, 1, 1, 0, 0)";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, usuario.getNombreUsuario());
            ps.setString(2, usuario.getContraseña());
            int filasAfectadas = ps.executeUpdate();
            System.out.println("Filas insertadas: " + filasAfectadas);
            return filasAfectadas > 0;
        } catch (Exception e) {
            System.err.println("Error al registrar usuario: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean actualizar(Usuario usuario) {
        String sql = "UPDATE Usuarios SET nombreUsuario = ?, bloqueado = ? WHERE idUsuario = ?";
       try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, usuario.getNombreUsuario());
            ps.setInt(2, usuario.getBloqueado());
            ps.setInt(3, usuario.getIdUsuario());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(int idUsuario) {
        String sql = "DELETE FROM Usuarios WHERE idUsuario = ?";
       try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}