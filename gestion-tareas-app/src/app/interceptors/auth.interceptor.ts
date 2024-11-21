import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http';
import { Observable } from 'rxjs';

// El decorador @Injectable marca la clase como inyectable en el sistema de dependencias de Angular
// Esto nos permite usar el interceptor en otros componentes o servicios.
@Injectable()
export class AuthInterceptor implements HttpInterceptor {

  // Este método intercepta todas las solicitudes HTTP que realiza la aplicación.
  // 'req' es la solicitud HTTP que está por ser realizada, y 'next' es el siguiente manejador que procesará la solicitud.
  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    
    // Intentamos obtener el token de autenticación del almacenamiento local del navegador (localStorage).
    const authToken = localStorage.getItem('token'); // Aquí obtenemos el token de autenticación.

    // Si existe un token de autenticación, clonamos la solicitud original y le añadimos el encabezado 'Authorization'.
    // Esto permite que todas las solicitudes que requieren autenticación lleven el token.
    const authReq = authToken
      ? req.clone({ // Clonamos la solicitud original
          headers: req.headers.set('Authorization', `Bearer ${authToken}`) // Añadimos el encabezado Authorization
        })
      : req; // Si no hay token, simplemente dejamos la solicitud sin modificar.

    // Finalmente, pasamos la solicitud (con o sin el token) al siguiente manejador en la cadena.
    // 'next.handle()' continúa el proceso de la solicitud HTTP.
    return next.handle(authReq);
  }
}
