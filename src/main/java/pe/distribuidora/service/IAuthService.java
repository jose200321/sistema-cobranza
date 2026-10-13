package pe.distribuidora.service;

public interface IAuthService {
    AuthResult login(String username, String password);
}