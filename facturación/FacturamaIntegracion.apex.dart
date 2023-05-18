public class FacturamaIntegracion {

   private static final String FACTURAMA_API_URL = 'https://api.facturama.mx/';
   private static final String FACTURAMA_TOKEN = 'TU_TOKEN';
   private static final String FACTURAMA_SECRET = 'TU_SECRET';

  
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

   public static void createFactura() {
      String requestBody = '{ "client": { "name": "Cliente de prueba", "taxId": "ABC123" }, "items": [ { "productCode": "P001", "description": "Producto de prueba", "quantity": 1, "price": 100 } ] }';
  
      HttpResponse response = callFacturamaAPI('invoices', 'POST', requestBody);
      

      if (response.getStatusCode() == 201) {

         System.debug('Factura creada con éxito. Respuesta: ' + response.getBody());
      } else {

         System.debug('Error al crear la factura. Código de estado: ' + response.getStatusCode() + ', Respuesta: ' + response.getBody());
      }
   }
}
