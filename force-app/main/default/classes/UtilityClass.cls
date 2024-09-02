
public class UtilityClass {
    public static String OPP_CLOSED_WON_STATUS = 'Closed Won';
    public static String OPP_CLOSED_LOST_STATUS = 'Closed Lost';
    public static String NEGOCIO_TIPO_GANADO = 'Ganado';
    public static String NEGOCIO_TIPO_PERDIDO = 'Perdido';
    
    public static void insertarListasDeNegocios (List <Negocio__c> newNegocios) {
        try {
            insert newNegocios;  
        } catch (Exception ex) {
            System.debug('Ocurrió un error: ' + ex);
        }
    }

    public static boolean esOportunidadCerrada(String StageName) {
        return (StageName == OPP_CLOSED_WON_STATUS || StageName == OPP_CLOSED_LOST_STATUS);
    }
}