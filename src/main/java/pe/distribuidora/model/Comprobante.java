package pe.distribuidora.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Comprobante {
    private int idComprobante;
    private int idCliente;
    private String razonSocialCliente; // Útil para mostrar el nombre en las tablas de listado
    private String tipoComprobante;
    private String numeroComprobante;
    private Date fechaEmision;
    private Date fechaVencimiento;
    private BigDecimal montoTotal;
    private String estado;

    public Comprobante() {}

    // Getters y Setters
    public int getIdComprobante() { return idComprobante; }
    public void setIdComprobante(int idComprobante) { this.idComprobante = idComprobante; }

    public int getIdCliente() { return idCliente; }
    public void setIdCliente(int idCliente) { this.idCliente = idCliente; }

    public String getRazonSocialCliente() { return razonSocialCliente; }
    public void setRazonSocialCliente(String razonSocialCliente) { this.razonSocialCliente = razonSocialCliente; }

    public String getTipoComprobante() { return tipoComprobante; }
    public void setTipoComprobante(String tipoComprobante) { this.tipoComprobante = tipoComprobante; }

    public String getNumeroComprobante() { return numeroComprobante; }
    public void setNumeroComprobante(String numeroComprobante) { this.numeroComprobante = numeroComprobante; }

    public Date getFechaEmision() { return fechaEmision; }
    public void setFechaEmision(Date fechaEmision) { this.fechaEmision = fechaEmision; }

    public Date getFechaVencimiento() { return fechaVencimiento; }
    public void setFechaVencimiento(Date fechaVencimiento) { this.fechaVencimiento = fechaVencimiento; }

    public BigDecimal getMontoTotal() { return montoTotal; }
    public void setMontoTotal(BigDecimal montoTotal) { this.montoTotal = montoTotal; }

    public String getEstado() { return estado; }
    public void setEstado(String estado) { this.estado = estado; }
}