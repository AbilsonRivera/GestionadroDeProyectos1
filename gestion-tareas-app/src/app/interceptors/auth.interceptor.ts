import { Injectable } from '@angular/core';
import { HttpInterceptor, HttpRequest, HttpHandler, HttpEvent } from '@angular/common/http';
import { Observable } from 'rxjs';

@Injectable()
export class AuthInterceptor implements HttpInterceptor {
  intercept(req: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {
    // Obtén el token del almacenamiento
    const authToken = localStorage.getItem('token'); // Cambia esto si usas otro almacenamiento

    // Clona la solicitud y agrega el encabezado de autorización
    const authReq = authToken
      ? req.clone({
          headers: req.headers.set('Authorization', `Bearer ${authToken}`)
        })
      : req;

    return next.handle(authReq);
  }
}
