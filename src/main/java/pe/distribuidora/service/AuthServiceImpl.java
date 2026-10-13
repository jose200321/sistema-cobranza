package pe.distribuidora.service;

import pe.distribuidora.config.ConexionBD;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AuthServiceImpl implements IAuthService {

    @Override
    public AuthResult login(String username, String password) {
        Connection conn = ConexionBD.getInstancia().getConnection();
        String sql = "UPDATE Usuarios SET intentosFallidos = 0, ultimoAcceso = NOW() WHERE nombreUsuario = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.executeUpdate();
            return new AuthResult(true, false, "Autenticación exitosa.");
        } catch (SQLException e) {
            e.printStackTrace();
            return new AuthResult(false, false, "Error al actualizar sesión.");
        }
    }
}