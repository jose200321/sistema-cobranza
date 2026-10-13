package pe.distribuidora.service;

public class AuthResult {
    private final boolean exito;
    private final boolean bloqueado;
    private final String mensaje;

    public AuthResult(boolean exito, boolean bloqueado, String mensaje) {
        this.exito = exito;
        this.bloqueado = bloqueado;
        this.mensaje = mensaje;
    }

    public boolean isExito() { return exito; }
    public boolean isBloqueado() { return bloqueado; }
    public String getMensaje() { return mensaje; }
}