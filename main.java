import java.util.Scanner;

public class main {

    public static void main(String[] args) {

        int s = 0;
        int opc = 0;
        Scanner sc = new Scanner(System.in);

        lectorData lector = new lectorData("C:\\Users\\Public\\Documents\\data.csv");

        do {
            System.out.println("BIENVENIDO A LA ASAMBLEA CONJUNTO RESIDENCIAL GUZGUZ.");
            System.out.println("Seleccione (1) para iniciar sesión como administrador.");
            System.out.println("Seleccione (2) para salir.");
            System.out.print("Digite su opción: ");
            s = sc.nextInt();
            sc.nextLine(); // Limpia el buffer de entrada después de leer un número

            switch (s) {
                case 1:
                    logeoAdmin login = new logeoAdmin();
                    login.Inicio(sc);

                    do {

                        System.out.println("Seleccione (1) para visualizar la BigData.");
                        System.out.println("Seleccione (2) para realizar el registro de asistentes a la asamblea.");
                        System.out.println("Seleccione (3) para salir.");
                        System.out.print("Digite su opción: ");
                        opc = sc.nextInt();
                        sc.nextLine(); // Limpia el buffer después de leer un número

                        switch (opc) {
                            case 1:
                                System.out.println("BIGDATA.");
                                lector.leerArchivo();

                                break;

                            case 2:

                                System.out.println("Digite el nombre de la persona que desea buscar: ");
                                String nombreBuscado = sc.nextLine();
                                System.out.println("Digite el apellido de la persona a buscar: ");
                                String apellidoBuscado = sc.nextLine();
                                System.out.println("Digite la torre a buscar: ");
                                String buscarTorre = sc.nextLine();
                                System.out.println("Digite el apartamento a buscar: ");
                                String buscarApartamento = sc.nextLine();
                                System.out.println("Digite la cédula a buscar: ");
                                String buscarCc = sc.nextLine();

                                lector.personaBuscar(nombreBuscado, apellidoBuscado, buscarTorre, buscarApartamento,
                                        buscarCc);

                                break;

                            case 3:
                                System.out.println("Saliendo del menú de asamblea...");
                                break;

                            default:
                                System.out.println("Opción no válida. Inténtalo de nuevo.");
                                break;
                        }

                    } while (opc != 3);

                    break;

                case 2:
                    System.out.println("Saliendo del programa...");
                    break;

                default:
                    System.out.println("Opción no válida. Inténtalo de nuevo.");
                    break;
            }

        } while (s != 2);

        sc.close();
    }
}
