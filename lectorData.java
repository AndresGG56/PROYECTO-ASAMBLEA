import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class lectorData {
    private String rutaDelArchivo;

    // Constructor
    public lectorData(String rutaDelArchivo) {
        this.rutaDelArchivo = rutaDelArchivo;
    }

    // Getter y Setter para rutaDelArchivo
    public String getRutaDelArchivo() {
        return rutaDelArchivo;
    }

    public void setRutaDelArchivo(String rutaDelArchivo) {
        this.rutaDelArchivo = rutaDelArchivo;
    }

    public void leerArchivo() {
        try (BufferedReader lector = new BufferedReader(new FileReader(rutaDelArchivo))) {
            // Leer la cabecera
            String lineaCabecera = lector.readLine();
            System.out.println(lineaCabecera);

            String linea;
            while ((linea = lector.readLine()) != null) {
                // Usar el espacio como delimitador
                String[] valores = linea.trim().split(";");
                System.out.println(
                        valores[0] + " ," + valores[1] + " , " + valores[2] + " , " + valores[3] + " , " + valores[4]);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void personaBuscar(String buscarNombre, String buscarApellido, String buscarTorre, String buscarApartamento,
            String buscarCc) {
        try (BufferedReader lector = new BufferedReader(new FileReader(rutaDelArchivo))) {
            // Leer la cabecera
            String lineaCabecera = lector.readLine();
            System.out.println(lineaCabecera);

            String linea;
            boolean encontrado = false;

            while ((linea = lector.readLine()) != null) {

                String[] valores = linea.trim().split(";");

                if (valores.length >= 5) {
                    if (valores[0].equalsIgnoreCase(buscarNombre) &&
                            valores[1].equalsIgnoreCase(buscarApellido) &&
                            valores[2].equalsIgnoreCase(buscarTorre) &&
                            valores[3].equalsIgnoreCase(buscarApartamento) &&
                            valores[4].equalsIgnoreCase(buscarCc)) {

                        System.out.println("Nombre: " + valores[0] +
                                ", Apellido: " + valores[1] +
                                ", Torre: " + valores[2] +
                                ", Apartamento: " + valores[3] +
                                ", Cédula: " + valores[4]);

                        encontrado = true; // Se encontró la persona
                        System.out.println("No es ningun impostor");
                        System.out.println("¡Persona registrada correctamente!");
                        break;


                        


















                    }
                }
            }

            if (!encontrado) {
                System.out.println("No se encontró ninguna persona que coincida con los criterios de búsqueda.");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
