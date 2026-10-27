package pe.distribuidora.model;

import java.math.BigDecimal;
import java.sql.Date;

public class Pago {
    private int idPago;
    private int idComprobante;
    private String numeroComprobanteRef; // Útil para mostrar el número de comprobante en la vista
    private Date fechaPago;
    private BigDecimal montoPagado;
    private String metodoPago;
    private String referencia;

    public Pago() {}

    // Getters y Setters
    public int getIdPago() { return idPago; }
    public void setIdPago(int idPago) { this.idPago = idPago; }

    public int getIdComprobante() { return idComprobante; }
    public void setIdComprobante(int idComprobante) { this.idComprobante = idComprobante; }

    public String getNumeroComprobanteRef() { return numeroComprobanteRef; }
    public void setNumeroComprobanteRef(String numeroComprobanteRef) { this.numeroComprobanteRef = numeroComprobanteRef; }

    public Date getFechaPago() { return fechaPago; }
    public void setFechaPago(Date fechaPago) { this.fechaPago = fechaPago; }

    public BigDecimal getMontoPagado() { return montoPagado; }
    public void setMontoPagado(BigDecimal montoPagado) { this.montoPagado = montoPagado; }

    public String getMetodoPago() { return metodoPago; }
    public void setMetodoPago(String metodoPago) { this.metodoPago = metodoPago; }

    public String getReferencia() { return referencia; }
    public void setReferencia(String referencia) { this.referencia = referencia; }
}