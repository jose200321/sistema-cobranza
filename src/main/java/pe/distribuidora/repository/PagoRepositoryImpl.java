package pe.distribuidora.repository;

import pe.distribuidora.config.ConexionBD;
import pe.distribuidora.model.Pago;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PagoRepositoryImpl implements IPagoRepository {

    @Override
    public List<Pago> listarTodos() {
        List<Pago> lista = new ArrayList<>();
        String sql = "SELECT p.id_pago, p.id_comprobante, c.numero_comprobante, p.fecha_pago, " +
                     "p.monto_pagado, p.metodo_pago, p.referencia " +
                     "FROM pagos p INNER JOIN comprobantes c ON p.id_comprobante = c.id_comprobante";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Pago pago = new Pago();
                pago.setIdPago(rs.getInt("id_pago"));
                pago.setIdComprobante(rs.getInt("id_comprobante"));
                pago.setNumeroComprobanteRef(rs.getString("numero_comprobante"));
                pago.setFechaPago(rs.getDate("fecha_pago"));
                pago.setMontoPagado(rs.getBigDecimal("monto_pagado"));
                pago.setMetodoPago(rs.getString("metodo_pago"));
                pago.setReferencia(rs.getString("referencia"));
                lista.add(pago);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }

    @Override
    public Pago buscarPorId(int idPago) {
        Pago pago = null;
        String sql = "SELECT id_pago, id_comprobante, fecha_pago, monto_pagado, metodo_pago, referencia FROM pagos WHERE id_pago = ?";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idPago);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    pago = new Pago();
                    pago.setIdPago(rs.getInt("id_pago"));
                    pago.setIdComprobante(rs.getInt("id_comprobante"));
                    pago.setFechaPago(rs.getDate("fecha_pago"));
                    pago.setMontoPagado(rs.getBigDecimal("monto_pagado"));
                    pago.setMetodoPago(rs.getString("metodo_pago"));
                    pago.setReferencia(rs.getString("referencia"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pago;
    }

    @Override
    public boolean registrar(Pago pago) {
        String sql = "INSERT INTO pagos (id_comprobante, fecha_pago, monto_pagado, metodo_pago, referencia) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pago.getIdComprobante());
            ps.setDate(2, pago.getFechaPago() != null ? pago.getFechaPago() : new Date(System.currentTimeMillis()));
            ps.setBigDecimal(3, pago.getMontoPagado());
            ps.setString(4, pago.getMetodoPago());
            ps.setString(5, pago.getReferencia());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean actualizar(Pago pago) {
        String sql = "UPDATE pagos SET id_comprobante = ?, fecha_pago = ?, monto_pagado = ?, metodo_pago = ?, referencia = ? WHERE id_pago = ?";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, pago.getIdComprobante());
            ps.setDate(2, pago.getFechaPago());
            ps.setBigDecimal(3, pago.getMontoPagado());
            ps.setString(4, pago.getMetodoPago());
            ps.setString(5, pago.getReferencia());
            ps.setInt(6, pago.getIdPago());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean eliminar(int idPago) {
        String sql = "DELETE FROM pagos WHERE id_pago = ?";
        try (Connection conn = ConexionBD.getInstancia().getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, idPago);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}