package app.Controllers;

import pe.distribuidora.service.AuthResult;
import pe.distribuidora.service.AuthServiceProxy;
import pe.distribuidora.service.IAuthService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private final IAuthService authService = new AuthServiceProxy();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        AuthResult resultado = authService.login(user, pass);

// Dentro de doPost en LoginServlet:
if (resultado.isExito()) {
    request.getSession().setAttribute("usuarioLogueado", user);
    // Redirección dinámica hacia la ruta /main del contexto
    response.sendRedirect(request.getContextPath() + "/main");
} else {
    request.setAttribute("error", resultado.getMensaje());
    request.setAttribute("bloqueado", resultado.isBloqueado());
    request.getRequestDispatcher("login.jsp").forward(request, response);
}
    }
}