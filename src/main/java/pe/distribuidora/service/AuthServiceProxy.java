package pe.distribuidora.service;

import pe.distribuidora.config.ConexionBD;
import pe.distribuidora.util.SecurityUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AuthServiceProxy implements IAuthService {

    private final IAuthService realService = new AuthServiceImpl();

    @Override
    public AuthResult login(String username, String password) {
        Connection conn = ConexionBD.getInstancia().getConnection();

        try {
            String sqlSelect = "SELECT contraseña, intentosFallidos, bloqueado FROM Usuarios WHERE nombreUsuario = ?";
            PreparedStatement ps = conn.prepareStatement(sqlSelect);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            if (!rs.next()) {
                return new AuthResult(false, false, "El usuario no existe.");
            }

            boolean bloqueado = rs.getBoolean("bloqueado");
            int intentos = rs.getInt("intentosFallidos");
            String hashBD = rs.getString("contraseña");

            if (bloqueado) {
                return new AuthResult(false, true, "Cuenta bloqueada por seguridad. Se cerrará la ventana.");
            }

            String hashIngresado = SecurityUtil.encriptarSHA256(password);

            if (hashBD.equals(hashIngresado)) {
                return realService.login(username, password);
            } else {
                intentos++;
                if (intentos >= 3) {
                    PreparedStatement psBlock = conn.prepareStatement(
                        "UPDATE Usuarios SET intentosFallidos = ?, bloqueado = TRUE WHERE nombreUsuario = ?"
                    );
                    psBlock.setInt(1, intentos);
                    psBlock.setString(2, username);
                    psBlock.executeUpdate();
                    return new AuthResult(false, true, "Ha alcanzado los 3 intentos fallidos. Usuario bloqueado.");
                } else {
                    PreparedStatement psUpdate = conn.prepareStatement(
                        "UPDATE Usuarios SET intentosFallidos = ? WHERE nombreUsuario = ?"
                    );
                    psUpdate.setInt(1, intentos);
                    psUpdate.setString(2, username);
                    psUpdate.executeUpdate();
                    return new AuthResult(false, false, "Contraseña errónea. Intento " + intentos + " de 3.");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return new AuthResult(false, false, "Error interno de base de datos.");
        }
    }
}