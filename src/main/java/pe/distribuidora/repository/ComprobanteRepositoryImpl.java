package pe.distribuidora.repository;

import pe.distribuidora.config.ConexionBD;
import pe.distribuidora.model.Comprobante;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ComprobanteRepositoryImpl implements IComprobanteRepository {

    @Override
    public List<Comprobante> listarTodos() {
        List<Comprobante> lista = new ArrayList<>();
        String sql = "SELECT c.id_comprobante, c.id_cliente, cl.razon_social, c.tipo_comprobante, " +
                     "c.numero_comprobante, c.fecha_emision, c.fecha_vencimiento, c.monto_total, c.estado " +
                     "FROM comprobantes c INNER JOIN clientes cl ON c.id_cliente = cl.id_cliente";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Comprobante comp = new Comprobante();
                comp.setIdComprobante(rs.getInt("id_comprobante"));
                comp.setIdCliente(rs.getInt("id_cliente"));
                comp.setRazonSocialCliente(rs.getString("razon_social"));
                comp.setTipoComprobante(rs.getString("tipo_comprobante"));
                comp.setNumeroComprobante(rs.getString("numero_comprobante"));
                comp.setFechaEmision(rs.getDate("fecha_emision"));
                comp.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
                comp.setMontoTotal(rs.getBigDecimal("monto_total"));
                comp.setEstado(rs.getString("estado"));
                lista.add(comp);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Comprobante buscarPorId(int idComprobante) {
        Comprobante comp = null;
        String sql = "SELECT id_comprobante, id_cliente, tipo_comprobante, numero_comprobante, " +
                     "fecha_emision, fecha_vencimiento, monto_total, estado FROM comprobantes WHERE id_comprobante = ?";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idComprobante);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    comp = new Comprobante();
                    comp.setIdComprobante(rs.getInt("id_comprobante"));
                    comp.setIdCliente(rs.getInt("id_cliente"));
                    comp.setTipoComprobante(rs.getString("tipo_comprobante"));
                    comp.setNumeroComprobante(rs.getString("numero_comprobante"));
                    comp.setFechaEmision(rs.getDate("fecha_emision"));
                    comp.setFechaVencimiento(rs.getDate("fecha_vencimiento"));
                    comp.setMontoTotal(rs.getBigDecimal("monto_total"));
                    comp.setEstado(rs.getString("estado"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return comp;
    }

    @Override
    public boolean registrar(Comprobante comprobante) {
        String sql = "INSERT INTO comprobantes (id_cliente, tipo_comprobante, numero_comprobante, fecha_emision, fecha_vencimiento, monto_total, estado) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, comprobante.getIdCliente());
            ps.setString(2, comprobante.getTipoComprobante());
            ps.setString(3, comprobante.getNumeroComprobante());
            ps.setDate(4, comprobante.getFechaEmision());
            ps.setDate(5, comprobante.getFechaVencimiento());
            ps.setBigDecimal(6, comprobante.getMontoTotal());
            ps.setString(7, comprobante.getEstado());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean actualizar(Comprobante comprobante) {
        String sql = "UPDATE comprobantes SET id_cliente = ?, tipo_comprobante = ?, numero_comprobante = ?, fecha_emision = ?, fecha_vencimiento = ?, monto_total = ?, estado = ? WHERE id_comprobante = ?";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, comprobante.getIdCliente());
            ps.setString(2, comprobante.getTipoComprobante());
            ps.setString(3, comprobante.getNumeroComprobante());
            ps.setDate(4, comprobante.getFechaEmision());
            ps.setDate(5, comprobante.getFechaVencimiento());
            ps.setBigDecimal(6, comprobante.getMontoTotal());
            ps.setString(7, comprobante.getEstado());
            ps.setInt(8, comprobante.getIdComprobante());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(int idComprobante) {
        String sql = "DELETE FROM comprobantes WHERE id_comprobante = ?";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idComprobante);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}