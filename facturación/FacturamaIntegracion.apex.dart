public class FacturamaIntegracion {
   // Variables de configuración
   private static final String FACTURAMA_API_URL = 'https://api.facturama.mx/';
   private static final String FACTURAMA_TOKEN = 'TU_TOKEN';
   private static final String FACTURAMA_SECRET = 'TU_SECRET';

   // Método para realizar una llamada a Facturama
   public static HttpResponse callFacturamaAPI(String endpoint, String method, String requestBody) {
      HttpRequest request = new HttpRequest();
      request.setEndpoint(FACTURAMA_API_URL + endpoint);
      request.setMethod(method);
      request.setHeader('Content-Type', 'application/json');
      request.setHeader('Authorization', 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(FACTURAMA_TOKEN + ':' + FACTURAMA_SECRET)));
      request.setBody(requestBody);
      
      Http http = new Http();
      return http.send(request);
   }

   // Método de ejemplo para crear una factura en Facturama
   public static void createFactura() {
      // Construye el cuerpo de la solicitud con los datos de la factura
      String requestBody = '{ "client": { "name": "Cliente de prueba", "taxId": "ABC123" }, "items": [ { "productCode": "P001", "description": "Producto de prueba", "quantity": 1, "price": 100 } ] }';
      
      // Realiza la llamada a la API de Facturama para crear la factura
      HttpResponse response = callFacturamaAPI('invoices', 'POST', requestBody);
      
      // Maneja la respuesta de Facturama (por ejemplo, verifica el código de estado HTTP y procesa la respuesta)
      if (response.getStatusCode() == 201) {
         // Factura creada exitosamente
         System.debug('Factura creada con éxito. Respuesta: ' + response.getBody());
      } else {
         // Error al crear la factura
         System.debug('Error al crear la factura. Código de estado: ' + response.getStatusCode() + ', Respuesta: ' + response.getBody());
      }
   }
}
