package pe.distribuidora.repository;

import pe.distribuidora.config.ConexionBD;
import pe.distribuidora.model.Cliente;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteRepositoryImpl implements IClienteRepository {

    @Override
    public List<Cliente> listarTodos() {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT id_cliente, tipo_documento, numero_documento, razon_social, direccion, telefono, email FROM clientes";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Cliente c = new Cliente();
                c.setIdCliente(rs.getInt("id_cliente"));
                c.setTipoDocumento(rs.getString("tipo_documento"));
                c.setNumeroDocumento(rs.getString("numero_documento"));
                c.setRazonSocial(rs.getString("razon_social"));
                c.setDireccion(rs.getString("direccion"));
                c.setTelefono(rs.getString("telefono"));
                c.setEmail(rs.getString("email"));
                lista.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Cliente buscarPorId(int idCliente) {
        Cliente c = null;
        String sql = "SELECT id_cliente, tipo_documento, numero_documento, razon_social, direccion, telefono, email FROM clientes WHERE id_cliente = ?";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idCliente);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    c = new Cliente();
                    c.setIdCliente(rs.getInt("id_cliente"));
                    c.setTipoDocumento(rs.getString("tipo_documento"));
                    c.setNumeroDocumento(rs.getString("numero_documento"));
                    c.setRazonSocial(rs.getString("razon_social"));
                    c.setDireccion(rs.getString("direccion"));
                    c.setTelefono(rs.getString("telefono"));
                    c.setEmail(rs.getString("email"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return c;
    }

    @Override
    public boolean registrar(Cliente cliente) {
        String sql = "INSERT INTO clientes (tipo_documento, numero_documento, razon_social, direccion, telefono, email) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cliente.getTipoDocumento());
            ps.setString(2, cliente.getNumeroDocumento());
            ps.setString(3, cliente.getRazonSocial());
            ps.setString(4, cliente.getDireccion());
            ps.setString(5, cliente.getTelefono());
            ps.setString(6, cliente.getEmail());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean actualizar(Cliente cliente) {
        String sql = "UPDATE clientes SET tipo_documento = ?, numero_documento = ?, razon_social = ?, direccion = ?, telefono = ?, email = ? WHERE id_cliente = ?";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, cliente.getTipoDocumento());
            ps.setString(2, cliente.getNumeroDocumento());
            ps.setString(3, cliente.getRazonSocial());
            ps.setString(4, cliente.getDireccion());
            ps.setString(5, cliente.getTelefono());
            ps.setString(6, cliente.getEmail());
            ps.setInt(7, cliente.getIdCliente());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(int idCliente) {
        String sql = "DELETE FROM clientes WHERE id_cliente = ?";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idCliente);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}