import java.util.Scanner;

public class logeoAdmin {

    private String usuarios[] = { "Juan", "Andres", "Santiago", "Daniel" };
    private int passDf = 123;
    private int pass;
    private String usuario;

    // Generando getters y setters
    public String[] getUsuarios() {
        return this.usuarios;
    }

    public void setUsuarios(String usuarios[]) {
        this.usuarios = usuarios;
    }

    public int getPassDf() {
        return this.passDf;
    }

    public void setPassDf(int passDf) {
        this.passDf = passDf;
    }

    public int getPass() {
        return this.pass;
    }

    public void setPass(int pass) {
        this.pass = pass;
    }

    public String getUsuario() {
        return this.usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    // Método para el inicio de sesión
    public void Inicio(Scanner sc) {
        boolean IngresoExitoso = false;

        do {
            System.out.println("*************************************");
            System.out.println("SISTEMA DE GESTION DE ASAMBLEAS.");
            System.out.println("*************************************");
            System.out.println("Digite su usuario de administrador:");
            usuario = sc.nextLine();
            System.out.println("Digite su contraseña:");
            pass = sc.nextInt();
            sc.nextLine(); // Limpiar el buffer

            for (int j = 0; j < usuarios.length; j++) {
                if (usuario.equals(usuarios[j]) && pass == passDf) {
                    IngresoExitoso = true;
                    System.out.println("Welcome to the system of Asambleas");
                    break;
                }
            }

            if (!IngresoExitoso) {
                System.out.println("Usuario o contraseña incorrectos.");
                System.out.println("Intente nuevamente.");
            }

        } while (!IngresoExitoso);
    }
}
