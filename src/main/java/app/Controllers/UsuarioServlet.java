package app.Controllers;

import pe.distribuidora.model.Usuario;
import pe.distribuidora.repository.IUsuarioRepository;
import pe.distribuidora.repository.UsuarioRepositoryImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/usuarios")
public class UsuarioServlet extends HttpServlet {
    private IUsuarioRepository usuarioRepository = new UsuarioRepositoryImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "listar":
                List<Usuario> lista = usuarioRepository.listarTodos();
                request.setAttribute("usuarios", lista);
                // Cambia a "usuarios.jsp" si lo pusiste en la raíz, o déjalo en "admin/usuarios.jsp" si está en la carpeta admin
                request.getRequestDispatcher("admin/usuarios.jsp").forward(request, response);
                break;
            case "eliminar":
                int id = Integer.parseInt(request.getParameter("id"));
                usuarioRepository.eliminar(id);
                response.sendRedirect(request.getContextPath() + "/usuarios?accion=listar");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/usuarios?accion=listar");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println(">>> ¡ENTRÓ AL doPost DEL SERVLET DE USUARIOS! <<<");
        
        String nombre = request.getParameter("nombreUsuario");
        String clave = request.getParameter("contraseña");

        System.out.println("Datos leídos -> Usuario: " + nombre + " | Clave: " + clave);

        Usuario u = new Usuario();
        u.setNombreUsuario(nombre);
        u.setContraseña(clave);

        boolean registrado = usuarioRepository.registrar(u);
        System.out.println("¿Se registró correctamente en la BD?: " + registrado);

        response.sendRedirect(request.getContextPath() + "/usuarios?accion=listar");
    }
}