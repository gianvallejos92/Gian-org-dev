/**
 * Clase Utilidad que contiene métodos que pueden ser utilizados en cualquier clase de la org.
 * @author Gian Vallejos
 * @version 1.1 - 30/08/2024 - Buenas prácticas de código limpio aplicadas.
 * @since 1.0 - 29/08/2024 - Primera versión sin buenas prácticas de programación
 */
public class UtilityClass {
    public static String OPP_CLOSED_WON_STATUS = 'Closed Won';
    public static String OPP_CLOSED_LOST_STATUS = 'Closed Lost';
    public static String NEGOCIO_TIPO_GANADO = 'Ganado';
    public static String NEGOCIO_TIPO_PERDIDO = 'Perdido';

    /**
     * Inserta nuevos registros del objeto personalizado Negocio__c
     * @param newNegocios: Lista de Negocios a insertar
     */
    public static void insertarListasDeNegocios (List <Negocio__c> newNegocios) {
        try {
            insert newNegocios;  
        } catch (Exception ex) {
            System.debug('Ocurrió un error: ' + ex);
        }
    }

    /**
     * Verifica que el Stage de la oportunidad sea Closed Won o Closed Lost.
     * @param StageName: Estado de la oportunidad
     * @return Devuelve "true" si el estado de la oportunidad es Closed (Won o Lost), caso contrario, devuelve "false"
     */
    public static boolean esOportunidadCerrada(String StageName) {
        return (StageName == OPP_CLOSED_WON_STATUS || StageName == OPP_CLOSED_LOST_STATUS);
    }
}